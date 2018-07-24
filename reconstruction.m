%--------------------------------------------------------------------------
%
% auto reconstructing image in Set14\
% need to run 'clustering.m' first
%
%--------------------------------------------------------------------------

load('C.mat');
load('idx.mat');
load('Center.mat');
load('cluster_num.mat');
allnames=struct2cell(dir('Set14\*.bmp'));
[k,len]=size(allnames);
for ii=1:len
    name=allnames{1,ii};
    I = imread(strcat('Set14\', name));
    [x, y, z] = size(I);
    % create mask & filt
    mask = myfspecial(3,1.6);
    % downsample if rgb   
    if (z == 3)
        down_I = zeros(round(x/3),round(y/3),3);
        for k = 1:3
            down_I(:,:,k) = bicubic(uint8(filter2d(I(:,:,k), mask)),x/3, y/3);
        end
        [x, y, z] = size(down_I);
        pad_I = zeros(x+6, y+6, 3);
        pad_I(4:x+3,4:y+3,:) = down_I;
        pad_I = rgb2ycbcr(uint8(pad_I));
        y_tunnel = pad_I(:,:,1);
    end
    % downsample if gray
    if (z == 1)
        down_I = zeros(round(x/3),round(y/3));
        down_I(:,:) = bicubic(uint8(filter2d(I(:,:), mask)),x/3, y/3);
        [x, y, z] = size(down_I);
        y_tunnel = zeros(x+6, y+6, 3);
        y_tunnel(4:x+3,4:y+3) = down_I;
    end
    new_img = zeros(3*x+8, 3*y+8);
    %display(name); % uncomment if timing is needed
    %tic; % uncomment if timing is needed
    for ij=4:x+3
        for ik =4:y+3
            temp = y_tunnel(ij-3:ij+3, ik-3:ik+3);
            temp = temp(:)';
            temp = double([temp(2:6) temp(8:42) temp(44:48)]);
            lrmean = mean(temp(:));
            lrpatch = double(temp - lrmean); % minus mean!!!
            temp = temp - lrmean;
            temp = repmat(temp,cluster_num,1);
            distance = sum(((double(temp) - Center).^2).');
            index = find(min(distance(:)) == distance);
            lrpatch = [lrpatch 1];
            hrpatch = reshape(lrpatch * permute(C(:,:,index),[2,1]),9, 9) + lrmean;
            new_img(ij*3-11:ij*3-3,ik*3-11:ik*3-3) =new_img(ij*3-11:ij*3-3,ik*3-11:ik*3-3) + hrpatch;
        end
    end
    new_img = new_img/9;
    %toc; % uncomment if timing is needed
    % output if rgb
    if (z == 3)
        output = zeros(3*x, 3*y, 3);
        bicubic_img = zeros(3*x, 3*y, 3);
        bicubic_img(:,:,1) = bicubic(down_I(:,:,1), 3*x, 3*y);
        bicubic_img(:,:,2) = bicubic(down_I(:,:,2), 3*x, 3*y);
        bicubic_img(:,:,3) = bicubic(down_I(:,:,3), 3*x, 3*y);
        bicubic_img = rgb2ycbcr(uint8(bicubic_img));
        output(:,:,1) = round(new_img(4:(3*x)+3,4:(3*y)+3));
        output(:,:,2) = bicubic_img(:,:,2);
        output(:,:,3) = bicubic_img(:,:,3);
         %imshow(ycbcr2rgb(uint8(output)));
        imwrite(ycbcr2rgb(uint8(output)), strcat('upsample\', name));
    end
    % output if gray
    if (z == 1)
        output = im2double(zeros(3*x, 3*y));
        output(:,:) = uint8(new_img(4:(3*x)+3,4:(3*y)+3));
        imwrite(uint8(output), strcat('upsample\', name));
    end
end