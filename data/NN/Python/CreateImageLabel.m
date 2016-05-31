system('python CreateRandomData.py');

featurelength = 512;

tlist = textread('trainset.txt', '%s');
vlist = textread('valiset.txt', '%s');

n = length(tlist);
m = length(vlist);

y_train = zeros(n, 1);
y_test = zeros(m, 1);

for i = 1:n
    y_train(i) = imageTag(tlist{i});
end
for j = 1:m
    y_test(j) = imageTag(vlist{j});
end

X_train = reshape(textread('trainf.txt', '%f', 'delimiter', ' '), featurelength, []);
X_test = reshape(textread('valif.txt', '%f', 'delimiter', ' '), featurelength, []);
X_train = X_train';
X_test = X_test';
save result/data X_train X_test y_train y_test