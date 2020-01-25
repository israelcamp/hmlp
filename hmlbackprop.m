function [W,Error,ErrorMin,W_opt,Epoch, ErrorV] = hmlbackprop(netp,X,d,Xv,dv)

%
% Back-propagation algorithm for training HMLP-NNs.
%
% Inputs:    netp - A vector [m,n], where m is the number of hidden units and n is the number of output units;  
%               X - Training samples. Each pattern is a column of X;
%               d - Target or Desired System output (row vector);
% (Optional):  Xv - Validation samples;
%              dv - Validation Target;
%              Xt - Test samples;
%              dt - Test Target;
%
% Output: W - Cell with the synaptic weight vectors;
%     Error - Vector with the MSE by epoch;
%
min_error=10^(-6);%nao esquecer de mudar aqui quando necessario!!;

J=netp(1); L=netp(2); 
if length(netp)>2
  itmax=netp(3);
else
  itmax=1000;
end 
clear netp;

[N,K]=size(X);

% Initialization;
%W{1}=[0.2*rand(J,1)+0.4,rand(J,1),0.2*rand(J,2*N)-0.1,1/sqrt(N)*(2*rand(J,N+1)+1)];
%W{2}=[0.2*rand(L,1)+0.4,rand(L,1),0.2*rand(L,2*J)-0.1,1/sqrt(J)*(2*rand(L,J+1)+1)];
W{1}=[rand(J,1),rand(J,1),2*rand(J,2*N)-1,2*rand(J,N+1)-1];
W{2}=[rand(L,1),rand(L,1),2*rand(L,2*J)-1,2*rand(L,J+1)-1];
clear Waux;

rho_vet(:,1)=[W{1}(:,2);W{2}(:,2)];

Kv=0; Kt=0;
ErrorMin=Inf;
ErrorValMin=Inf;
if nargin<6
   max_delta_error_valid=0.05; 
end
    
    
Epoch=itmax;

%if nargin>3
%  X=[X,Xv];
%  Kv=size(Xv,2);
%  clear Xv;
%  ErrorMin=ones(2,1)*inf;
%  if nargin>5
%    X=[X,Xt];
%    Kt=size(Xt,2);
%    clear Xt;
%    ErrorMin=ones(3,1)*inf;
%  end
%end

% Backprop parameters
rhoatual=10^(-2);
rhoanterior=rhoatual*0.9;

it=0; Terminate=0;

dWanterior{1}=zeros(J,3*N+3);
dWanterior{2}=zeros(L,3*J+3);

