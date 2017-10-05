function [Y_predict] = QDA_test(X_test, QDAmodel, numofClass)
%
% Testing for QDA
%
% EC 503 Learning from Data
% Gaussian Discriminant Analysis
%
% Assuming D = dimension of data
% Inputs :
% X_test : test data matrix, each row is a test data point
% numofClass : number of classes 
% QDAmodel: the parameters of QDA classifier which has the following fields
% QDAmodel.Mu : numofClass * D matrix, i-th row = mean vector of class i
% QDAmodel.Sigma : D * D * numofClass array, Sigma(:,:,i) = covariance
% matrix of class i
% QDAmodel.Pi : numofClass * 1 vector, Pi(i) = prior probability of class i
% 
% Assuming that the classes are labeled  from 1 to numofClass
% Output :
% Y_predict predicted labels for all the testing data points in X_test

% Write your code here:
n_test = size(X_test,1);
%% Obtain Inverse of the QDA covariance matrix
inverse_sigma = zeros(size(QDAmodel.Sigma));
for i = 1:numofClass
    inverse_sigma(:,:,i) = inv(QDAmodel.Sigma(:,:,i));
end
%% Compute the QDA decision rule
T = zeros(n_test,numofClass);
ln_pi = log(QDAmodel.Pi);
for i = 1:n_test
    for j = 1:numofClass
        x = X_test(i,:) - QDAmodel.Mu(j,:);
        s = 0.5*(x*inverse_sigma(:,:,j)*x');
        o = 0.5*(log(det(QDAmodel.Sigma(:,:,j))))-ln_pi(j);
        s = s + o;
        T(i,j) = s;
    end
end
[~, I] = min(T');
Y_predict = I';

end
