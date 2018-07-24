%--------------------------------------------------------------------------
%
% bicubic interpolation for 2d image
% input: input_img - input image
%        obj_height - height of output image
%        obj_width - width of output image
% output: obj_img - image created by bicubic interpolation
%
%--------------------------------------------------------------------------


function obj_img = bicubic(input_img, obj_height, obj_width)
    [height, width] = size(input_img);
    %º∆À„±»¿˝
    obj_height = round(obj_height);
    obj_width = round(obj_width);
    Hratio = obj_height / height;
    Wratio = obj_width / width;
    %æÿ’Û¿©≥‰
    ext1 = double([input_img(1,:);input_img(1,:);input_img(:,:);input_img(height,:);input_img(height,:)]);
    ext2 = double([ext1(:,1) ext1(:,1) ext1(:,:) ext1(:,width) ext1(:,width)]);
    obj_img = zeros(obj_height, obj_width);
    for i = 1:obj_height
        Hremainder = (i / Hratio) - floor(i / Hratio);
        Hvpos = floor(i / Hratio) + 2;
        A = [cal_weight(Hremainder + 1) cal_weight(Hremainder) cal_weight(Hremainder-1) cal_weight(Hremainder-2)];
        for j = 1:obj_width
            Wremainder = (j / Wratio) - floor(j / Wratio);
            Wvpos = floor(j / Wratio) + 2;
            C = [cal_weight(Wremainder + 1);cal_weight(Wremainder);cal_weight(Wremainder-1);cal_weight(Wremainder-2)];
            B = ext2(Hvpos-1:Hvpos+2, Wvpos-1:Wvpos+2);
            obj_img(i, j) = A*B*C;
        end
    end
end