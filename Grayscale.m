function [OUTPUT] = Grayscale(F)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
R = F(:,:,1);
G = F(:,:,2);
B = F(:,:,3);
OUTPUT = 0.4*R + 0.3*G + 0.3*B;
end

