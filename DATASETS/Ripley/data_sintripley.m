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

data = cat(1, Treino, Teste);
rand_seq = randperm(size(data,1));
data = data(rand_seq,:);

data_X = mapminmax(data(:,1:class_size)',-1,1)';
x_treino = data_X(1:treino_size,:);
x_teste = data_X(treino_size+1:end,:);

t_treino = zeros(treino_size,class_size);
t_teste = zeros(teste_size,class_size);
for i = 1:treino_size
   t_treino(i,data(i,att_size+1)+1) = 1;
end
for i = treino_size+1:treino_size+teste_size
   t_teste(i-treino_size,data(i,att_size+1)+1) = 1; 
end
