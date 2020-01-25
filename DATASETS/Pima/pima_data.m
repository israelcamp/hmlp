function [x_train, t_train, x_test, t_test] = pima_data()
% 
% train = load('pima.tr');
% test  = load('pima.te');
% 
% data = cat(1, train, test);

data = load('pima.data');
% rng(0);
% ridx = randperm(size(data,1));
% data = data(ridx,:);

train_size = ceil(.8 * size(data, 1));
test_size  = size(data, 1) - train_size;

x = mapminmax(data(:,1:end-1)', -1, 1)';
t = data(:,end);


x_train = x(1:train_size, :);
x_test  = x(train_size+1:end, :);

t_train = zeros(train_size, 2);
t_test  = zeros(test_size, 2);

for i = 1:train_size
   t_train(i, t(i)+1) = 1; 
end

for i = 1:test_size
   t_test(i, t(i+train_size)+1) = 1; 
end
