function [x_train, t_train, x_test, t_test] = mnist()
% Change the filenames if you've saved the files under different names
% On some platforms, the files might be saved as 
% train-images.idx3-ubyte / train-labels.idx1-ubyte
images = loadMNISTImages('t10k-images.idx3-ubyte')';
labels = loadMNISTLabels('t10k-labels.idx1-ubyte');

rng(1);
ridx = randperm(length(images));
images = images(ridx,:);
labels = labels(ridx,:);

for i = 1:10
   Rows{i} = []; 
end

for i = 1:length(labels)
    t = labels(i)+1;
    Rows{t} = [Rows{t}, i];
end

x_train = zeros(1000, 784);
x_test = zeros(200, 784);

labels_train = zeros(1000,1);
labels_test = zeros(200,1);

for i = 1:10
   x_train(100*(i-1)+1:100*i,:) = images(Rows{i}(1:100), :); 
   labels_train(100*(i-1)+1:100*i,:) = labels(Rows{i}(1:100), :);  
   x_test(20*(i-1)+1:20*i,:) = images(Rows{i}(101:120), :); 
   labels_test(20*(i-1)+1:20*i,:) = labels(Rows{i}(101:120), :);  
end

t_train = zeros(1000, 10);
t_test = zeros(200, 10);

for i = 1:1000
   t_train(i, labels_train(i)+1) = 1; 
end

for i = 1:200
   t_test(i, labels_test(i)+1) = 1; 
end


rng(1);
tridx = randperm(1000);
x_train = x_train(tridx,:);
t_train = t_train(tridx,:);

rng(1);
teidx = randperm(200);
x_test = x_test(teidx,:);
t_test = t_test(teidx,:);

