%--------------------------------------------------------------------------
%
%   ssim = SSIM(img1, img2)
%   input: img1,img2 - two img to be compared
%   output: ssim - the value of ssim
%
%--------------------------------------------------------------------------


function ssim = SSIM(img1, img2)
    % convert image to double type
    img1 = double(img1(:,:));
    img2 = double(img2(:,:));
    % pre-define some varible for calculating
    k1 = 0.01;
    k2 = 0.03;
    L = 255;
    c1 = (k1 * L)^2;
    c2 = (k2 * L)^2;
    % create gaussian mask, size=11*11, std deviation=1.5
    window = myfspecial(11,1.5);
    % filt to get mean
    mean1 = filter2d(img1, window);
    mean2 = filter2d(img2, window);
    % 平方的均值 - 均值的平方
    sigma1 = filter2d(img1.*img1, window) - mean1.*mean1;
    sigma2 = filter2d(img2.*img2, window) - mean2.*mean2;
    % covariance
    cov = filter2d(img2.*img1, window) - mean2.*mean1;
    % calculate ssim matrix by formula
    ssim_map = (2*(mean1.*mean2)+c1).*(2*cov+c2)./((mean1.*mean1+mean2.*mean2+c1).*(sigma1+sigma2+c2));
    ssim = mean(ssim_map(:));
end