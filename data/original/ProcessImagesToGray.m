load imageList.mat fileNames

n = size(fileNames, 1);
for i = 1:n
    iname = fileNames{i};
    if mod(i, 10) == 0
        s = sprintf('Processing %s (%d/ %d)', iname, i, n);
        disp(s);
    end
    
    image = imread(['image/' iname]);
    image = rgb2gray(image);
    image = imresize(image, [128 128]);
    imwrite(image, ['128g/' iname]);
end

