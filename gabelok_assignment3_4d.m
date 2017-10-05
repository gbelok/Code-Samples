load 'data_mnist_train.mat';
load 'data_mnist_test.mat';
n_test = size(X_test,1);
n_train = size(X_train,1);
%% Calculate Euclidean Distance 
D = pdist2(X_test, X_train);
%% Apply k=1 Nearest Neighbor
[min_dist, min_index] = min(D,[],2);
predicted_label = Y_train(min_index);

confusion_matrix = confusionmat(Y_test,predicted_label)

CCR = sum(diag(confusion_matrix))/10000