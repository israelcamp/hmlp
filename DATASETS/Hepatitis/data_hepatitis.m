function [x_train, t_train, x_test, t_test] = data_hepatitis() 
data = load('hepatitis_2.data');
rng(0);
ridx = randperm(size(data,1));
data = data(ridx,:);

inputs = mapminmax(data(:,1:end-1)', -1, 1)';
targets = data(:,end);

train_size = floor(0.8 * size(inputs,1));

t_train = double(bsxfun(@eq, targets(1:train_size), 1:max(targets(1:train_size))));
x_train = inputs(1:train_size,:);

t_test = double(bsxfun(@eq, targets(train_size+1:end), 1:max(targets(train_size+1:end))));
x_test = inputs(train_size+1:end,:);