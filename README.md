# elmo

ELMO is our first go at a statistical leakage simulator for the ARM M0 family: https://www.usenix.org/conference/usenixsecurity17/technical-sessions/presentation/mccann

This project originated from the research of David McCann, originally funded by NCSC and then by EPSRC (LADA), Carolyn Whitnall, Elisabeth Oswald, and now also Si Gao, funded by EPSRC (LADA) and H2020 (REASSURE).

## Install ELMO
Technically speaking, ELMO is a standalone tool written in C. It should be able to compile in various platforms, as long as all dependent system libraries are correctly included. However, as the developers, we have only tested it on Ubuntu and Mac: support for Windows is not provided yet. There is a pre-complied binary program in the repository, which could possibally work for many linux-based systems. However, it is recommonded to re-compile ELMO source code and generate a new binary program for your system. To compile ELMO, one would need the GCC compiler collection (tested version 7.3.0 on Ubuntu) and command 'make' :
- Ubuntu: It would be easier to install GCC and make at the same time with "sudo apt install build-essential"
- Mac: Download and install “Command Line Tools for Xcode”, which is available on Apple’s developer page. After installation is completed, run “gcc -v” in a terminal to see whether you can see the correct version information.

To run any user-defined test case, users need to compile their codes to binary programe (".bin" file).  Technically, this is *NOT* a step in ELMO, as ELMO starts from analyzing the binary representation. ELMO does not invoke any specialised step in the standard ARM development cycle so it should be fine to stick with whatever develop flow users might have. However, in case anyone need a minimal working platform, he or she can install the GNU ARM Embedded Toolchain (tested version: arm-none-eabi-gcc version 7.3.1 20180622). We have tried ELMO with a few other versions of the GNU ARM toolchain: they all seem work out fine, although we can hardly make any promise.  The GNU ARM Embedded Toolchain can be downloaded from https://developer.arm.com/open-source/gnu-toolchain/gnu-rm. According to ARM's install guide:
- Ubuntu: Unpack the tarball to the install directory: "$ cd $install_dir && tar xjf gcc-arm-none-eabi-*-yyyymmdd-linux.tar.bz2"; then invoke ARM toolchain as "$ export PATH=$PATH:$install_dir/gcc-arm-none-eabi-*/bin; $ arm-none-eabi-gcc" (an older version is available through apt-get)
- Mac: Unpack the tarball to the install directory, like this "$ cd $install_dir && tar xjf gcc-arm-none-eabi-*-yyyymmdd-mac.tar.bz2"; then invoke ARM toolchain as "$ export PATH=$PATH:$install_dir/gcc-arm-none-eabi-*/bin; $ arm-none-eabi-gcc"

