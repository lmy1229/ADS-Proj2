load imageList.mat fileNames

n = size(fileNames, 1);
for i = 1:n
    iname = fileNames{i};
    s = sprintf('Processing %s (%d/ %d)', iname, i, n);
    disp(s);
    
    image = imread(['image/' iname]);
    image = imresize(image, [256 256]);
    imwrite(image, ['256c/' iname]);
end

