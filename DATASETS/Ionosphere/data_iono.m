function [x_train, t_train, x_test, t_test] = data_iono()

data = load('ionosphere.data');

rng(1);
ridx = randperm(size(data,1));
data = data(ridx,:);

x = data(:,1:end-1);
t = data(:,end);

x = mapminmax(x', -1, 1)';

train_size = floor(0.8*size(x,1));

x_train = x(1:train_size,:);
x_test  = x(train_size+1:end,:);

labels = unique(t);

t_train = zeros(train_size, length(labels));
t_test  = zeros(size(x,1) - train_size, length(labels));

for i = 1:train_size
   t_train(i, t(i) == labels) = 1;
end

for i = 1:size(x,1) - train_size
   t_test(i, t(i+train_size) == labels) = 1;
end
