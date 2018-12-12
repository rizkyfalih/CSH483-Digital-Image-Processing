function [OUTPUT] = Thresholds(F, t1, t2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[m, n] = size(F);
for i=1 : m
    for j=1:n
        if F(i,j) <=t1 || F(i,j) >= t2
            OUTPUT(i,j) = 0;
        else
            OUTPUT(i,j) = 1;
        end
    end
end

end

