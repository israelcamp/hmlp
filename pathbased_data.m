function [x_train, y_train, x_test, y_test] = pathbased_data()

data = load('pathbased.txt');

x_ones = data(data(:,3) == 1, :);
x_two = data(data(:,3) == 2, :);
x_three = data(data(:,3) == 3, :);

train = cat(1, x_ones(:, :), x_two(:, :), x_three(:, :));

x_train = train(:, 1:2);
y_train = bsxfun(@eq, train(:, 3), 1:max(train(:, 3)));

x_train = mapminmax(x_train', 0, 1)';


% x_train = [0.2000    0.4000;
%     0.3000    0.5000;
%     0.4000    0.4000;
%     0.3500    0.5000;
%     0.6000    0.6000;
%     0.7000    0.5000;
%     0.7500    0.5000;
%     0.8000    0.4000;
%     0.1000    0.1500;
%     0.2000    0.9000;
%     0.5500    0.9500;
%     0.8500    0.8500;
%     1.0000    0.5000;
%     0.8500    0.1000];
% 
% y_train = [ 1     0     0;
%      1     0     0;
%      1     0     0;
%      1     0     0;
%      0     1     0;
%      0     1     0;
%      0     1     0;
%      0     1     0;
%      0     0     1;
%      0     0     1;
%      0     0     1;
%      0     0     1;
%      0     0     1;
%      0     0     1];




x_test = x_train;
y_test = y_train;

% 
% scatter(x_ones(:,1), x_ones(:,2));
% hold on;
% scatter(x_two(:,1), x_two(:,2));
% hold on;
% scatter(x_three(:,1), x_three(:,2));


end

