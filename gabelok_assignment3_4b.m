load 'data_knnSimulation.mat';
n_points = size(Xtrain,1);
%% Compute Euclidean distance between each point on 2-D grid to the Test points
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
%% Order the distances in ascending order
[V, I] = sort(Distance_matrix);
nearest_labels = zeros(10,9216);
%% Find the Ten Nearest Neighbors
for column = 1:9216
    ten_nearest = I(1:10,column);
    nearest_labels(:,column) = ytrain(ten_nearest);
end
%% Calculate the probability of being class 2, repeated for class 3
prob2 = zeros(1,9216);
prob3 = zeros(1,9216);
for c = 1:9216
    n_y2 = sum(nearest_labels(:,c) == 2);
    n_y3 = sum(nearest_labels(:,c) == 3);
    prob2(c) = n_y2/10;  
    prob3(c) = n_y3/10; 
end
M2 = reshape(prob2,96,96);
M3 = reshape(prob3,96,96);
x_grid = -3.5:0.1:6;
y_grid = -3:0.1:6.5;
imagesc('XData',x_grid,'YData',y_grid,'CData',M2');
colorbar
xlabel('x');
ylabel('y');
title('3.4b: p(y=2|data.k=10)');
figure
imagesc('XData',x_grid,'YData',y_grid,'CData',M3');
colorbar
xlabel('x');
ylabel('y');
title('3.4b: p(y=3|data.k=10)');
