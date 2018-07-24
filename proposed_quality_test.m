%--------------------------------------------------------------------------
%
% calculate, display psnr & ssim of image in upsample
%
%--------------------------------------------------------------------------


allnames=struct2cell(dir('Set14\*.bmp'));
[k,len]=size(allnames);
for ii = 1:len
    filename = allnames{1,ii};
    I = imread(strcat('Set14\',filename)); % origin image
    upsample_I = imread(strcat('upsample\',filename)); % upsample image
    [m,n,d] = size(I);
    % ripped edge
    target = I(11:m-10,11:n-10,:);
    edge_ripped = upsample_I(11:m-10,11:n-10,:);
    % display infomation
    disp(filename);
    psnr_value = PSNR(uint8(edge_ripped), target);
    disp(strcat('PSNR = ', num2str(psnr_value)));
    ssim_value = SSIM(uint8(target), uint8(edge_ripped));
    disp(strcat('SSIM = ', num2str(ssim_value)));
end