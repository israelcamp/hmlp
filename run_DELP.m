%% Getting the data
addpath('DATASETS/MNIST/');
[x_train, t_train, x_test, t_test] = mnist();

[~, y_train] = max(t_train, [], 2);
[~, y_test] = max(t_test, [], 2);

%% Setting variables
output_size = size(t_train, 2);
hidden_neurons = 60;
netp = [hidden_neurons, output_size, 300];

%% Training the network
% [W,Error,ErrorMin,W_opt,Epoch] = hmlbackprop(netp, x_train', t_train');
% 
% %% Accuracy for training
% [Y, ~, ~, ~] = hmlnn(W, x_train');
% AcTraining = accuracy(Y', t_train);
% clear Y
% %% Accuracy for testing
% [Y, ~, ~, ~] = hmlnn(W, x_test');
% AcTesting = accuracy(Y', t_test);
% clear Y

%% Average
n_tries = 5;
test=zeros(n_tries,1);
train=zeros(n_tries,1);
wb=waitbar(0,'Please waiting...');
tic
for rnd = 1 : n_tries
    [W,Error,ErrorMin,W_opt,Epoch] = hmlbackprop(netp, x_train', t_train');
    %
    [Y, ~, ~, ~] = hmlnn(W, x_train');
    train_accuracy = accuracy(Y', t_train);
    %
    [Y, ~, ~, ~] = hmlnn(W, x_test');
    test_accuracy = accuracy(Y', t_test);
    %
    test(rnd,1)=test_accuracy;
    train(rnd,1)=train_accuracy;
    waitbar(rnd/n_tries,wb);
end
toc
close(wb);

AvgTr=mean(train);
StdTr=std(train);
AvgTe=mean(test);
StdTe=std(test);