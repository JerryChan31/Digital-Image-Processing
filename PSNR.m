%--------------------------------------------------------------------------
%
%   psnr = PSNR(img1,img2)
%   input: img1,img2 - two img to be compared
%   output: psnr - the value of psnr
%
%--------------------------------------------------------------------------

function psnr = PSNR(img1,img2)
    [x1, y1, z1] = size(img1);
    [x2, y2, z2] = size(img2);
    if (z1 == 3 && z2 == 3)
        % convert rgb to ycbcr
        img1 = rgb2ycbcr(img1);
        img2 = rgb2ycbcr(img2);
    end
    % pick out the Y channel
    img1 = double(img1(:,:,1));   
    img2 = double(img2(:,:,1));
    % calculate the difference
    imgdiff = img1 - img2;
    imgdiff = imgdiff(:);
    % calculate PSNR
    mse = mean(imgdiff.^2);
    psnr = 20 * log10(255/sqrt(mse));
end