while (it<=itmax)&&(~Terminate)
  % Iteration Counter...
  it=it+1;
  
  Kind=randperm(K);
  for i=1:K
    % Select k;
    k=Kind(i);
  
    % Network evaluation...
    clear Ax1; clear Az1;
    clear Ax2; clear Az2;
    clear alphah; clear alphao;
    clear alphah1; clear alphao1;
    clear alphah2; clear alphao2;
    clear alphah11; clear alphao11;
    clear alphah21; clear alphao21;
    clear Qh1; clear Qo1;
    clear Qh2; clear Qo2;
    clear SQh1; clear SQo1;
    clear SQh2; clear SQo2;
    clear neto; clear neth;
    clear Z; clear Y;
  
    % Hidden Layer...
    Ax1=W{1}(:,3:N+2)+ones(J,1)*X(:,k)';%Ax � uma matriz com 2 colunas(eros�o),onde cada linha representa um neur�nio;
    Ax2=W{1}(:,N+3:2*N+2)+ones(J,1)*X(:,k)';%dilata��o
    alphah1=sort(Ax1',1);%transp�e Ax e ordena cada coluna desta transposta;
    alphah2=sort(Ax2',1);
    clear ind; ind=1;%define o rank;
    alphah11=alphah1(ind+[0:N:(J-1)*N]');%determina o valor correspondente a cada rank, em num vetor coluna;(eros�o)
    alphah21=alphah2(N+[0:N:(J-1)*N]');%determina o valor correspondente a cada rank, em num vetor coluna;(dilata��o)
    %Qh1=(alphah11*ones(1,N)==Ax1);%pega a matriz Ax1 colocando 0 ou 1 de acordo com o rank escolhido;
    %Qh2=(alphah21*ones(1,N)==Ax2);%pega a matriz Ax2 colocando 0 ou 1 de acordo com o rank escolhido;
    Qh1=exp(-0.5*((alphah11*ones(1,N)-Ax1)/0.05).^2);%utilizar estas duas funcoes quando quiser utilizar o "Q smoothing";
    Qh2=exp(-0.5*((alphah21*ones(1,N)-Ax2)/0.05).^2);
    SQh1=sum(Qh1,2);
    SQh2=sum(Qh2,2);
    betah=W{1}(:,2*N+3:3*N+3)*[X(:,k);1];%� um vetor coluna onde cada linha representa um neur�nio;
    neth=W{1}(:,1).*(W{1}(:,2).*alphah11+(1-W{1}(:,2)).*alphah21)+(1-W{1}(:,1)).*betah;
    %Z=tanh(neth);
    Z=1./(1+exp(-neth));
    % Output Layer...
    Az1=W{2}(:,3:J+2)+ones(L,1)*Z';
    Az2=W{2}(:,J+3:2*J+2)+ones(L,1)*Z';
    alphao1=sort(Az1',1);
    alphao2=sort(Az2',1);
    clear ind; ind=1;
    alphao11=alphao1(ind+[0:J:(L-1)*J]');
    alphao21=alphao2(J+[0:J:(L-1)*J]');
    %Qo1=(alphao11*ones(1,J)==Az1);
    %Qo2=(alphao21*ones(1,J)==Az2);
    Qo1=exp(-0.5*((alphao11*ones(1,J)-Az1)/0.05).^2);
    Qo2=exp(-0.5*((alphao21*ones(1,J)-Az2)/0.05).^2);
    SQo1=sum(Qo1,2);
    SQo2=sum(Qo2,2);
    betao=W{2}(:,2*J+3:3*J+3)*[Z;1];
    neto=W{2}(:,1).*(W{2}(:,2).*alphao11+(1-W{2}(:,2)).*alphao21)+(1-W{2}(:,1)).*betao;
    %Y=tanh(neto);
    Y=1./(1+exp(-neto));
    clear Az; clear Ax;
    
    % Back-propagate the error...
    % Output Layer...
    deltao=(d(:,k)-Y).*((Y).*(1-Y));
    gammao=[(W{2}(:,2).*alphao11+(1-W{2}(:,2)).*alphao21)-betao,W{2}(:,1).*(alphao11-alphao21),diag(W{2}(:,1).*W{2}(:,2)./SQo1)*Qo1,diag(W{2}(:,1).*(1-W{2}(:,2))./SQo2)*Qo2,(1-W{2}(:,1))*[Z',1]];
    % Hidden Layer...
    deltah=((gammao(:,3:J+2)+gammao(:,J+3:2*J+2)+diag(1-W{2}(:,1))*W{2}(:,2*J+3:3*J+2))'*deltao).*((Z).*(1-Z));
    gammah=[W{1}(:,2).*alphah11+(1-W{1}(:,2)).*alphah21-betah,W{1}(:,1).*(alphah11-alphah21),diag(W{1}(:,1).*W{1}(:,2)./SQh1)*Qh1,diag(W{1}(:,1).*(1-W{1}(:,2))./SQh2)*Qh2,(1-W{1}(:,1))*[X(:,k)',1]];
  
    % Updating...
    dWatual{1}=diag(deltah)*gammah;
    dWatual{2}=diag(deltao)*gammao;
    
    W{1}=W{1}+rhoatual*dWatual{1}+rhoanterior*dWanterior{1};
    W{2}=W{2}+rhoatual*dWatual{2}+rhoanterior*dWanterior{2};
    
    %if nargin>5
    %    if(max(max(max(abs(dWanterior{1}-dWatual{1}))),max(max(abs(dWanterior{2}-dWatual{2})))) < min_grad)
    %        Terminate=1;
    %    else
    %        Terminate=0;
    %    end
    %end
    
    dWanterior{1}=dWatual{1};
    dWanterior{2}=dWatual{2};
  end
  rho_vet(:,it+1)=[W{1}(:,2);W{2}(:,2)];
  
  % Computing the Error...
  Y=hmlnn(W,X);
  [nr,nc] = size(d-Y);
  v = reshape(d-Y,nr*nc,1);
  n_v = length(v);
  %rms = sqrt(sum(v.*v)/n_v);
  Error(it,1)=(sum(v.*v)/n_v);
  %Error(it,1)=norm(d-Y(:,1:K));
  
  if it>100
  if(abs(Error(it,1)-Error(it-1,1)) <= min_error)|(Error(it,1)<=0.005)%criterio de parada com base no erro;
            Terminate=1;
        else
            Terminate=0;
        end
  end
  aux_count = sum(abs(ceil(d)-ceil(Y)));
  
  if(Error(it,1)<ErrorMin)
      ErrorMin=Error(it,1);
      W_opt=W;%melhor erro treino;
      Epoch = it;
  end
  
  if nargin>3      
      Y=hmlnn(W,Xv);
      [nr,nc] = size(dv-Y);
      v = reshape(dv-Y,nr*nc,1);
      n_v = length(v);
      %rms = sqrt(sum(v.*v)/n_v);
      ErrorV(it,1)=(sum(v.*v)/n_v);
      
      %ErrorV(it,1)=norm(dv-Y);  
      
      if(ErrorValMin>ErrorV(it,1))
          ErrorValMin=ErrorV(it,1);
          %W_opt=W;%melhor erro validacao;
      end
      
      fprintf('Iteration: %d, Training Error = %2.4f , Validation Error = %2.4f (%2.4f)', it, Error(it,1))
      
      if((ErrorV(it,1)-ErrorValMin)>max_delta_error_valid)
          Terminate = 1;          
      end
      
  else
      fprintf('Iteration: %d, Training Error = %2.4f (%2.4f)', it, Error(it,1))
  end  
end  

rho_vet(1:J,:)=round(N-(N-1)./(1+exp(rho_vet(1:J,:))));
rho_vet(J+1,:)=round(J-(J-1)./(1+exp(rho_vet(J+1,:))));