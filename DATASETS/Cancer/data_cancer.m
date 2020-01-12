function [x_treino,t_treino,x_teste,t_teste] = data_cancer
class_size = 2;
att_size = 30;
treino_size = 397;
treino_m1 = 148;
treino_b2 = 249;
teste_size = 172;
teste_m1 = 64;
teste_b2 = 108;
total_size = 569;

data = fopen('data.txt','r');

Data_cancer = fscanf(data,'%f',[att_size+2 total_size]);
Data_cancer = transpose(Data_cancer);
Data_cancer = Data_cancer(:,2:end);

fclose('all');

%normalizando
datax = mapminmax(Data_cancer(:,2:end)')';

x_treino = zeros(treino_size,att_size);
x_teste = zeros(teste_size,att_size);
t_treino = -ones(treino_size, class_size);
t_teste = -ones(teste_size, class_size);

counter_m = 0;
counter_b = 0;
linha_m = 0;
linha_b = 0;
for i = 1:total_size
    if(Data_cancer(i,1) == 1)
        linha_m = [linha_m,i];
    else
        linha_b = [linha_b,i];
    end
end
linha_m = linha_m(2:end);
linha_b = linha_b(2:end);

x_treino(1:treino_m1,:) = datax(linha_m(1:treino_m1),:);
t_treino(1:treino_m1,Data_cancer(linha_m(1:treino_m1),1)) = 1;
x_treino(treino_m1+1:end,:) = datax(linha_b(1:treino_b2), :);
t_treino(treino_m1+1:end, Data_cancer(linha_b(1:treino_b2),1)) = 1;

x_teste(1:teste_m1,:) = datax(linha_m(1:teste_m1),:);
t_teste(1:teste_m1,Data_cancer(linha_m(1:teste_m1),1)) = 1;
x_teste(teste_m1+1:end,:) = datax(linha_b(1:teste_b2), :);
t_teste(teste_m1+1:end, Data_cancer(linha_b(1:teste_b2),1)) = 1;

rng(0);
rand_seq = randperm(size(x_treino,1));
x_treino = x_treino(rand_seq,:);
t_treino = t_treino(rand_seq,:);
