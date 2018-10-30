function [OUTPUT] = HistNormalize(I)
    for i = 1:3
        I(:,:,i) = Hist(I(:,:,i));
    end
    OUTPUT = uint8(I);
end

