function H = h_morphological(X, V, W)
[num_examples,~] = size(X);
[~,num_neurons] = size(V);
H = zeros(num_examples,num_neurons);

for j = 1:num_examples
   e = min(X(j,:)' + V);
   d = min(-X(j,:)' + W);
   H(j,:) = max(min(e,d), zeros(size(e)));
%    H(j,:) = min(e,d);
end
