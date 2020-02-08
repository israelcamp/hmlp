function [V, W] = morph_random(n, m)
A = 2*rand(n, m) - 1;
B = 2*rand(n, m) - 1;
% A = normrnd(0, 0.1, n, m);
% B = normrnd(0, 0.1, n, m);
V = zeros(n, m);
W = zeros(n, m);
for i = 1:n
   for j = 1:m
      if A(i, j) >= B(i,j)
          W(i,j) = A(i,j);
          V(i,j) = B(i,j);
      else
          W(i,j) = B(i,j);
          V(i,j) = A(i,j);
      end
   end
end