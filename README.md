# elmo

ELMO is our first go at a statistical leakage simulator for the ARM M0 family: https://www.usenix.org/conference/usenixsecurity17/technical-sessions/presentation/mccann

This project originated from the research of David McCann, originally funded by NCSC and then by EPSRC (LADA), Carolyn Whitnall, Elisabeth Oswald, and now also Si Gao, funded by EPSRC (LADA) and H2020 (REASSURE).

## Install ELMO
Technically speaking, ELMO is a standalone tool written in C. It should be able to compile in various platforms, as long as all dependent system libraries are correctly included. However, as the developers, we have only tested it on Ubuntu and Mac: support for Windows is not provided yet. There is a pre-complied binary program in the repository, which could possibly work for many Linux-based systems. However, it is recommended to re-compile ELMO source code and generate a new binary program for your system. To compile ELMO, one would need the GCC compiler collection (tested version 7.3.0 on Ubuntu) and command 'make' :
- Ubuntu: It would be easier to install GCC and make at the same time with "sudo apt install build-essential"
- Mac: Download and install “Command Line Tools for Xcode”, which is available on Apple’s developer page. After installation is completed, run “gcc -v” in a terminal to see whether you can see the correct version information.

To run any user-defined test case, users need to compile their codes to binary programs (".bin" file).  Technically, this is *NOT* a step in ELMO, as ELMO starts from analyzing the binary representation. ELMO does not invoke any specialised step in the standard ARM development cycle so it should be fine to stick with whatever development flow users might have. However, in case anyone needs a minimal working platform, he or she can install the GNU ARM Embedded Toolchain (tested version: arm-none-eabi-gcc version 7.3.1 20180622). We have tried ELMO with a few other versions of the GNU ARM toolchain: they all seem fine, although we can hardly make any promise.  The GNU ARM Embedded Toolchain can be downloaded from https://developer.arm.com/open-source/gnu-toolchain/gnu-rm. According to ARM's install guide:
- Ubuntu: Unpack the tarball to the install directory: "$ cd $install_dir && tar xjf gcc-arm-none-eabi-*-yyyymmdd-linux.tar.bz2"; then invoke ARM toolchain as "$ export PATH=$PATH:$install_dir/gcc-arm-none-eabi-*/bin; $ arm-none-eabi-gcc" (an older version is available through apt-get)
- Mac: Unpack the tarball to the install directory, like this "$ cd $install_dir && tar xjf gcc-arm-none-eabi-*-yyyymmdd-mac.tar.bz2"; then invoke ARM toolchain as "$ export PATH=$PATH:$install_dir/gcc-arm-none-eabi-*/bin; $ arm-none-eabi-gcc"

## Using ELMO
For most users, we believe it is sufficient to follow the exact workflow provided in [the manual](ELMODocumentation.pdf). That means users should replace the target code section with their code and revise the Makefile so that the ARM toolchain can successfully produce the binary code. Note that only the critical part of the program should be examined: the rest non-security-related codes should be left out, as running ELMO with them not only adds unnecessary workload but also increase the risk of the encounter of unsupported bugs.

## Basic power model
In general, the following leakages might be captured with ELMO's power model:
- The weighted Hamming weight/distance on the data bus for operand  1 /operand 2 in the ALU (3-instruction time window)
- Second-order bit-interaction between adjacent bits/bitflips (only for shift instructions and multiplications)

Depending on the previous and the following instructions, such leakage combined with one another according to the model coefficients, which in the end, becomes the final power consumption.  The following terms are not included in the basic model, mainly because they failed to cause enough statistical significance in the original model building attempt:

