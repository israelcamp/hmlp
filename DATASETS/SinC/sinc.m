function [x_train, t_train, x_test, t_test] = sinc()
%% making the data
tr_size = 500;
te_size = 200;

x_train = zeros(tr_size,1);
t_train = zeros(tr_size,1);

x_test  = zeros(te_size,1);
t_test  = zeros(te_size,1);

rng(0);

k = 1;
for i = 1:tr_size*4
   x = 10*rand()-5;
   if ~any(x_train == x)
      x_train(k) = x;
      k = k + 1;
   end
   if k == tr_size + 1
       break;
   end
end

k = 1;
for i = 1:te_size*4
   x = 10*rand()-5;
   if ~any(x_train == x) && ~any(x_test == x)
      x_test(k) = x;
      k = k + 1;
   end
   if k == te_size + 1
       break;
   end
end

for i = 1:tr_size
   t_train(i) = sinxox(x_train(i)); 
end

for i = 1:te_size
   t_test(i) = sinxox(x_test(i)); 
end

%% adding noise
idx = randperm(tr_size, 200);
for i = idx
   x_train(i) = x_train(i) + 1.0*rand()-0.5; 
end

%% standardize
[x_train, stats] = mapminmax(x_train', -1, 1);
x_train = x_train';
x_test = mapminmax('apply', x_test', stats)';
