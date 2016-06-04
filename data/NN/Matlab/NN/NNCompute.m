% load ../datas/images
dir = 'Datas/';

load([dir 'data']);

%----------------------Fix Layer Network---------------------------
% params
input_dim = 512;
hidden_dim = 100;
output_dim = 10;
maxiter = 1000;
lambda = 0;

param1 = randInitializeWeights(input_dim, hidden_dim);
param2 = randInitializeWeights(hidden_dim, output_dim);

init_nn_params = [param1(:) ; param2(:)];

options = optimset('MaxIter', maxiter);
costFunction =  @(p) nnCostFunction(p, ...
                                    input_dim, ...
                                    hidden_dim, ...
                                    output_dim, X_train, y_train, lambda);
[nnparams costs] = fmincg(costFunction, init_nn_params, options);

Theta1 = reshape(nnparams(1:hidden_dim * (input_dim + 1)), ...
                 hidden_dim, (input_dim + 1));

Theta2 = reshape(nnparams((1 + (hidden_dim * (input_dim + 1))):end), ...
                 output_dim, (hidden_dim + 1));


p_train = predict(Theta1, Theta2, X_train, dir, '-train');
% p_train = predict(Theta1, Theta2, X_train);
fprintf('train set : %d / %d / %f\n', sum((p_train - y_train) == 0), length(p_train), sum((p_train - y_train) == 0)/ length(p_train));

p_test = predict(Theta1, Theta2, X_test, dir, '-test');
% p_test = predict(Theta1, Theta2, X_test);
fprintf('test set : %d / %d / %f\n', sum((p_test - y_test) == 0), length(p_test), sum((p_test - y_test) == 0)/ length(p_test));

% save([dir 'params'], 'Theta1', 'Theta2');
