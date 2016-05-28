addpath(genpath('/Users/Marklv/Documents/MATLAB/DeepLearnToolbox'));

load testset_gray.mat

train_x = double(tg) / 255;
train_y = double(tgr);
test_x = double(vg) / 255;
test_y = double(vgr);

rng(0)
cnn.layers = {
    struct('type', 'i') %input layer
    struct('type', 'c', 'outputmaps', 6, 'kernelsize', 5) %convolution layer
    struct('type', 's', 'scale', 2) %sub sampling layer
    struct('type', 'c', 'outputmaps', 12, 'kernelsize', 5) %convolution layer
    struct('type', 's', 'scale', 2) %subsampling layer
};
cnn = cnnsetup(cnn, train_x, train_y);

opts.alpha = 1;
opts.batchsize = 100;
opts.numepochs = 5;

cnn = cnntrain(cnn, train_x, train_y, opts);

[er, bad] = cnntest(cnn, test_x, test_y);

%plot mean squared error
figure; plot(cnn.rL);