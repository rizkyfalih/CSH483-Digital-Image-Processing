function [OUTPUT] = Hist(I)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    X = imhist(I);
    HistManual = zeros(size(X));
    for i = 1:256
        jum = 0;
        Y(i) = X(i)/sum(X);
        for j = 1:i
            jum = jum + Y(j);
        end
        HistManual(i) = round(255*jum);
    end
    for i = 1:size(I,1)
        for j = 1:size(I,2)
            I(i,j) = HistManual(I(i,j)+1);
        end
    end
    OUTPUT = uint8(I);

end

