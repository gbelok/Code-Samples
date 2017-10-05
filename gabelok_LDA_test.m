function [Y_predict] = LDA_test(X_test, LDAmodel, numofClass)
%
% Testing for LDA
%
% EC 503 Learning from Data
% Gaussian Discriminant Analysis
%
% Assuming D = dimension of data
% Inputs :
% X_test : test data matrix, each row is a test data point
% numofClass : number of classes 
% LDAmodel : the parameters of LDA classifier which has the follwoing fields
% LDAmodel.Mu : numofClass * D matrix, i-th row = mean vector of class i
% LDAmodel.Sigmapooled : D * D  covariance matrix
% LDAmodel.Pi : numofClass * 1 vector, Pi(i) = prior probability of class i
%
% Assuming that the classes are labeled  from 1 to numofClass
% Output :
% Y_predict predicted labels for all the testing data points in X_test
% Write your codes here:
[n_test, D] = size(X_test);
ln_py = log(LDAmodel.Pi);
beta = LDAmodel.Mu/LDAmodel.Sigmapooled;
%% Compute the LDA offset
gamma_mu = zeros(1, numofClass);
for i = 1:numofClass
    gamma_mu(i) = -0.5*beta(i,:)*LDAmodel.Mu(i,:)';
end
gamma = gamma_mu + ln_py;
%% Compute the LDA projection
projection = zeros(numofClass,n_test);
for i = 1:numofClass  
    projection(i,:) = beta(i,:)*X_test'+ gamma(i);     
end  
%% Compute the LDA decision rule
[~, Y_predict] = max(projection);
end
