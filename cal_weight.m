%--------------------------------------------------------------------------
%
% calculate the weight for bicubic
% input: x - element in bicubic's B matrix
% output: weight - the weight of the element
%
%--------------------------------------------------------------------------

function weight = cal_weight(x)
    x = abs(x);
    if (x >= 0 && x <=1)
        weight = 1.5 .* x ^ 3 - 2.5 .* x ^2  + 1;
    else
        if (x > 1 && x <= 2)
        weight = -0.5 .* x^3 + 2.5 .* x^2 -4 .* x +2;
        else
        weight = 0;
        end
    end    
end