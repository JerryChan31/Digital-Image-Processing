%--------------------------------------------------------------------------
%
% use for creating gaussian mask
% input: size - the size of the mask
%        sigma - standard deviation
% output: res - the gaussian mask matrix
%
%--------------------------------------------------------------------------

function res = myfspecial(size, sigma)
    res = zeros(size,size);
    for i=1:size
        for j = 1:size
            res(i, j) = exp(-((i-(ceil(size/2)))^2+(j-ceil(size/2))^2) / (2*sigma^2) );
        end
    end
    msum = sum(res(:));
    res = res / msum;
end