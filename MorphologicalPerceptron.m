function [Tr, Te] = MNN(X_train, T_train, X_test, T_test, n_morph, C, metric)
%% Creating the random matrices
n_att = size(X_train, 2);
[V, W] = morph_random(n_att, n_morph);

%% Computing Beta - Output weights
H_train = h_morphological(X_train, V, W);
Beta = beta(X_train, T_train, H_train, C);

%% Metric of training
Tr = calculate_metric(H_train, Beta, T_train, metric);

%% Metric of testing
H_test = h_morphological(X_test, V, W);
Te = calculate_metric(H_test, Beta, T_test, metric);
