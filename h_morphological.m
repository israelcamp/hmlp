function H = h_morphological(X, V, W)
[num_examples,~] = size(X);
[~,num_neurons] = size(V);
H = zeros(num_examples,num_neurons);

% alpha = 2 ./ (V + W);

for j = 1:num_examples
%    e = min(alpha .* (X(j,:)' + V));
%    d = min(alpha .* (-X(j,:)' + W));
   e = min(X(j,:)' + V);
   d = min(-X(j,:)' + W);
%    H(j,:) = max(min(e,d), zeros(size(e)));
   H(j,:) = min(e,d);
end
