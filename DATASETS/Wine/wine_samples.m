function [x_train, t_train, x_test, t_test] = wine_samples()
data = load('wine_samples.txt');

rng(1);
ridx = randperm(size(data,1));
data = data(ridx,:);

train_size = floor(0.8 * size(data,1));

x = data(:,2:end);
t = data(:,1);

x = mapminmax(x', -1, 1)';

x_train = x(1:train_size, :);
x_test  = x(train_size+1:end,:);


onehot = bsxfun(@eq, t(:), 1:max(t));

t_train = 1. * onehot(1:train_size,:);
t_test  = 1. * onehot(train_size+1:end,:);
