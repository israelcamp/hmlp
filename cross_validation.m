[X, T, ~, ~,] = pathbased_data();
n_att = size(X,2);
k = 10;
n = floor(size(X, 1) / k);
% results = zeros(k, 3);
x_teste = zeros(n, size(X,2));
t_teste = zeros(n, size(T,2));

avg_best = 0;
for p = linspace(-3, -1, 3)
    display(p)
    for L_morph = 100:100:500
        for L_lin = 100:100:500
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