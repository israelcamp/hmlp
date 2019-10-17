% Example of how to run the MorphologicalLinearPerceptron on the pathbased dataset
%% Reading the data and deciding parameters
[x_train,t_train, ~, ~] = pathbased_data();

n_tries = 1;

n_neurons_morph = 10;
n_neurons_lin = 0; 
C = 0;
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