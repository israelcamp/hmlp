function [x_treino,t_treino,x_teste,t_teste] = data_wine
[x,t] = wine_dataset;
x = x'; x = mapminmax(x')';
t = t';
%% For the article
rng(1);
ridx = randperm(size(x,1));
x = x(ridx,:); t = t(ridx,:);

treino_size = floor(0.75*size(x,1));
x_treino = x(1:treino_size,:);
x_teste  = x((treino_size + 1):end,:);

t_treino = t(1:treino_size,:);
t_teste = t(treino_size+1:end,:);
end