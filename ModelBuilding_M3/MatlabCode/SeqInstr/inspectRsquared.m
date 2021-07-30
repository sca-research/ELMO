%% Compute data-only R-squareds for every clock cycle and summarise:

% Load data in the following form:
% reducedtraces: Matrix of N trace measurements, 1 per clock cycle.
% input: 3x1 cell array, each containing an Nx2 matrix representing the
%   first and second input to the first, second and third instruction in 
%   the sequence.
% oplist: Mx1 cell array of labels for the operation codes (assumed to be
%   listed in numerical order).
% opcodes: Nx3 matrix of operation codes (bewteen 1 and M) describing the 
%   sequence.
t = load('FullModel_Reduced.mat');

% Choose the instruction of interest:
instr = 'eor';
% Find the corresponding numeric code:
i = find(strcmpi(t.oplist,instr),1,'first');

% Set a counter to index the sequences:
ind = 0;
% Initialise a variable to store the R-squareds for each sequence and each
% time point:
Rsquared = zeros(size(t.reducedtraces,2),numel(t.oplist)^2);
% Cell array for title labels:
titletxt = cell(1,numel(t.oplist)^2);
for j = 1:numel(t.oplist)
    for k = 1:numel(t.oplist)
        ind = ind+1;
        % Extract the indices corresponding to the selected sequence:
        idx = ismember(t.opcodes,[j,i,k],'rows');
        % Construct an explanatory matrix for a simple model of (first
        % order) data dependencies:
        A = [ones(sum(idx),1),zeros(sum(idx),128)];
        for bit = 1:32
            % Bits of the first input to the second instruction:
            A(:,bit+1) = bitget(t.input{2}(idx,1),bit);
            % Bits of the second input to the second instruction:
            A(:,bit+33) = bitget(t.input{2}(idx,2),bit);
            % Bit transitions of the first inputs to the first and second
            % instructions:
            A(:,bit+65) = bitget(bitxor(t.input{2}(idx,1),t.input{1}(idx,1)),bit);
            % Bit transitions of the second inputs to the first and second
            % instructions:
            A(:,bit+97) = bitget(bitxor(t.input{2}(idx,2),t.input{1}(idx,2)),bit);
        end
        % Fit the model to the data at each clock cycle point and extract
        % the R-squared (measure of model fit):
        for tr = 1:size(t.reducedtraces,2)
            [Btemp,BINT,R,RINT,STATS] = regress(t.reducedtraces(idx,tr),A);
            Rsquared(tr,ind) = STATS(1);
        end
        titletxt{ind} = sprintf('%s,%s',upper(t.oplist{j}),upper(t.oplist{k}));
    end
end

% Find the maximum point for each sequence, and the overall most common
% maximum:
[~,maxPt] = max(Rsquared,[],1);
modelPt = mode(maxPt);

% Derive a suitable y-axis for all the subplots:
yMax = ceil(max(Rsquared(:))*10)/10;

% Plot and summarise the outcomes. The most common index of best fit is
% marked in a red dotted line; the per-sequence best fit is marked with a
% red circle and the index annotated in the top left corner.
figure(1)
clf
for ind = 1:numel(t.oplist)^2
    subplot(numel(t.oplist),numel(t.oplist),ind)
    plot(Rsquared(:,ind));
    hold on;
    getaxis = axis;
    getaxis([3,4]) = [0,yMax];
    getaxis([1,2]) = [1,size(Rsquared,1)];
    axis(getaxis);
    plot(maxPt(ind),Rsquared(maxPt(ind),ind),'ro');
    plot([modelPt(i),modelPt(i)],[getaxis(3),getaxis(4)],'r:');
    title(titletxt{ind});
    text(0.1*abs(getaxis(2)-getaxis(1)),...
        getaxis(4)-(0.1*abs(getaxis(4)-getaxis(3))),sprintf('%.0f',maxPt(ind)));
    set(gca,'XTick',5:5:size(Rsquared,1),'XTickLabel',5:5:size(Rsquared,1));
end
%figure_format_size(i,20,20);
disp(sprintf('%s: Best choice is clock cycle %.0f',upper(t.oplist{i}),modelPt(i)));
