addpath('DATASETS/Cancer');
[X, T, ~, ~,] = data_cancer();
n_att = size(X,2);
k = 10;
n = floor(size(X, 1) / k);
% results = zeros(k, 3);
x_teste = zeros(n, size(X,2));
t_teste = zeros(n, size(T,2));

hund = 100:100:500;
thous = 1000:1000:5000;

avg_best = 0;
for p = linspace(-3, 0, 4)
    display(p)
    for L_morph = [hund, ]
        for L_lin = [hund, ]
            for rg = 1:10
                [W{1}, W{2}] = morph_random(n_att, L_morph);
                [W{3}, W{4}] = lin_random(n_att, L_lin, -1, 1);
                for p_tries = 1:10
                    avg_actual = 0;
                    for i = 1:k
                        x_teste(:,:) = X((i-1)*n+1:i*n,:);
                        t_teste(:,:) = T((i-1)*n+1:i*n,:);
                        x_treino = X;
                        t_treino = T;
                        x_treino((i-1)*n+1:i*n,:) = [];
                        t_treino((i-1)*n+1:i*n,:) = [];
                        
                        % Beta
                        H_train = h_linear_and_morphological(x_treino, W{1}, W{2}, W{3}, W{4});
                        Beta = beta(x_treino, t_treino, H_train, 10^p);
                        % Test
                        H_test = h_linear_and_morphological(x_teste, W{1}, W{2}, W{3}, W{4});
                        avg = calculate_metric(H_test, Beta, t_teste, 1);
                        
                        avg_actual = avg_actual + avg;
                    end
                end
                if avg_actual > avg_best
                    avg_best = avg_actual;
                    W_best = W;
                    morph_best = L_morph;
                    lin_best = L_lin;
                    C_best = 10^p;
                end
            end
        end
    end
end

%% Training with the result from CV
[x_train, t_train, x_test, t_test] = data_cancer();

% Beta
H_train = h_linear_and_morphological(x_train, W_best{1}, W_best{2}, W_best{3}, W_best{4});
Beta = beta(x_train, t_train, H_train, C_best);

% Train
avg_train = calculate_metric(H_train, Beta, t_train, 1);

% Test
H_test = h_linear_and_morphological(x_test, W_best{1}, W_best{2}, W_best{3}, W_best{4});
avg = calculate_metric(H_test, Beta, t_test, 1);