- The bitflip of the target register (although this is by chance, duplicated by the bitflip of a certain operand bus)
- The leakage of the memory system (not significant in the dataset)
- Bit-interaction of non-adjacent bits (not significant enough in the dataset)
Note that the latter two are actually quite core-dependent: sometimes even [the same manufacturer may change micro-architectures in their product lines](https://github.com/sca-research/ShareSlicing_AES).

## Model coefficients
Over the years there are discussions (happening internally or externally) about whether it makes sense to keep maintaining the model coefficients in ELMO. Loosely speaking, this depends on the users' goal: although the main purpose of ELMO has always been a tool for early-stage leakage detection, we also understand that many users (even including ourselves) sometimes use ELMO as a trace generator. 

It is worthwhile to point out though, under the restriction of the acquisition effort and computation power, achieving both goals can be difficult. By definition, leakage detection is a "qualitative" process: as long as the p-value is lower than some threshold, we do not care about the actual p-value or the statistic, only the binary decision of whether the null hypothesis should be accepted or rejected. As long as the "quantity" is ignored, it may make sense to use some artificially made coefficients instead, say all 1-s. This approach may help users to quickly find out all potential problems, as no leakage will be concealed by other more significant leakage components. One example can be found in the appendix of [our paper](https://tches.iacr.org/index.php/TCHES/article/view/8396/7780), which stated the bit-interaction leakage, although does exist in ELMO's model, could not be detected until millions of traces, as the contribution of that term is relatively small in the whole power consumption. Although that is consistent with realistic experiments, in an early-stage detection, sometimes we prefer every potential threat to be found easily. Following that philosophy, it is absolutely fine to ignore the model coefficients.

On the other hand, the model coefficients are learned from the realistic power traces: the "learning" algorithm searches for the best-fitted model, in terms of producing closer outputs compared with the realistic traces. Cross-validation results show that such a model is indeed a valid simulation model for power consumption.  That is to say, if the user's goal is by any chance, a quantitative one, using these model coefficients would be a better idea. This includes but not limited to: attacks, power consumption estimation, information theory-based evaluation, etc.


## Additional Features
The following extensions have been added in the last a couple of years:
### Models from another M0 core (NXP LPC1114)
We have rebuilt ELMO's power model with another M0 core and compared the similarities and differences between the NXP one and the ST one. [Presentation on ARM Research Summit 2018](Modeling_M0_leakage_generically.pdf). The resultant [model coefficient file](coeffs_LPC.txt) can be found in the repository. ELMO will produce traces using this model, if the users renaming this file as "coeffs.txt" or changing the *COEFFSFILE* macro in *elmodefines.h* to  "coeffs_LPC.txt"

### Statistic inference
As TVLA did not explicitly explain the required number of traces, we added a feature that further explains the statistic result. Originally, it was designed to automatically decide the number of traces and execute T-test that way. However, in practice, it might be tricky for users, as the desired statistical power sometimes comes with an unbearable workload. The current setup is, the last line in the coefficient file represents the standardised effect size, which defines what differences will be regarded as "leaking". More details about effect size can be found in [Dr. Whitnall's paper](https://eprint.iacr.org/2019/1013.pdf). The current value in the coefficient file is 0.2 (a.k.a. "small"). Users can still select their own number of traces: in that specfic setup, ELMO will output the power of the test in the end of a fix v.s. random test.  Larger this value is, the more likely a larger or equal to 0.2 leakage will be found in our test. 

Alternatively, we have also added a small extension which can change the number of traces without re-compling the ARM binary (.bin file). To achieve this, one needs to write
`LoadNForTVLA(&N)`
then use *N* as number of traces. This API will read from ELMO's command line, the value after
`-autotvla`
will be written to *N*

### Model extension
As said in the basic power model section, there are a few potentially leaking components that do not exist in the current ELMO power model. Those terms are most-likely core-dependent, so adding them to the basic model can be tricky. 

Our experiment with our [assembly based masked AES implementation](https://github.com/sca-research/ASM_MaskedAES) explains some of these concerns. The [ROSITA paper](https://arxiv.org/pdf/1912.05183v1.pdf) also reflects similar issues on another M0 core (although not neccessarily in exactly the same form). If one is looking for some conservative advices on implementing masked ciphers, we do recommend to read those first so that he or she will not be easily trapped by ELMO's limitation on a specific core.

On the other hand, if one knows in priori what leakage term should be included, it is also possible to add an extension in ELMO. For instance, we can always adding some terms and rebuild the whole model. Note that the statistical inference is this approach could be quite tricky: it might be better to have a statistic expert who can supervise this process. Meanwhile, if our goal is completely "qualitative", we can also ignore the model building effort and directly adding this term into the overall power consumption. The following shows how this can be done with a memory extension:
- Assuming there are one bus/buffer for read bus and one for write. None of these will be cleared until the next memory access.
- Two 32-bit variables have been added to ELMO's data flow *data_flow* (*elmodefine.h*), representing the current read/write bus
- In *elmo.c*, all load/store instructions will update the corresponding variables in the data flow. For any other instructions, these two variables are copied from the previous instruction.
- A hamming distance term is added in  *elmopowermodel*(*powermodel.h*). This term will be zero for all the non-load/store instructions. The coefficient here is simply borrowed from one of the previous HD coefficients: readers can change it to to any non-zero value they want, as long as they won't be using the resultant traces "quantitatively".
- Eventually, a new macro called "MEMORY_EXTENSION" is added in *elmodefine.h*. When defined, ELMO will consider the contribution from the memory system.

Any further extension can follow similar steps. Note that the memory extension is usually quite core-depepent: if the memory manufacturer uses the same bus/buffer for the read/write buses, the leakage will be completely different. The address/data buses might have similar issues. Moreover, the bytewise load/store can be implemented in various ways. Therefore, users should at least have some confidence (whether through acquisition+statistic or learning the perhaps private designing details) before adding these extensions. 

