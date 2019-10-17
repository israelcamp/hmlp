function H = h_linear_and_morphological(X, V, W, A, bA)
hm = h_morphological(X, V, W);
hl = h_linear(X, A, bA);
H = cat(2, hm, hl);
