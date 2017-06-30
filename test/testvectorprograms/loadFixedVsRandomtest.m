%%
%% University of Bristol – Open Access Software Licence
%% Copyright (c) 2016, The University of Bristol, a chartered
%% corporation having Royal Charter number RC000648 and a charity
%% (number X1121) and its place of administration being at Senate
%% House, Tyndall Avenue, Bristol, BS8 1TH, United Kingdom.
%% All rights reserved
%%
%% Redistribution and use in source and binary forms, with or without
%% modification, are permitted provided that the following conditions
%% are met:
%%
%% 1. Redistributions of source code must retain the above copyright
%% notice, this list of conditions and the following disclaimer.
%%
%% 2. Redistributions in binary form must reproduce the above
%% copyright notice, this list of conditions and the following
%% disclaimer in the documentation and/or other materials provided
%% with the distribution.
%%
%% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
%% "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
%% LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
%% FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
%% COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
%% INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
%% (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
%% SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
%% HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
%% STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
%% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
%% OF THE POSSIBILITY OF SUCH DAMAGE.
%%
%% Any use of the software for scientific publications or commercial
%% purposes should be reported to the University of Bristol
%% (OSI-notifications@bristol.ac.uk and quote reference 2668). This is
%% for impact and usage monitoring purposes only.
%%
%% Enquiries about further applications and development opportunities
%% are welcome. Please contact elisabeth.oswald@bristol.ac.uk
%%

%% Code to load the masked sequence data and save as .mat

% Location of the simulated data:
folderSim = '../output/traces';
% Location to which you want to save the dataset:
folderMat = '../output/traces'; % e.g. 

% Clear the struct that we wish to write the data to:
clearvars t;
% (Known) number of traces:
totnumtraces = 5000;

%% Random data simulated traces

folder = sprintf('%s',folderSim);

% Read in simulated trace data:
fid = fopen(sprintf('%s//trace%05d.trc',folder,totnumtraces+1),'r');
temp = fscanf(fid,'%f')';
fclose(fid);
t.simtraceRandom = zeros(totnumtraces,length(temp));
t.simtraceRandom(1,:) = temp;
for nt = (totnumtraces+2):(totnumtraces*2)
    fid = fopen(sprintf('%s//trace%05d.trc',folder,nt),'r');
    if fid~=-1
        t.simtraceRandom(nt-totnumtraces,:) = fscanf(fid,'%f')';
        fclose(fid);
    else
        t.simtraceRandom(nt-totnumtraces,:) = NaN;
    end
end

%% Fixed data simulated traces

folder = sprintf('%s',folderSim);

% Read in simulated trace data:
fid = fopen(sprintf('%s//trace%05d.trc',folder,1),'r');
temp = fscanf(fid,'%f')';
fclose(fid);
t.simtraceFixed = zeros(totnumtraces,length(temp));
t.simtraceFixed(1,:) = temp;

for nt = 2:totnumtraces
    fid = fopen(sprintf('%s//trace%05d.trc',folder,nt),'r');
    if fid~=-1
        t.simtraceFixed(nt,:) = fscanf(fid,'%f')';
        fclose(fid);
    else
        t.simtraceFixed(nt,:) = NaN;
    end
end

% Save the data structure as a .mat:
%eval(sprintf('save ''%s//MaskedFixedVsRandom.mat'' -struct t',folderMat));

%%

ttestresults = (mean(t.simtraceFixed) - mean(t.simtraceRandom))./sqrt((var(t.simtraceFixed)./totnumtraces)+(var(t.simtraceRandom)./totnumtraces));

fp = fopen('ttesttestvectors.txt','w');

for i=1:size(ttestresults,2)
    fprintf(fp, '%0.12f\n',ttestresults(i));
end

fclose(fp);
