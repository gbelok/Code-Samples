clear
clc
load 'data_knnSimulation.mat';
classes = unique(ytrain);
n_points = size(Xtrain,1);
%% Calculate the Euclidean Distance between 2-D grid points and test points
Distance_matrix = zeros(200, 9216);
num = 1;
for i = -3.5:0.1:6
    for j = -3:0.1:6.5
        x = Xtrain(:,1) - i;
        y = Xtrain(:,2) - j;
        distance = sqrt(x.^2 + y.^2);
        Distance_matrix(:,num) = distance;
        num = num + 1; 
    end
end
%% Order distances in Ascending order
[V, I] = sort(Distance_matrix);
%% Predict class label using k=1 Nearest Neighbor
nearest_label = zeros(1,9216);
for column = 1:9216
    nearest = I(1,column);
    nearest_label(1,column) = ytrain(nearest);
end
%% Predict class label using k=5 Nearest Neighbor
nearest_labels = zeros(5,9216);
for column = 1:9216
    five_nearest = I(1:5,column);
    nearest_labels(:,column) = ytrain(five_nearest);
end
fiveNN_mode = mode(nearest_labels);
%% Plot
data_pts = zeros(9216,2);
n = 1;
for i = -3.5:0.1:6
    for j = -3:0.1:6.5
        data_pts(n,1) = i;
        data_pts(n,2) = j;
        n = n + 1;
    end
end
gscatter(data_pts(:,2),data_pts(:,1),nearest_label, 'rgb');
xlabel('x');
ylabel('y');
title('3.4c: k = 1 NN');
figure
gscatter(data_pts(:,2),data_pts(:,1), fiveNN_mode, 'rgb');
xlabel('x');
ylabel('y');
title('3.4c: k = 5 NN');
