function [x_train, t_train, x_test, t_test] = page_data()

data = load('page-blocks.data');

rng(1);
ridx = randperm(5473);
data = data(ridx,:);

X = data(:, 1:10);
T = data(:, 11);

X = mapminmax(X', -1, 1)';

tr_size = 4450;

t_train = zeros(tr_size, 5);
t_test = zeros(5473-tr_size, 5);

for i = 1:tr_size
   t_train(i, T(i,1)) = 1; 
end

for i = 1:5473-tr_size
   t_test(i, T(i+tr_size,1)) = 1; 
end

x_train = X(1:tr_size,:);
x_test = X(tr_size+1:end,:);
