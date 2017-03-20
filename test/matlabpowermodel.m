
% CW: It's important to explicitly code any relationships so that dependent
% values are automatically updated when free variables are changed:

load('testrandomdatamatlab.mat');
load('CoefficientsExtEC.mat');

fp = fopen('powermodeltestvectors.txt','w');

inputs = data;
data = 0;

number = 1000;
t = 1;
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
            
            
            clear PrvInstr_data SubInstr_data Operand1_data Operand2_data BitFlip1_data BitFlip2_data HWOp1PrvInstr_data HWOp2PrvInstr_data HDOp1PrvInstr_data HDOp2PrvInstr_data HWOp1SubInstr_data HWOp2SubInstr_data HDOp1SubInstr_data HDOp2SubInstr_data
           
            instructiontype(1) = k;
            instructiontype(2) = l;
            instructiontype(3) = m;
            
            instructiontype_bin = zeros(3,4);
            for z = 1:3
                if instructiontype(z)~=1
                    instructiontype_bin(z,instructiontype(z)-1) = 1;
                end
            end
            % instructiontype_bin = zeros13,4);
        
            t = 1;
            for n = 1:number
                for i = 1:3
                    data  = 0;
                    data = bitxor(bitshift(inputs(t), 0),data);
                    data = bitxor(bitshift(inputs(t+1), 8),data);
                    data = bitxor(bitshift(inputs(t+2), 16),data);
                    data = bitxor(bitshift(inputs(t+3), 24),data);
                    op1(i) = data;
                    
                    dec2hex(data);
                    
                    t = t + 4;
                    
                    data  = 0;
                    data = bitxor(bitshift(inputs(t), 0),data);
                    data = bitxor(bitshift(inputs(t+1), 8),data);
                    data = bitxor(bitshift(inputs(t+2), 16),data);
                    data = bitxor(bitshift(inputs(t+3), 24),data);
                    op2(i) = data;
                    
                    dec2hex(data);
                    
                    t = t + 4;
                    
                    if(instructiontype(i) == 3)
                        temp = op1(i);
                        op1(i) = op2(i);
                        op2(i) = temp;
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
                HDOp2SubInstr_data = sum(HDOp2SubInstr(instructiontype(2),:).*instructiontype_bin(3,:).*hd_op2);

                % Bit interactions individual bits
                Operand1_bitinteractions_data = sum(Operand1_bitinteractions(instructiontype(2),:).*op1bitinteractions);
                Operand2_bitinteractions_data = sum(Operand2_bitinteractions(instructiontype(2),:).*op2bitinteractions);

                % Bit interactions bitflips
                BitFlip1_bitinteractions_data = sum(BitFlip1_bitinteractions(instructiontype(2),:).*op1bitinteractions);
                BitFlip2_bitinteractions_data = sum(BitFlip2_bitinteractions(instructiontype(2),:).*op2bitinteractions);
                
%                 l
%                 constant(instructiontype(2))
%                 PrvInstr_data 
%                 SubInstr_data 
%                 Operand1_data 
%                 Operand2_data 
%                 BitFlip1_data 
%                 BitFlip2_data 
%                 HWOp1PrvInstr_data 
%                 HWOp2PrvInstr_data 
%                 HDOp1PrvInstr_data 
%                 HDOp2PrvInstr_data 
%                 HWOp1SubInstr_data 
%                 HWOp2SubInstr_data 
%                 HDOp1SubInstr_data 
%                 HDOp2SubInstr_data
                
%                 B = nchoosek([1:32],2);
% 
%                 A = [1,instructiontype_bin(1,:),instructiontype_bin(3,:),op1binary(2,:),op2binary(2,:),...
%                     op1_bitflip,op2_bitflip,hw_op1*instructiontype_bin(1,:),hw_op2*instructiontype_bin(1,:),...
%                     hd_op1*instructiontype_bin(1,:),hd_op2*instructiontype_bin(1,:),...
%                     hw_op1*instructiontype_bin(3,:),hw_op2*instructiontype_bin(3,:),...
%                     hd_op1*instructiontype_bin(3,:),hd_op2*instructiontype_bin(3,:),...
%                     op1binary(2,B(:,1)).*op1binary(2,B(:,2)), op2binary(2,B(:,1)).*op2binary(2,B(:,2)),...
%                     op1_bitflip(B(:,1)).*op1_bitflip(B(:,2)), op2_bitflip(B(:,1)).*op2_bitflip(B(:,2))];
%                 
%                 beta = coeffs(:,instructiontype(2));
%                 power = A*beta;

                % Sum total of values is leakage
                power = constant(instructiontype(2)) + PrvInstr_data + SubInstr_data + Operand1_data + Operand2_data...
                    + BitFlip1_data + BitFlip2_data + HWOp1PrvInstr_data + HWOp2PrvInstr_data + HDOp1PrvInstr_data...
                    + HDOp2PrvInstr_data + HWOp1SubInstr_data + HWOp2SubInstr_data + HDOp1SubInstr_data + HDOp2SubInstr_data...
                    + Operand1_bitinteractions_data + Operand2_bitinteractions_data + BitFlip1_bitinteractions_data + BitFlip2_bitinteractions_data;

                fprintf(fp, '%0.12f\n',power);
                
            end
        end
    end
end
