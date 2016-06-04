function [] = NNCompute(datadir, targetdir, opts)

% Train a Neural Network with 1 hidden layer. Predict on trainset and
% valiset. Save Params and Predictions to file if needed.
%
% The 'opts' param must be a struct with fields showing below
% opts.network_sizes: the structure of the network. must be a 1*3 or 3*1
%   matrix, showing the input layer size, hidden layer size and the output
%   layer size.
% opts.maxiter: max iterations to be done during the training.
% opts.lambda: coefficient of regularization
% opts.save: whether to save params and predictions to file. true for save
%   and 0 for not save
%

%% init
load(fullfile(datadir, 'data.mat'));

input_dim = opts.network_sizes(1);
hidden_dim = opts.network_sizes(2);
output_dim = opts.network_sizes(3);
maxiter = opts.maxiter;
lambda = opts.lambda;

param1 = randInitializeWeights(input_dim, hidden_dim);
param2 = randInitializeWeights(hidden_dim, output_dim);

init_nn_params = [param1(:) ; param2(:)];

%% Train

options = optimset('MaxIter', maxiter);
costFunction =  @(p) nnCostFunction(p, ...
                                    input_dim, ...
                                    hidden_dim, ...
                                    output_dim, X_train, y_train, lambda);
[nnparams costs] = fmincg(costFunction, init_nn_params, options);


%% Predict
Theta1 = reshape(nnparams(1:hidden_dim * (input_dim + 1)), ...
                 hidden_dim, (input_dim + 1));

Theta2 = reshape(nnparams((1 + (hidden_dim * (input_dim + 1))):end), ...
                 output_dim, (hidden_dim + 1));

if opts.save == false
    p_train = predict(Theta1, Theta2, X_train);
    p_test = predict(Theta1, Theta2, X_test);
else
    p_train = predict(Theta1, Theta2, X_train, targetdir, '-train');
    p_test = predict(Theta1, Theta2, X_test, targetdir, '-vali');
    save(fullfile(targetdir, 'params'), 'Theta1', 'Theta2');
end
         
fprintf('train set : %d / %d / %f\n', sum((p_train - y_train) == 0), length(p_train), sum((p_train - y_train) == 0)/ length(p_train));
fprintf('test set : %d / %d / %f\n', sum((p_test - y_test) == 0), length(p_test), sum((p_test - y_test) == 0)/ length(p_test));

