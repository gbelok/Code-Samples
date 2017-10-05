function [LDAmodel] = LDA_train(X_train, Y_train, numofClass)
%
% Training LDA
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
% LDAmodel : the parameters of LDA classifier which has the following fields
% LDAmodel.Mu : numofClass * D matrix, i-th row = mean vector of class i
% LDAmodel.Sigmapooled : D * D  covariance matrix
% LDAmodel.Pi : numofClass * 1 vector, Pi(i) = prior probability of class i
%
% Write your codes here:
D = size(X_train,2);
%% Find the unique labels or classes 
labels = unique(Y_train);
%% Find the number of times a label/class occurs in Y_train
count = zeros(numofClass,1);
for k = 1:numofClass
  count(k) = sum(Y_train==labels(k));
end
%% Obtain the probability that a label/class occurs within a given Y_t
for i = 1:numofClass 
    LDAmodel.Pi(i) = count(i)/length(Y_train);
end
%% Compute the LDA mean vector
for i = 1:numofClass    
    s = zeros(1,D);
    for j = 1:length(Y_train)
        if Y_train(j) ==  labels(i)
            s = s + X_train(j,:);
        end
    end
    s = s/count(i);
    LDAmodel.Mu(i,:) = s;
end
%% Compute the LDA covariance matrix
sigma = zeros(D,D);
for i = 1:numofClass
    for j = 1:length(Y_train)
        if Y_train(j) ==  labels(i)
            x = X_train(j,:) - LDAmodel.Mu(i,:);
            sigma = sigma + (x'*x);           
        end
    end
end
LDAmodel.Sigmapooled = sigma/length(Y_train);

end
