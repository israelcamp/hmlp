function [x_train, t_train, x_test, t_test, X_zero, X_one] = spiral() 
tam = 600;
times = 10;
laps = 10.;

X = zeros(tam*times,1);
Y = zeros(tam*times,1);

for k = 1:times
    for i = 1:tam
        rx = (i)/tam;
        ry = (i)/tam;
        theta = 2*pi*(i/(tam/laps)) + 2*pi*0.01*rand();
%         X(i + (k-1)*tam) = .9*rx*cos(theta);
%         Y(i + (k-1)*tam) = .9*ry*sin(theta);
        X(i + (k-1)*tam) = .9*rx*cos(theta) + 0.04*rand() - 0.02;
        Y(i + (k-1)*tam) = .9*ry*sin(theta) + 0.04*rand() - 0.02;
    end
end
 
Z = zeros(tam*times,1);
W = zeros(tam*times,1);

for k = 1:times
    for i = 1:tam
        rx = (i)/tam;
        ry = (i)/tam;
        theta = -pi+2*pi*(i/(tam/laps)) +  + 2*pi*0.01*rand();
        Z(i + (k-1)*tam) = .9*rx*cos(theta) + 0.04*rand() - 0.02;
        W(i + (k-1)*tam) = .9*ry*sin(theta) + 0.04*rand() - 0.02;
    end
end

X_zero = cat(2, X, Y);
X_one = cat(2, Z, W);

T_zero = cat(2, ones(tam*times,1), zeros(tam*times,1));
T_one = cat(2, zeros(tam*times,1), ones(tam*times,1));

inputs = cat(1, X_zero, X_one);
targets = cat(1, T_zero, T_one);

rng(1);
rand_idx = randperm(tam*times*2);
inputs = inputs(rand_idx,:);
targets = targets(rand_idx,:);

[inputs, ps] = mapminmax(inputs', 0, 1);
inputs = inputs';

X_one = mapminmax('apply', X_one', ps)';
X_zero = mapminmax('apply', X_zero', ps)';

train_size = floor(0.8*size(inputs,1));
x_train = inputs(1:train_size,:);
t_train = targets(1:train_size,:);
x_test = inputs(train_size+1:end,:);
t_test = targets(train_size+1:end,:);

% figure()
% scatter(X, Y, 'filled', 'red');
% hold on
% scatter(Z, W, 'filled', 'blue');