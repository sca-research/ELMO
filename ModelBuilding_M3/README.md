# Rebuild ELMO's power model on M3

Although ELMO itself was built exclusively on one specific Cortex M0 core, whether the methodology applies to other 3-pipeline ARM Cortex M series cores is still a mystery. For instance, in its original proposal, another Cortex M4 core is considered: the methodology still works, yet the weaker measurement setup (EM) affects the overall modelling confidence. 

In other words, if the measurement setup is 'good', it is possible to rebuild ELMO's model for other Cortex M cores. Thanks to Dr Page's SCALE project(https://github.com/danpage/scale), we now have access to another Cortex M3 core with high-quality measurements. In the following, we document how to rebuild ELMO's model with our [model building code](../Model Building Code).

## Measurements

### Sequence of instructions
Using the original ELMO's 5 clusters of instructions, we have written a piece of code that covers all 125 combinations at "*ModelBuilding_M3/ARMCode/SeqInstr*". Note that if one wishes to change the clustering, this code needs to be rewritten. Our tested example uses 8 MHz as the working frequency, which needs to be adjusted in the board support package (BSP).

The measuring script lies in "*ModelBuilding_M3/AcqCode/BuildModel_M3_Full.py*" (using Picoscope 5000 series): if all setups are correct, running this script will produce a Riscure TRS file "*ModelBuilding_M3/DataSet/BuildModel_M3_Full_1000Samples_repeat10.trs*". 

## Matlab analysis
### Select one sample per cycle
For 8 MHz, each cycle lasts for 125 ns. The sampling rate is 500MSa/s, so 62.5 points per cycle. We assume each cycle we choose the same point, as *POI=floor(ind+[0:1:15]*62.5)*, so the task now is figuring out *ind* through correlation/R2 analysis.

"*ModelBuilding_M3/MatlabCode/SeqInstr/ReadTRS_PowerModel.m*" reads the TRS data into Matlab. 'oplist.mat' contains the operand name list. Run "*POI_Leakage.m*" will produce the R2 traces for all 125 combinations. Finding the point that contains as many as the highest R2 possible and finding out *ind*.  We select *ind=33*.

### Select target cycle
Compress the full traces to one sample per cycle. In Matlab, this means "*reducedtraces=fulltraces(:,POI);*", then store the necessary variables in a *.mat* file.

Loading the same .mat file in "*inspectRsquared.m*": running the script should tell us which cycle should be selected. In our case, the script says we should choose cycle 7.

### Release the newly built model
Compress the full traces to one sample representing cycle 7 only, then store the necessary variables in a *.mat* file. 
Loading the same .mat file in "*ReleaseModelMethod.m*":  running the script will produce a coefficient file named "*coeffs_M3.txt*". Copying this file to the root directory of ELMO and revising the code in "*elmodefines.h*": change "#define COEFFSFILE" to "*coeffs_M3.txt*" and recompile ELMO. ELMO will use the M3 model instead from now on.

