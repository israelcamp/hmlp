function ac = accuracy(predicted, target)
[~, arg_p] = max(predicted, [], 2);
[~, arg_t] = max(target, [], 2);
ac = length(find(arg_p == arg_t))/size(arg_p,1);