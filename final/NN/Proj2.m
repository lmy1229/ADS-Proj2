%%--------------------- Train NN ------------------------%%
if isempty(dir('NNResult/*.mat')) == 1
    % Process GIST features
    system('python process.py Feature/gist.txt');
    % Create trainset and valiset
    CreateImageLabel;
    % Train NN
    opt.network_sizes = [512 100 10];
    opt.maxiter = 1000;
    opt.lambda = 1;
    opt.save = true;
    NNCompute('Dataset', 'NNResult', opt);
end

%%-------------------- Extract GIST ---------------------%%
