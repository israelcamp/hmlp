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
   if abs(z(j,1) - z(j,2)) < 0.01 && z(j,1) > z(j,3)
    decision_points_one(io,:) = points(j,:);
    io = io + 1; 
   end
  if abs(z(j,1) - z(j,3)) < 0.01 && z(j,1) > z(j,2)
    decision_points_two(it,:) = points(j,:);
    it = it + 1; 
  end
  if abs(z(j,2) - z(j,3)) < 0.01 && z(j,2) > z(j,1)
    decision_points_three(ih,:) = points(j,:);
    ih = ih + 1; 
  end
  if abs(z(j,2) - z(j,3)) < 0.001 && abs(z(j,1) - z(j,3)) < 0.001
    decision_points_three(ih,:) = points(j,:);
    ih = ih + 1; 
  end
end

[~, data] = max(t_train, [], 2);

x_ones = x_train(data(:) == 1, :);
x_two = x_train(data(:) == 2, :);
x_three = x_train(data(:) == 3, :);

scatter(x_ones(:,1), x_ones(:,2), 'filled', 'b');
hold on
scatter(x_two(:,1), x_two(:,2), 'filled', 'g');
hold on
scatter(x_three(:,1), x_three(:,2), 'filled', 'r');
hold on
scatter(decision_points_one(:,1), decision_points_one(:,2), 4, 'filled', 'g'); 
hold on
scatter(decision_points_two(:,1), decision_points_two(:,2), 4, 'filled', 'r'); 
hold on
scatter(decision_points_three(:,1), decision_points_three(:,2), 4, 'filled', 'b'); 