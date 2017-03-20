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
