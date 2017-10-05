function [QDAmodel]= QDA_train(X_train, Y_train, numofClass)
%
% Training QDA
%
% EC 503 Learning from Data
% Gaussian Discriminant Analysis
%
% Assuming D = dimension of data
% Inputs :
% X_train : training data matrix, each row is a training data point
% Y_train : training labels for rows of X_train
% numofClass : number of classes 
%
% Assuming that the classes are labeled  from 1 to numofClass
% Output :
% QDAmodel : the parameters of QDA classifier which has the following fields
% QDAmodel.Mu : numofClass * D matrix, i-th row = mean vector of class i
% QDAmodel.Sigma : D * D * numofClass array, Sigma(:,:,i) = covariance matrix of class i
% QDAmodel.Pi : numofClass * 1 vector, Pi(i) = prior probability of class i

% Write your code here:
D = size(X_train,2);
%% Find the unique labels or classes 
labels = unique(Y_train);
%% Find the number of times a label/class occurs in Y_train
count = zeros(numofClass,1);
for k = 1:numofClass
  count(k) = sum(Y_train==labels(k));
end
%% Obtain the probability that a label/class occurs within a given Y_train
for i = 1:numofClass 
    QDAmodel.Pi(i) = count(i)/length(Y_train);%ny(i)/length(Y_train);
end
%% Compute the QDA mean vector
for i = 1:numofClass 
    s = zeros(1,D);
    for j = 1:length(Y_train)
        if Y_train(j) ==  labels(i)
            s = s + X_train(j,:);
        end
    end
    s = s/count(i);
    QDAmodel.Mu(i,:) = s;
end        
%% Compute the QDA covariance matrix
for i = 1:numofClass
    s = zeros(D,D);
    for j = 1:length(X_train)
        if Y_train(j) ==  labels(i)
            x = X_train(j,:) - QDAmodel.Mu(i,:);
            s = s + (x'*x);
        end
    end
   
    QDAmodel.Sigma(:,:,i) = s/count(i);
end
