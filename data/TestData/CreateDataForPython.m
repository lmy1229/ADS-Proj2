system('python createRandomTestAndValidation.py');

trainset = textread('testset.txt', '%s');
valiset = textread('valiset.txt', '%s');

imagesize = [128, 128, 1];
imagepath = '../original/128g/';

n = length(trainset);
m = length(valiset);



for i = 1:n
    iname = trainset{i};
    image = imread([imagepath iname]);
    