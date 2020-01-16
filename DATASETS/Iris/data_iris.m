function [x_treino,t_treino,x_teste,t_teste] = data_iris
class_size = 3;
att_size = 4;
treino_size = 35;
teste_size = 15;
total_size = 150;

data_file = fopen('iris.txt','r');

Data = fscanf(data_file,'%f',[att_size+1 total_size]);
Data = transpose(Data);

fclose('all');

linhas_um_treino = linspace(101,140,40);
linhas_dois_treino = linspace(1,40,40);
linhas_tres_treino = linspace(51,90,40);

linhas_um_teste = linspace(141,150,10);
linas_dois_teste = linspace(41,50,10);
linhas_tres_teste = linspace(91,100,10);


Treino = Data([linhas_um_treino,linhas_dois_treino,linhas_tres_treino],:);
Teste = Data([linhas_um_teste,linas_dois_teste,linhas_tres_teste],:);

% data = cat(1, Treino, Teste);
% data_X = mapminmax(data(1:end,1:class_size)',-1,1)';

[x_treino,ps] = mapminmax(Treino(:,[1 2 3 4])',-1,1);
x_treino = x_treino';

x_teste = mapminmax('apply',Teste(:,[1 2 3 4])',ps)';
% x_treino = data_X(1:120, :);
% x_teste = data_X(121:end,:);

t_treino = zeros(120,class_size);
t_teste = zeros(30,class_size);
for i = 1:120
    t_treino(i,Treino(i,5)) = 1;
end
for i = 1:30
   t_teste(i,Teste(i,5)) = 1; 
end

rng(0);
rand_seq = randperm(size(x_treino,1));
x_treino = x_treino(rand_seq,:);
t_treino = t_treino(rand_seq,:);