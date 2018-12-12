function [OUTPUT] = RegionGrowth(F, x, y)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
a = 100;
threshold = 100;

[height, width]=size(F);
OUTPUT = zeros(height,width);
visitor = zeros(height,width);
seed=F(x,y);

while visitor ~= 1
    for i = 1 : height
        for j = 1 : width
            if F(i,j)<threshold+seed && visitor(i,j)~=1
                OUTPUT(i,j)=a;
                visitor(i,j)=1;
            end
        end
    end
    a = a + 100;
    for i = 1 : height
        for j = 1 : width
            if visitor(i,j)~=1
                seed = F(i,j);
                break;
            end
        end
    end
end