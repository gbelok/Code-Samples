clear
clc
%% Load the data set
load 'data_iris.mat';
numofClass = 3;
%% Initializing outputs
average_mu = zeros(3,4);
diag_Sigma = zeros(4,3);
LDA_variances = zeros(4,1);
test_QDA_CCRs = zeros(1,10);
test_LDA_CCRs = zeros(1,10);
CM = zeros(3,3,10);
for i = 1:10
    %splits = 10;
    %num_training = 100;
    %num_test = 50;
    %% Randomize indices of X
    index_vector = randperm(size(X,1));
    %% Split data into a training set and a test set
    v_train = index_vector(find(index_vector,100));
    v_test = index_vector(find(index_vector,50,'last'));
    X_train = X(v_train,:);
    Y_train = Y(v_train');
    X_test = X(v_test,:);
    Y_test = Y(v_test');
    %% Train data
    QDA_model = QDA_train(X_train,Y_train, numofClass);
    LDA_model = LDA_train(X_train,Y_train, numofClass);

    %% Obtain mean vectors
    average_mu = average_mu + 0.1*QDA_model.Mu;

    %% Obtain average variance
    for j = 1:numofClass
        diag_Sigma(:,j) = diag_Sigma(:,j) + 0.1*diag(QDA_model.Sigma(:,:,j));    
    end
    LDA_variances = LDA_variances + diag(0.1*LDA_model.Sigmapooled);
    %% Compute the confusion matrices
    Y_predict_QDA = QDA_test(X_test,QDA_model,numofClass);
    confusion_matrix_QDA = confusionmat(Y_test,Y_predict_QDA);
    
    Y_predict_LDA = LDA_test(X_test,LDA_model,numofClass);
    confusion_matrix_LDA = confusionmat(Y_test,Y_predict_LDA);
    CM(:,:,i) = confusion_matrix_LDA;
    %% Obtain CCRS for QDA and LDA  
    test_QDA_CCRs(i) = sum(diag(confusion_matrix_QDA))/50;
    test_LDA_CCRs(i) = sum(diag(confusion_matrix_LDA))/50;
end
average_mu
diag_Sigma
LDA_variances
mean_QDA_test_CCRS = mean(test_QDA_CCRs)
std_QDA_test_CCRS = std(test_QDA_CCRs)
mean_LDA_test_CCRS = mean(test_LDA_CCRs)
std_LDA_test_CCRS = std(test_LDA_CCRs)
[r,c_min]= min(test_LDA_CCRs);
worst_confusion_matrix = CM(:,:,c_min)
[r,c_max]= max(test_LDA_CCRs);
best_confusion_matrix = CM(:,:,c_max)