% Example of how to calculate the decision line for the MorphologicalPerceptron on the
% pathbased dataset
addpath('DATASETS/Ripley');

%% Read the data and compute Beta
[x_train,t_train, x_test, t_test] = data_sintripley();

rng(10);
[V, W] = morph_random(size(x_train,2), 10);
[A, bA] = lin_random(size(x_train,2), 10, -1, 1);
C = 0.1;

H_morph = h_morphological(x_train, V, W);
H_lin = h_linear(x_train, A, bA);
H_train = cat(2, H_morph, H_lin);
Beta = beta(x_train, t_train, H_train, C);    
Acc = calculate_metric(H_train, Beta, t_train, 1);

H_morph = h_morphological(x_test, V, W);
H_lin = h_linear(x_test, A, bA);
H_train = cat(2, H_morph, H_lin);
Beta = beta(x_test, t_test, H_train, C);    
Acc = calculate_metric(H_train, Beta, t_test, 1);

%% Compute the decision line
x = linspace(-1, 1, 3000);
y = linspace(-1, 1, 3000);
[X, Y] = meshgrid(x, y);
points = [X(:), Y(:)];

H_morph = h_morphological(points, V, W);
H_lin = h_linear(points, A, bA);
H_train = cat(2, H_morph, H_lin);
z = H_train * Beta;

%% Decision points
decision_points = [];
io = 1;

for j = 1:length(z)
   if abs(z(j,1) - z(j,2)) < 0.0001
    decision_points(io,:) = points(j,:);
    io = io + 1;
   end
end

[~, data] = max(t_train, [], 2);

x_ones = x_train(data(:) == 1, :);
x_two = x_train(data(:) == 2, :);
%% Plotting
x = decision_points(:,1);
y = decision_points(:,2);


patch('XData', [-1 -1, x', 1 -1], 'YData', [-1 1, y', -1 -1], 'EdgeColor', 'none', 'FaceColor', [0.5, 0.5, 0.5], 'FaceAlpha', 0.4);
hold on
% patch('XData', [-1 1, 1 -1], 'YData', [-1 -1, 1 1], 'EdgeColor', 'none', 'FaceColor', 'r', 'FaceAlpha', 0.3);
% hold on
scatter(x_ones(:,1), x_ones(:,2), 'b', '+');
hold on
scatter(x_two(:,1), x_two(:,2), 'r', 's');
hold on
axis('off');
% scatter(decision_points(:,1), decision_points(:,2), 2, 'filled', 'black'); 
% hold on
