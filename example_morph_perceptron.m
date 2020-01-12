% Example of how to run the MP on the pathbased dataset
addpath('DATASETS/Ripley');
%% Reading the data and deciding parameters
[x_train,t_train, x_test, t_test] = data_sintripley();

n_tries = 10;
n_neurons = 50;
C = 1e-1;
metric = 1; % 1 for accuracy, 0 for mean squared root

%% training and evaluating
test=zeros(n_tries,1);
train=zeros(n_tries,1);
wb=waitbar(0,'Please wait...');
tic
for rnd = 1 : n_tries
    waitbar(rnd/n_tries,wb);
    [train_accuracy, test_accuracy] = MorphologicalPerceptron(x_train, t_train, x_test, t_test,n_neurons, C, metric);
    test(rnd,1)=test_accuracy;
    train(rnd,1)=train_accuracy;
end
toc
close(wb);

AvgTr=mean(train);
StdTr=std(train);
AvgTe=mean(test);
StdTe=std(test);
