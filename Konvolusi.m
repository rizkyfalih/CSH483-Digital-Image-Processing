function [OUTPUT] = Konvolusi(F, H)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[height_f, width_f] = size(F);
[height_h, width_h] = size(H);

m2 = floor(height_h/2);
n2 = floor(width_h/2);

F2 = double(F);
for y=m2+1 : height_f-m2
    for x=n2+1 : width_f-n2
        jum = 0;
        for p=-m2 : m2
            for q=-n2 : n2
                jum = jum + H(p+m2+1,q+n2+1) * F2(y-p, x-q);
            end
        end
        
        OUTPUT(y-m2,x-n2) = jum;
    end
end



end

