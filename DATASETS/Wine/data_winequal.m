function [x_train, t_train, x_test, t_test] = data_winequal()
data = load('w1.data');
t = data(:,end);
x = data(:,1:end-1);
clear data

x = mapminmax(x', -1, 1)';
% rng(1);
% ridx = randperm(size(x,1));
% x = x(ridx,:);
% t = t(ridx,:);
uni = unique(t);

train_size = floor(0.75*size(x,1));
x_train = x(1:train_size,:);
x_test  = x(train_size+1:end,:);

t_train = zeros(train_size, size(t,2));
t_test  = zeros(size(t,1) - train_size, size(t,2));

for i = 1:train_size
    t_train(i, uni == t(i)) = 1;
end


for i = 1:size(t,1) - train_size
    t_test(i, uni == t(i+train_size)) = 1;
end