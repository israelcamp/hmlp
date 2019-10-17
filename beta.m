function Beta = beta(X, T, H, C)
%% Calculate Beta
if size(X,1) >= size(H,2)
    Beta = (H'  *  H + eye(size(H',1)) * (C)) \ ( H'  *  T);
else
    Beta = (H'/(H  *  H' + eye(size(H,1)) * (C))) * (T);
end