function metric = calculate_metric(H, Beta, T, type)
Y = H * Beta;
if type == 1
    metric = accuracy(Y, T);
else
    metric = sqrt(sum((Y - T).^2)/size(Y,1));
end