%--------------------------------------------------------------------------
%
% input: img - 2d image to be filted
%        filter - mask for convolution
% output: out - image after being filted
%
%--------------------------------------------------------------------------

function out = filter2d(img, filter)
    % extend
    [x, y, z] = size(filter);
    x_ext = (x-1)/2;
    y_ext = (y-1)/2;
    [width, height, depth] = size(img);
    out = zeros(width, height);
    % filt
    for i = 1 + x_ext: width - x_ext
        for j = 1 + y_ext: height - y_ext
            filter_sum = 0;
            for k = i - x_ext: i + x_ext
                for l = j - y_ext: j + y_ext
                    filter_sum = filter_sum + double(img(k, l)).*filter(k - (i - x_ext) + 1, l - (j - y_ext)+1);
                end
            end
            out(i, j) = filter_sum;
        end
    end
    out = out( 1 + x_ext: width - y_ext, 1 + y_ext: height - y_ext);
end