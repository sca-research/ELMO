
% CW: It's important to explicitly code any relationships so that dependent
% values are automatically updated when free variables are changed:

load('testrandomdatamatlab.mat');
load('CoefficientsExt.mat');

fp = fopen('powermodeltestvectors.txt','w');

number = 1;

% CW: Hmm, hard-coding the indices as you have done looks a bit problematic to 
% me ... what if something changes in the Coefficients.mat file, or you 
% make a typo? How about:

constant = coeffs(indices{1,1},:);
PrvInstr = coeffs(indices{2,1},:)';
SubInstr = coeffs(indices{3,1},:)';
Operand1 = coeffs(indices{4,1},:)';
Operand2 = coeffs(indices{5,1},:)';
BitFlip1 = coeffs(indices{6,1},:)';
BitFlip2 = coeffs(indices{7,1},:)';
HWOp1PrvInstr = coeffs(indices{8,1},:)';
HWOp2PrvInstr = coeffs(indices{9,1},:)';
HDOp1PrvInstr = coeffs(indices{10,1},:)';
HDOp2PrvInstr = coeffs(indices{11,1},:)';
HWOp1SubInstr = coeffs(indices{12,1},:)';
HWOp2SubInstr = coeffs(indices{13,1},:)';
HDOp1SubInstr = coeffs(indices{14,1},:)';
HDOp2SubInstr = coeffs(indices{15,1},:)';
Operand1_bitinteractions = coeffs(indices{16,1},:)';
Operand2_bitinteractions = coeffs(indices{17,1},:)';
BitFlip1_bitinteractions = coeffs(indices{18,1},:)';
BitFlip2_bitinteractions = coeffs(indices{19,1},:)';

for k = 1:5
    for l = 1:5
        for m = 1:5
            
            datapoint = 1;

            instructiontype(1) = k;
            instructiontype(2) = l;
            instructiontype(3) = m;

            % instructiontype_bin = zeros(3,4);

            for j = 1:number

                instructiontype_bin = zeros(3,4);

                for i = 1:3
                    op1(i) = data(datapoint);
                    datapoint = datapoint + 1;
                    op2(i) = data(datapoint);
                    datapoint = datapoint + 1;
                    
                    if instructiontype(i)~=1
                        instructiontype_bin(i,instructiontype(i)-1) = 1;
                    end
                end

                op1binary(1,:) = de2bi(op1(1),32); op1binary(2,:) = de2bi(op1(2),32); op1binary(3,:) = de2bi(op1(3),32);
                op2binary(1,:) = de2bi(op2(1),32); op2binary(2,:) = de2bi(op2(2),32); op2binary(3,:) = de2bi(op2(3),32);

                hw_op1 = hweight(op1(2));
                hw_op2 = hweight(op2(2));

                % CW: Is there a reason you don't want to use the following?
                hd_op1 = hweight(bitxor(op1(1),op1(2)));
                hd_op2 = hweight(bitxor(op2(1),op2(2)));

                op1_bitflip = de2bi(bitxor(op1(2),op1(1)),32);
                op2_bitflip = de2bi(bitxor(op2(2),op2(1)),32);

                count = 1;

                for i=1:32
                    for j=i+1:32

                        op1bitinteractions(count) = op1binary(2,i)*op1binary(2,j);
                        op2bitinteractions(count) = op2binary(2,i)*op2binary(2,j);

                        op1bitflipbitinteractions(count) = op1_bitflip(i)*op1_bitflip(j);
                        op2bitflipbitinteractions(count) = op2_bitflip(i)*op2_bitflip(j);

                        count = count + 1;

                    end
                end

                % Input binary hamming weights
                Operand1_data = sum(Operand1(instructiontype(2),:).*op1binary(2,:));
                Operand2_data = sum(Operand2(instructiontype(2),:).*op2binary(2,:));

                % Input binary hamming distance
                BitFlip1_data = sum(BitFlip1(instructiontype(2),:).*op1_bitflip);
                BitFlip2_data = sum(BitFlip2(instructiontype(2),:).*op2_bitflip);

                % Previous and subsequent factors
                PrvInstr_data = sum(PrvInstr(instructiontype(2),:).*instructiontype_bin(1,:));
                SubInstr_data = sum(SubInstr(instructiontype(2),:).*instructiontype_bin(3,:));

                % Hamming weight of previous
                HWOp1PrvInstr_data = sum(HWOp1PrvInstr(instructiontype(2),:).*instructiontype_bin(1,:).*hw_op1);
                HWOp2PrvInstr_data = sum(HWOp2PrvInstr(instructiontype(2),:).*instructiontype_bin(1,:).*hw_op2);

                % Hamming distance of previous
                HDOp1PrvInstr_data = sum(HDOp1PrvInstr(instructiontype(2),:).*instructiontype_bin(1,:).*hd_op1);
                HDOp2PrvInstr_data = sum(HDOp2PrvInstr(instructiontype(2),:).*instructiontype_bin(1,:).*hd_op2);

                % Hamming weight of subsequence
                HWOp1SubInstr_data = sum(HWOp1SubInstr(instructiontype(2),:).*instructiontype_bin(3,:).*hw_op1);
                HWOp2SubInstr_data = sum(HWOp2SubInstr(instructiontype(2),:).*instructiontype_bin(3,:).*hw_op2);

                % Hamming distance of subsequent
                HDOp1SubInstr_data = sum(HDOp1SubInstr(instructiontype(2),:).*instructiontype_bin(3,:).*hd_op1);
                HDOp2SubInstr_data = sum(HDOp2SubInstr(instructiontype(2),:).*instructiontype_bin(3,:).*hd_op1);

                % Bit interactions individual bits
                Operand1_bitinteractions_data = sum(Operand1_bitinteractions(instructiontype(2),:).*op1bitinteractions);
                Operand2_bitinteractions_data = sum(Operand2_bitinteractions(instructiontype(2),:).*op2bitinteractions);

                % Bit interactions bitflips
                BitFlip1_bitinteractions_data = sum(BitFlip1_bitinteractions(instructiontype(2),:).*op1bitinteractions);
                BitFlip2_bitinteractions_data = sum(BitFlip2_bitinteractions(instructiontype(2),:).*op1bitinteractions);

                % Sum total of values is leakage
                power = constant(instructiontype(2)) + PrvInstr_data + SubInstr_data + Operand1_data + Operand2_data...
                    + BitFlip1_data + BitFlip2_data + HWOp1PrvInstr_data + HWOp2PrvInstr_data + HDOp1PrvInstr_data...
                    + HDOp2PrvInstr_data + HWOp1SubInstr_data + HWOp2SubInstr_data + HDOp1SubInstr_data + HDOp2SubInstr_data...
                    + Operand1_bitinteractions_data + Operand2_bitinteractions_data + BitFlip1_bitinteractions_data + BitFlip2_bitinteractions_data;

                fprintf(fp, '%0.20f\n',power);
                
            end
        end
    end
