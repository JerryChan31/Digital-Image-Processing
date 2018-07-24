%--------------------------------------------------------------------------
%
% auto downsampling image in Train\ to downsample\
%
%--------------------------------------------------------------------------

clc, clear;
allnames=struct2cell(dir('Train\*.jpg'));
[k,len]=size(allnames);

parfor ii=1:len
    name=allnames{1,ii};
    I= imread(strcat('Train\',name)); %¶ÁÈ¡ÎÄ¼þ
    [x, y, z] = size(I);
    % create mask
    mask = myfspecial(3,1.6);
    % filt, downsample, save to file
    imwrite(uint8(bicubic(filter2d(rgb2gray(I), mask), (x/3), (y/3))), strcat('downsample\', name));
end