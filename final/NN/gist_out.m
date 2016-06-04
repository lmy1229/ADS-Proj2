function gist_out(path,name,file) 
pix = strcat(path, name);
% Load image
img = imread(pix);
clear param
img = imresize(img, 0.3);
param.orientationsPerScale = [8 8 8 8]; % number of orientations per scale (from HF to LF)
param.numberBlocks = 4;
param.fc_prefilt = 4;

% R = fix(R / t / y);
% figure
% subplot(121)
% imshow(img)
% title('Input image')
% GIST Parameters:

% Computing gist:
[gist, param] = LMgist(img, '', param);
fprintf(file, name);
fprintf(file, '\r\n');

for p = 1:512
    fprintf(file, '%.4f', gist(p));
    if(p < 512)
        fprintf(file, ' ');
    end
end
fprintf(file, '\r\n');
% Visualization

% subplot(122)
% showGist(gist, param)
% title('Descriptor')


