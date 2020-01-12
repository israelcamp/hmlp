% Example of how to calculate the decision line for the MorphologicalPerceptron on the
% pathbased dataset
%% Read the data and compute Beta
[x_train,t_train, ~, ~] = pathbased_data();

V = [0.17 0.0; -0.5 -0.0]'; 
W = [0.5 0.9; 1.1 0.9]';
C = 0;

H_train = h_morphological(x_train, V, W);
Beta = beta(x_train, t_train, H_train, C);    
Acc = calculate_metric(H_train, Beta, t_train, 1);

%% Compute the decision line
x = linspace(0, 1, 2000);
y = linspace(0, 1, 2000);
[X, Y] = meshgrid(x, y);
points = [X(:), Y(:)];

H_train = h_morphological(points, V, W);
z = H_train * Beta;

decision_points_one = [];
io = 1;

decision_points_two = [];
it = 1;

decision_points_three = [];
ih = 1;

for j = 1:length(z)
   if abs(z(j,1) - z(j,2)) < 0.001 && abs(z(j,1) - z(j,3)) > 0.01
    decision_points_one(io,:) = points(j,:);
    io = io + 1; 
   elseif abs(z(j,1) - z(j,3)) < 0.001 && abs(z(j,1) - z(j,2)) > 0.01
    decision_points_two(it,:) = points(j,:);
    it = it + 1; 
   elseif abs(z(j,2) - z(j,3)) < 0.001 && z(j,2) > z(j,1)
    decision_points_three(ih,:) = points(j,:);
    ih = ih + 1; 
   elseif abs(z(j,2) - z(j,3)) < 0.001 && abs(z(j,1) - z(j,3)) < 0.001
    decision_points_three(ih,:) = points(j,:);
    ih = ih + 1; 
   end
end

[~, data] = max(t_train, [], 2);

x_ones = x_train(data(:) == 1, :);
x_two = x_train(data(:) == 2, :);
x_three = x_train(data(:) == 3, :);

%% Plot
dec = sortrows(decision_points_one, 2);
dect = sortrows(decision_points_two, 2);

patch('XData', [0, 1, 1, 0], 'YData', [0, 0, 1, 1], 'EdgeColor', 'none', 'FaceColor', [1., 1., 1.], 'FaceAlpha', 1.);
hold on
scatter(x_ones(:,1), x_ones(:,2), 'b', '+');
hold on
scatter(x_two(:,1), x_two(:,2), 'g', 's');
hold on
scatter(x_three(:,1), x_three(:,2), 'r', 'o');
hold on
% scatter(decision_points_one(:,1), decision_points_one(:,2), 2, 'filled', 'black'); 
% hold on
patch('XData', [dect(1,1); dec(:,1); dect(end,1)], 'YData', [dect(1,2); dec(:,2); dect(end,2)], 'EdgeColor', 'none', 'FaceColor', [0.5, 0.5, 0.5], 'FaceAlpha', 0.4);
hold on
patch('XData', dect(:,1), 'YData', dect(:,2), 'EdgeColor', 'none', 'FaceColor', [0.2, 0.2, 0.2], 'FaceAlpha', 0.4);
% hold on
% scatter(decision_points_two(:,1), decision_points_two(:,2), 2, 'filled', 'black'); 
% hold on
% scatter(decision_points_three(:,1), decision_points_three(:,2), 4, 'filled', 'b'); 
axis('off');