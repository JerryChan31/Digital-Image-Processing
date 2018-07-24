%--------------------------------------------------------------------------
%
% auto get patch pairs
% need to run 'downsampling.m' first
%
%--------------------------------------------------------------------------

%read files
HRnames=struct2cell(dir('Train\*.jpg'));
[k,len]=size(HRnames);
% number of files
sample_img_num = len;
% patches to sample in each file
img_sample_num = 1000;
lrpatch = zeros(45,1,sample_img_num*img_sample_num);
hrpatch = zeros(81,1,sample_img_num*img_sample_num);
for ii=1:sample_img_num
    name = HRnames{1,ii}; 
    hrname = strcat('Train\',name);
    lrname = strcat('downsample\',name);
    lrimg = imread(lrname);
    hrimg = rgb2gray(imread(hrname));
    [lrx, lry, lrz] = size(lrimg);
    [hrx, hry, hrz] = size(hrimg);
    % set random seed
    rand('seed',sum(100*clock));
    for jj = 1:img_sample_num
        centerx = randi([4, lrx-3]);
        centery = randi([4, lry-3]);
        
        % lr patch
        temp = lrimg(centerx-3:centerx+3,centery-3:centery+3);
        temp = temp(:);
        temp = [temp(2:6);temp(8:42);temp(44:48)];
        lrmean = mean(temp(:));
        lrpatch(:,:,(ii-1)*img_sample_num+jj) = round(double(temp) - lrmean); % minus mean!
        
        %hr patch
        centerx = centerx * 3;
        centery = centery * 3;
        temp = hrimg(centerx-5:centerx+3, centery - 5: centery+3);
        hrpatch(:,:,(ii-1)*img_sample_num+jj) =  round(double(temp(:)) - lrmean); % minus mean!
    end
end

% save variables to file
save('lrpatch.mat','lrpatch');
save('hrpatch.mat','hrpatch');