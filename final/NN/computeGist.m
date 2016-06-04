path = 'images';
images = dir(fullfile(path, '*.JPEG'));
n = length(images);
file = fopen(strcat(path, 'gist.txt'),'w+');
fprintf(file, '512\r\n');
for i = 1:n
    gist_out(path, images(i).name, file);
    disp(i/n);
end
fclose(file);
disp('end');