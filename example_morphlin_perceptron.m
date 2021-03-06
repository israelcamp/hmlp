% Example of how to run the MorphologicalLinearPerceptron on the pathbased dataset
%% Reading the data and deciding parameters
addpath('DATASETS/Cancer/');
load('DATASETS/Ionosphere/iono.mat');
% [x_train, t_train, x_test, t_test] = ();
x_train = P;
t_train = T;
x_test = Ptest;
t_test = Ttest;

n_tries = 1;

n_neurons_morph = 0;
n_neurons_lin = 1000; 
C = 1e-1;   
metric = 1; % 1 for accuracy, 0 for mean squared root


%% training and evaluating
test=zeros(n_tries,1);
train=zeros(n_tries,1);

wb=waitbar(0,'Please wait...');
tic
for rnd = 1 : n_tries
    waitbar(rnd/n_tries,wb);
    [train_accuracy, test_accuracy]= MorphologicalLinearPerceptron(x_train, t_train, x_test, t_test, n_neurons_morph, n_neurons_lin, C, metric);
    test(rnd,1)=test_accuracy;
    train(rnd,1)=train_accuracy;
end
toc
close(wb);

AvgTraining=mean(train);
StdTraining=std(train);
AvgTesting=mean(test);
StdTesting=std(test);
