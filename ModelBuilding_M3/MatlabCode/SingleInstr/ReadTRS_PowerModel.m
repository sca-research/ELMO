%% Load Riscure TRS data for building model with MOV-INSTR-MOV sequences

% Open Binary TRS File
[fid, msg] = fopen('/home/IWAS/gaosi/Documents/ELMO_Git/ELMO/ModelBuilding_M3/DataSet/BuildModel_M3_Single_1000Samples.trs','rb');

%Load TRS Header
floatflag=false;%float data/int8 data
% Create data header
clearvars header;
while(true)
    [mark]=fread(fid,1,'uint8');
    [len]=fread(fid,1,'uint8');
    %whether the data uses float point value or unsigned int8 value 
    HeaderEnd=false;
    switch mark
        case hex2dec('41')
            [Model_header.TraceNum]=fread(fid,1,'uint32');
        case hex2dec('42')
            [Model_header.SampleNum]=fread(fid,1,'uint32');
        case hex2dec('43')  
            [Model_header.SampleCoding] = fread(fid,1,'uint8');
            if (bitand(Model_header.SampleCoding,hex2dec('10'))>0)
                floatflag=true;
            end
        case hex2dec('44') 
            [Model_header.CryptoDataLen] = fread(fid,1,'uint16');
        case hex2dec('45')
            [Model_header.TraceTitle] = fread(fid,1,'char');
        case hex2dec('46')
            [Model_header.GlobalTraceTitle]=fread(fid,len,'char');
        case hex2dec('47')
            [Model_header.Discription]=fread(fid,len,'char');
        case hex2dec('48')
            [Model_header.Xoffset] = fread(fid,1,'int32');
        case hex2dec('49')
            [Model_header.XLabel]=fread(fid,len,'char');
        case hex2dec('4a')
            [Model_header.YLabel]=fread(fid,len,'char');
        case hex2dec('4b')
            [Model_header.Xscale]=fread(fid,1,'float');
        case hex2dec('4c')
            [Model_header.Yscale]=fread(fid,1,'float');
        case hex2dec('4d')
            [Model_header.TraceOffset]=fread(fid,1,'int32');   
        case hex2dec('4e')
            [Model_header.LogScale]=fread(fid,1,'uint8'); 
        otherwise
            HeaderEnd=true;
    end
    if(HeaderEnd)
        break;
    end
end


%Read plaintext/ciphertext and trace data
fulltraces=zeros(Model_header.TraceNum,Model_header.SampleNum);
opcodes=zeros(Model_header.TraceNum,3);
input{1}=zeros(Model_header.TraceNum,2);
input{2}=zeros(Model_header.TraceNum,2);
input{3}=zeros(Model_header.TraceNum,2);
result=zeros(Model_header.TraceNum,1);
for i=1:1:Model_header.TraceNum
    input{1}(i,1)=fread(fid,1,'uint32');
    input{1}(i,2)=fread(fid,1,'uint32');
    input{2}(i,1)=fread(fid,1,'uint32');
    input{2}(i,2)=fread(fid,1,'uint32');
    input{3}(i,1)=fread(fid,1,'uint32');
    input{3}(i,2)=fread(fid,1,'uint32');   
    address=fread(fid,1,'uint32');
    %Single Instruction Model
    opcodes(i,1)=14;
    opcodes(i,2)=fread(fid,1,'uint8');
    opcodes(i,3)=14;
    if(opcodes(i,2)==2 || opcodes(i,2)==5|| opcodes(i,2)==15|| opcodes(i,2)==23)
        input{2}(i,2)=0;
    end
    if(opcodes(i,2)==11 || opcodes(i,2)==13)
        input{2}(i,2)=1;
    end
    %Full instrustions Model
    %temp=fread(fid,1,'uint8');
    %opcodes(i,1)=floor(temp/25)+1;
    %temp=mod(temp,25);
    %opcodes(i,2)=floor(temp/5)+1;
    %temp=mod(temp,5);
    %opcodes(i,3)=temp+1;
    % Skip the rest useless info
    fread(fid,Model_header.CryptoDataLen/2-29,'uint8');
    result(i,1)=fread(fid,1,'uint32');
    fread(fid,Model_header.CryptoDataLen/2-4,'uint8');
    % Read Trace
    if(floatflag)
      fulltraces(i,:)=fread(fid,Model_header.SampleNum,'float');
    else
      fulltraces(i,:)=fread(fid,Model_header.SampleNum,'short');
    end
end
% Mean-adjusted traces (to get rid of drift over the course of the
% acquisition):
fulltraces = bsxfun(@minus, fulltraces, mean(fulltraces,2));
%fulltraces=fulltraces(:,2001:9000);
fclose(fid);
clear mark fid floatflag HeaderEnd address len i temp;

% Rename to fit with inspectCorrelations.m
input1= reshape(input, size(input));
for i=1:1:1
    traces=fulltraces((i-1)*5000+1:i*5000,:);
    output{1}=input1{1}((i-1)*5000+1:i*5000,2);
    output{2}=result((i-1)*5000+1:i*5000);
    output{3}=input1{3}((i-1)*5000+1:i*5000,2);
    input{1}=input1{1}((i-1)*5000+1:i*5000,:);
    input{2}=input1{2}((i-1)*5000+1:i*5000,:);
    input{3}=input1{3}((i-1)*5000+1:i*5000,:);
    oplabels{1}='mov';
    oplabels{2}=oplist{opcodes((i-1)*5000+1,2)};
    oplabels{3}='mov';
    filename="SingleInstr_"+oplabels{2}+".mat";
    save(filename,'traces','output','input','oplabels');
end

%After finding the POI in inspectCorrelations.m, compress each cycle to 1
%sample
% oplist must be loaded seperatly, as load('oplist.mat')
%POI=floor(27+[0:1:15]*62.5);
%reducedtraces=fulltraces(:,POI);
%save('SingleInstr_Reduced.mat','reducedtraces','oplist','opcodes','input');
