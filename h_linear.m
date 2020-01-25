function H = h_linear(X, A, bA)
tempH = X * A + .1*bA(:,ones(1,size(X, 1)))';

% %% tanh
% H = tanh(tempH);

%% RELU
% H = tempH .* (tempH > 0);

%% GELU
% H = tempH .* 0.5 .* (1. + erf(tempH ./ sqrt(2.)));

%% Sigmoid
H = 1 ./ (1 + exp(-tempH));