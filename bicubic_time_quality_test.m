%--------------------------------------------------------------------------
%
% calculate, display psnr/ssim/time of bicubic interpolation
%
%--------------------------------------------------------------------------


allnames=struct2cell(dir('Set14\*.bmp'));
[k,len]=size(allnames);
for ii = 1:len
    % target
    filename = allnames{1,ii};
    I = imread(strcat('Set14\',filename));
    [m,n,d] = size(I);
    target = I(11:m-10,11:n-10,:);

    % record time of bicubic
    disp(filename);
    if (d == 3)
        bicubic_img = zeros(m,n,d);
        tic;
        for k = 1:3
            bicubic_img(:,:,k) = bicubic(bicubic(I(:,:,k), m/3, n/3),m,n);
        end
        toc;
    end
    if (d == 1)
        tic;
        bicubic_img = bicubic(bicubic(I, m/3, n/3),m,n);
        toc;
    end
    edge_ripped = bicubic_img(11:m-10,11:n-10,:);
    % display infomation
    psnr_value = PSNR(uint8(edge_ripped), target);
    disp(strcat('PSNR = ', num2str(psnr_value)));
    ssim_value = SSIM(target, uint8(edge_ripped));
    disp(strcat('SSIM = ', num2str(ssim_value)));
end