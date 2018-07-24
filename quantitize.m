function img=quantitize(img)
    [x, y] = size(img);
    minElement = min(img(:));
    maxElement = max(img(:));
    diff = maxElement - minElement;
    for i = 1 :x
        for j = 1 : y
            img(i, j) = ((img(i,j) - minElement)/diff)*255;
        end
    end
end