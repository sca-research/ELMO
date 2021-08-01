%% Code to plot correlations between the trace and relevant Hamming weights

% This script aims to provide some preliminary insights on the per-sequence
% measured traces intended for use in model building. It takes in data of
% the form:
% input: 3x1 cell array, each containing an Nx2 matrix representing the
%   first and second input to the first, second and third instruction in 
%   the sequence.
% output: 3x1 cell array, each containing an Nx1 matrix representing the
%   output of the first, second and third instruction in the sequence
%   (where applicable).
% oplabels: 3x1 cell array containing the operation codes representing the
%   sequence.
% traces: NxM matrix of trace measurements corresponding to the inputs and
%   instruction sequence.

%% Load data and compute transitions:

% Load trace data (note that our example set isn't very good; ideally input
% a better one):
load('SingleInstr_add.mat');
% Mean-centre:
traces = traces-repmat(mean(traces,2),1,size(traces,2));
% Count the number of traces:
numtraces = size(traces,1);

% Compute all the various transitions (for the correlation graphs):
inputT = repmat({nan(numtraces,2)},1,3);
outputT = repmat({nan(numtraces,1)},1,3);
for i = 1:3
    if sum(isnan([output{i};output{mod(i,3)+1}]))==0
        outputT{i} = bitxor(output{i},output{mod(i,3)+1});
    end
    for j = 1:2
        if sum(isnan([input{i}(:,j);input{mod(i,3)+1}(:,j)]))==0
            inputT{i}(:,j) = bitxor(input{i}(:,j),input{mod(i,3)+1}(:,j));
        end
    end
end

%% Make graphs:

figure(1)
clf
subplot(2,3,1)
% Correlation between the traces and the Hamming weights of the
% inputs/output of the first instruction:
plot(corr(traces,HW([input{1},output{1}])))
% (Legends may need rearranging manually as the commands for setting the
% layout are highly involved and unpredictable enough that it is not
% generally worth trying to automate it perfectly).
legend({'in1','in2','out'},'Location','NorthEast');
title(sprintf('%s',upper(oplabels{1})))
newaxis = axis;
newaxis(2) = size(traces,2);
axis(newaxis);
subplot(2,3,2)
% Correlation between traces and the Hamming weights of the inputs/output 
% of the second instruction:
plot(corr(traces,HW([input{2},output{2}])))
title(sprintf('%s',upper(oplabels{2})))
newaxis = axis;
newaxis(2) = size(traces,2);
axis(newaxis);
subplot(2,3,3)
% Correlation between traces and the Hamming weights of the inputs/output 
% of the third instruction:
plot(corr(traces,HW([input{3},output{3}])))
title(sprintf('%s',upper(oplabels{3})))
newaxis = axis;
newaxis(2) = size(traces,2);
axis(newaxis);
subplot(2,3,4)
% Correlation between traces and the Hamming distances across the first 
% input bus:
plot(corr(traces,HW([inputT{1}(:,1),inputT{2}(:,1),inputT{3}(:,1)])))
legend({sprintf('%s->%s',upper(oplabels{1}),upper(oplabels{2})),sprintf('%s->%s',upper(oplabels{2}),upper(oplabels{3})),...
    sprintf('%s->%s',upper(oplabels{1}),upper(oplabels{3}))},'Location','NorthEast');
title('Input 1 transition')
newaxis = axis;
newaxis(2) = size(traces,2);
axis(newaxis);
subplot(2,3,5)
% Correlation between traces and the Hamming distances across the second
% input bus:
plot(corr(traces,HW([inputT{1}(:,2),inputT{2}(:,2),inputT{3}(:,2)])))
title('Input 2 transition')
newaxis = axis;
newaxis(2) = size(traces,2);
axis(newaxis);
subplot(2,3,6)
% Correlation between traces and the Hamming distances across the output 
% bus:
plot(corr(traces,HW([outputT{1},outputT{2},outputT{3}])))
title('Output transition')
newaxis = axis;
newaxis(2) = size(traces,2);
axis(newaxis);
% Re-size figure (still needs to be manually rearranged unfortunately):
%figure_format_size(gcf,10,20)