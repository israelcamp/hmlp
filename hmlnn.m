function [Y,Z,neto,neth]=hmlnn(W,X)

%
% Multilayer (Two Layers) Hybrid/Morphological/Linear Neural Network;
%
% Inputs: W - Cell with the coeficients matrices; 
%             Each cell represent a layer; 
%         X - matrix with the input patterns as column;
%
% Output: y - Outputs of the network; 
%         Z - Outputs of the hidden layer; 
%      neto - Activation of the neurons in the output layer; 
%      neth - Activation of the neurons in the hidden layer; 
%

[N,K]=size(X);
J=size(W{1},1);
L=size(W{2},1);

for k=1:K
  % Hidden Layer...
  clear Ax;
  Ax1=W{1}(:,3:N+2)+ones(J,1)*X(:,k)';
  Ax2=W{1}(:,N+3:2*N+2)+ones(J,1)*X(:,k)';
  Ax1=sort(Ax1',1);
  Ax2=sort(Ax2',1);
  clear ind; ind=1;
  alphah1(:,k)=Ax1(ind+[0:N:(J-1)*N]');
  alphah2(:,k)=Ax2(N+[0:N:(J-1)*N]');
  betah(:,k)=W{1}(:,2*N+3:3*N+3)*[X(:,k);1];
  neth(:,k)=W{1}(:,1).*(W{1}(:,2).*alphah1(:,k)+(1-W{1}(:,2)).*alphah2(:,k))+(1-W{1}(:,1)).*betah(:,k);
  %Z(:,k)=tanh(neth(:,k));
  Z(:,k)=1./(1+exp(-neth(:,k)));
  % Output Layer...
  clear Az;
  Az1=W{2}(:,3:J+2)+ones(L,1)*Z(:,k)';
  Az2=W{2}(:,J+3:2*J+2)+ones(L,1)*Z(:,k)';
  Az1=sort(Az1',1);
  Az2=sort(Az2',1);
  clear ind; ind=1;
  alphao1(:,k)=Az1(ind+[0:J:(L-1)*J]');
  alphao2(:,k)=Az2(J+[0:J:(L-1)*J]');
  betao(:,k)=W{2}(:,2*J+3:3*J+3)*[Z(:,k);1];
  neto(:,k)=W{2}(:,1).*(W{2}(:,2).*alphao1(:,k)+(1-W{2}(:,2)).*alphao2(:,k))+(1-W{2}(:,1)).*betao(:,k);
  %Y(:,k)=tanh(neto(:,k));
  Y(:,k)=1./(1+exp(-neto(:,k)));
end
  
  
  