end

    
%% Alternative formulation to make multiple predictions in one computation

% CW: Create a (one row, in this case) 'A' matrix:
% A = [1,instructiontype_bin(1,:),instructiontype_bin(3,:),op1binary(2,:),op2binary(2,:),...
%     op1_bitflip,op2_bitflip,hw_op1*instructiontype_bin(1,:),hw_op2*instructiontype_bin(1,:),...
%     hd_op1*instructiontype_bin(1,:),hd_op2*instructiontype_bin(1,:),...
%     hw_op1*instructiontype_bin(3,:),hw_op2*instructiontype_bin(3,:),...
%     hd_op1*instructiontype_bin(3,:),hd_op2*instructiontype_bin(3,:),...
%     op1binary(2,B(:,1)).*op1binary(2,B(:,2)), op2binary(2,B(:,1)).*op2binary(2,B(:,2)),...
%     op1binary(2,B(:,1)).*op1binary(2,B(:,2)), op1_bitflip(B(:,1)).*op1_bitflip(B(:,2)), op2_bitflip(B(:,1)).*op2_bitflip(B(:,2))];

% (Note that once hw_op1 etc are vectors, the interaction terms will have
% to be computed a slightly more complicated way, e.g. using bsxfun).

% Create the corresponding vector of coefficients:
% beta = coeffs{1}(:,instructiontype(2));
% prediction = A*beta
% Hmm, interestingly, there's a fractional difference between this and
% above; on varying the inputs it seems to be just rounding, but I need to
% investigate to find out which is more precise.

% I hope that it is clear to you that A can just as easily be a matrix of
% several rows, each corresponding to THE SAME INSTRUCTIONTYPE(2) but 
% otherwise different input values. beta remains a vector but is selected 
% according to instructiontype(2) so predictions for different target
% instructions are performed in different computations. 

% Note also that some of the operations in the previous sections are
% redundant, and those which are necessary can (and should) also be
% performed on vectors or matrices. E.g. for three observations such as:
% instructiontype = [4,x,5; 3,x,4; 1,x,3]; %(i.e. for x the target)
% op1 = [0,58,0; 1,52,3; 34,152,2];
% op2 = [98,98,0; 7,203,57; 67,0,25];
% there are ways to perform most of the intermediate operations required to
% construct A matrix-wise without resorting to loops. You then "matrix
% right-multiply" A by beta = coffs{1}(:,x), i.e. the choice of beta
% depends on x.