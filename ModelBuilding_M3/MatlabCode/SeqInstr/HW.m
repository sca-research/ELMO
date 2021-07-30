function hamming_weight = HW(x)
% Simple function to return Hamming weights of matrix elements. 
%
% HAMMING_WEIGHT = HW(X)
% X : a matrix of small integers
% HAMMING_WEIGHT : a matrix of size(X) containing the Hamming weights of
%   the elements of X.
%
% I don't think this is the best way of coding this, but it's fine for 
% small integers.

temp = uint64(x);
temp(x<0|x>intmax('uint64')) = 0;
bitlength = length(dec2bin(max(temp(:))));
hamming_weight = zeros(size(temp));
for i = 1:bitlength
    hamming_weight = hamming_weight + (bitand(temp,2^(i-1))==2^(i-1));
end
hamming_weight(x<0|x>intmax('uint64')) = NaN;
end