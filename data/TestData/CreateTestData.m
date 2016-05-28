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

%---precssing grayscale data
imagesize_x = 128;
imagesize_y = 128;
% ----------------for matconvnet
% tg = zeros(imagesize_x, imagesize_y, 1, n, 'uint8');
% vg = zeros(imagesize_x, imagesize_y, 1, m, 'uint8');
% ----------------for deeplearntoolbox
tg = zeros(imagesize_x, imagesize_y, n, 'uint8');
vg = zeros(imagesize_x, imagesize_y, m, 'uint8');
%-----------------
tgr = zeros(10, n, 'uint8');
vgr = zeros(10, m, 'uint8');

for i = 1:n
    if(mod(i, 100) == 0)
        s = sprintf('%d / %d\n',i, n);
        disp(s);
    end
    iname = testfile{i};
    image = imread(['../original/128g/' iname]);
    %for matconvnet
%     tg(:,:,1,i) = image;
    %for deeplearntoolbox
    tg(:,:,i) = image;

    temp = zeros(10, 1);
    temp(imageTag(iname)) = 1;
    tgr(:, i) = temp;
end
for i = 1:m
    if(mod(i, 100) == 0)
        s = sprintf('%d / %d\n',i, m);
        disp(s);
    end
    iname = testfile{i};
    image = imread(['../original/128g/' iname]);
    %for matconvnet
%     vg(:,:,1,i) = image;
    %for deeplearntoolbox
    vg(:,:,i) = image;
    temp = zeros(10, 1);
    temp(imageTag(iname)) = 1;
    vgr(:, i) = temp;
end

save testset_gray tg tgr vg vgr