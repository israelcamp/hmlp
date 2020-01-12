function [X_treino, T_treino, X_teste, T_teste] = liver_data()
data = load('liver.data');

rng(1);
ridx = randperm(345);
data = data(ridx,:);

T_treino = zeros(300, 2);
T_teste = zeros(45, 2);

for i = 1:300
   T_treino(i, data(i, end)) = 1; 
end

for i = 1:45
   T_teste(i, data(i+300, end)) = 1; 
end

% normalizing the data
data = mapminmax(data(:, 1:6)', -1, 1)';
X_treino = data(1:300, 1:6);
X_teste = data(301:345, 1:6);
