function [Rsquared,Ftable] = LRA_ModelBuilding(Traces,input,result)
%UNTITLED Summary of this function goes here
N=numel(result);
Rsquared = zeros(size(Traces,2),1);
Ftable = zeros(size(Traces,2),1);
%   Detailed explanation goes here
            A = [ones(N,1),zeros(N,32*3)];
            for bit = 1:32
                % Bits of the first input to the second instruction:
                A(:,bit+1) = bitget(input{2}(:,1),bit);
                % Bits of the second input to the second instruction:
                A(:,bit+33) = bitget(input{2}(:,2),bit);
                % Bits of the second input to the second instruction:
                A(:,bit+65) = bitget(result,bit);
            end
            if(max(double(result==input{2}(:,2)))==0 || max(double(result==input{2}(:,1)))==0)
                A=A(:,1:65);
            end
            for ind = 1:size(Traces,2)
                [Btemp,BINT,R,RINT,STATS] = regress(Traces(:,ind),A);
                Rsquared(ind) = STATS(1);
                Ftable(ind) = STATS(2);
            end
end

