function [X_treino, T_treino, X_teste, T_teste] = mice_data()
mice_data = load('mice_data.data');
X = mapminmax(mice_data(:, 1:77)', -1, 1)';
T = mice_data(:, end);

rng(1);
ridx = randperm(1080);
X = X(ridx, :);
T = T(ridx, :);

T_treino = zeros(864, 8);
T_teste = zeros(216, 8);

for i = 1:864
   T_treino(i, T(i)) = 1; 
end

for i = 1:216
   T_teste(i, T(i)) = 1; 
end

X_treino = X(1:864,:);
X_teste = X(865:1080,:);