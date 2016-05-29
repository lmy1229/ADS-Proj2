system('python createRandomTestAndValidation.py');

testfile = textread('testset.txt', '%s');
valifile = textread('valiset.txt', '%s');

n = length(testfile);
m = length(valifile);


% %---precssing colored data
% tc = zeros(256, 256, 3, n, 'uint8');
% vc = zeros(256, 256, 3, m, 'uint8');
% tcr = zeros(n, 10, 'uint8');
% vcr = zeros(m, 10, 'uint8');
% 
% for i = 1:n
%     if(mod(i, 100) == 0)
%         s = sprintf('%d / %d\n',i, n);
%         disp(s);
%     end
%     iname = testfile{i};
%     image = imread(['../original/256c/' iname]);
%     tc(:,:,:,i) = image;
%     temp = zeros(1, 10);
%     temp(imageTag(iname)) = 1;
%     tcr(i, :) = temp;
% end
% for i = 1:m
%     
%     if(mod(i, 100) == 0)
%         s = sprintf('%d / %d\n',i, m);
%         disp(s);
%     end
%     
%     iname = testfile{i};
%     image = imread(['../original/256c/' iname]);
%     vc(:,:,:,i) = image;
%     temp = zeros(1, 10);
%     temp(imageTag(iname)) = 1;
%     vcr(i, :) = temp;
% end
% 
% save testset tc tcr vc vcr

% %---precssing grayscale data
% imagesize_x = 128;
% imagesize_y = 128;
% feature_channel = 1;
% % ----------------for matconvnet
% % tg = zeros(imagesize_x, imagesize_y, 1, n, 'uint8');
% % vg = zeros(imagesize_x, imagesize_y, 1, m, 'uint8');
% % ----------------for deeplearntoolbox
% tg = zeros(imagesize_x, imagesize_y, n, 'uint8');
% vg = zeros(imagesize_x, imagesize_y, m, 'uint8');
% %-----------------
% tgr = zeros(10, n, 'uint8');
% vgr = zeros(10, m, 'uint8');
% 
% for i = 1:n
%     if(mod(i, 100) == 0)
%         s = sprintf('%d / %d\n',i, n);
%         disp(s);
%     end
%     iname = testfile{i};
%     image = imread(['../original/128g/' iname]);
%     %for matconvnet
% %     tg(:,:,1,i) = image;
%     %for deeplearntoolbox
%     tg(:,:,i) = image;
% 
%     temp = zeros(10, 1);
%     temp(imageTag(iname)) = 1;
%     tgr(:, i) = temp;
% end
% for i = 1:m
%     if(mod(i, 100) == 0)
%         s = sprintf('%d / %d\n',i, m);
%         disp(s);
%     end
%     iname = testfile{i};
%     image = imread(['../original/128g/' iname]);
%     %for matconvnet
% %     vg(:,:,1,i) = image;
%     %for deeplearntoolbox
%     vg(:,:,i) = image;
%     temp = zeros(10, 1);
%     temp(imageTag(iname)) = 1;
%     vgr(:, i) = temp;
% end
% save testset_gray tg tgr vg vgr




imagesize_x = 128;
imagesize_y = 128;
feature_channel = 1;

metasets = ['train', 'val', 'test'];
metaclasses = [0 1 2 3 4 5 6 7 8 9];

data = zeros(imagesize_x, imagesize_y, feature_channel, m + n, 'uint8');
data_mean = zeros(imagesize_x, imagesize_y, 'single');
labels = zeros(1, m + n);
set = ones(1, m + n);

for i = 1:n
    if mod(i, 100) == 0
        s = sprintf('%d / %d\n',i, n);
        disp(s);
    end
    iname = testfile{i};
    image = imread(['../original/128g/' iname]);
    data(:,:,1,i) = image;
    data_mean = data_mean + single(image);
    labels(i) = imageTag(iname);
end
for i = 1:m
    if mod(i, 100) == 0
        s = sprintf('%d / %d\n',i, m);
        disp(s);
    end
    iname = valifile{i};
    image = imread(['../original/128g/' iname]);
    data(:,:,1,i + n) = image;
    data_mean = data_mean + double(image);
    labels(i + n) = imageTag(iname);
    set(i + n) = 3;
end

data_mean = data_mean ./ (m + n);
data = single(data);
for i = 1:size(data, 4)
    data(:,:,1,i) = data(:,:,1,i) - data_mean;
end

images = struct( ...
    'data', data, ...
    'data_mean', data_mean, ...
    'labels', labels, ...
    'set', set ...
);
meta = struct( ...
    'sets', metasets, ...
    'classes', metaclasses ...
);

save imdb.mat images meta