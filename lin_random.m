function [A, bA] = lin_random(n, m, min_val, max_val)
A = (max_val - min_val) * rand(n,m) + min_val;
bA = max_val * rand(m,1);