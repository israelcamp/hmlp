function [x_treino,t_treino,x_teste,t_teste] = data_sintripley()

class_size = 2;
att_size = 2;
treino_size = 250;
teste_size = 1000;

data_treino = fopen('sintripley_treino.txt','r');
data_teste = fopen('sintripley_teste.txt','r');

Treino = fscanf(data_treino,'%f',[att_size+1 treino_size]);
Treino = transpose(Treino);
Teste = fscanf(data_teste,'%f',[att_size+1 teste_size]);
Teste = transpose(Teste);


fclose('all');

[x_treino, stats] = mapminmax(Treino(:, 1:class_size)', -1, 1);
x_treino = x_treino';
x_teste = mapminmax('apply', Teste(:, 1:class_size)', stats)';

t_treino = zeros(treino_size,class_size);
t_teste = zeros(teste_size,class_size);
for i = 1:treino_size
   t_treino(i, Treino(i,end) + 1) = 1;
end
for i = 1:teste_size
   t_teste(i, Teste(i,end) + 1) = 1; 
end

rng(0);
rand_seq = randperm(size(x_treino,1));
x_treino = x_treino(rand_seq,:);
t_treino = t_treino(rand_seq,:);
