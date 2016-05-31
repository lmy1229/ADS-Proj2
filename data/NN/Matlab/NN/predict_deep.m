function [ p ] = predict_deep( Thetas, X )
%PREDICT Predict the label of an input given a trained neural network
%   p = PREDICT(Thetas, X) outputs the predicted label of X given the
%   trained weights of a neural network (Thetas)

n = length(Thetas);
m = size(X, 1)
h = X;

for i = 1:n
    theta = Thetas{i};
    h = [ones(m, 1) h] * theta';
end

[~, p] = max(h, [], 2); 

end

