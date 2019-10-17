function [Tr, Te] = MLNN(X_train, T_train, X_test, T_test, morphological_nodes, linear_nodes, C, metric)
%% Matrices
[V, W] = morph_random(size(X_train,2), morphological_nodes);
[A, bA] = lin_random(size(X_train,2), linear_nodes, -1, 1);

%% Computing Beta - Output weights
H_train = h_linear_and_morphological(X_train, V, W, A, bA);
Beta = beta(X_train, T_train, H_train, C);

%% Metric of training
Tr = calculate_metric(H_train, Beta, T_train, metric);

%% Metric of testing
H_test = h_linear_and_morphological(X_test, V, W, A, bA);
Te = calculate_metric(H_test, Beta, T_test, metric);
