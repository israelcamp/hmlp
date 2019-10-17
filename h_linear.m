function H = h_linear(X, A, bA)
tempH = X * A + .1*bA(:,ones(1,size(X, 1)))';
%% Sigmoid
H = 1 ./ (1 + exp(-tempH));