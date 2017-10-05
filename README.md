# Code-Samples
[1].gabelok_QDA_train.m, gabelok_QDA_test.m, gabelok_LDA_train.m, gabelok_LDA_test.m, gabelok_assignment3_2b.m

gabelok_QDA_train.m, gabelok_QDA_test.m, gabelok_LDA_train.m, gabelok_LDA_test.m are examples of implementing Gaussian Discriminant Analysis Classifiers. QDA or Quadratic Discriminant Analysis and LDA or Linear Discriminant Analysis classifiers are techniques of Gaussian Discriminant analysis, an application of multivariate normal (MVN), the most widely used joint probability density function for continuous variables. It is used in my assignment for multi-class classification.

gabelok_assignment3_2b.m accomplishes classification by splitting the data into a training set and a test set, learning a classifier on the training set and predicting the class labels of the sameples in the test set and calculating performance metrics. The data is provided in data_iris.mat

[2]. gabelok_assignment3_4b.m, gabelok_assignment3_4c.m, gabelok_assignment3_4d.m

gabelok_assignment3_4b.m, gabelok_assignment3_4c.m, gabelok_assignment3_4d.m are examples of implementing a non-parametric classifier called K-nearest neighbors. This method looks at the K points in the training set that are nearest to the test input x, counts how many members of each class are in this set, and returns that fraction as the estimate. The distance metric used is Euclidean distance. The dataset is provided in data_knnSimulation.mat
gabelok_assignment3_4b.m-The input is two dimensional, there are 3 classes and K = 10. First graph predicts class 2 and second graph predicts class 3.
gabelok_assignment3_4c.m-The input is two dimensional, there are 3 classes. First graph predicts class with K=1 and second graph predicts class with K=5.
gabelok_assignment3_4d.m-This is a digit recognition problem. The dataset is provided in data_mnist_train.mat and data_mnist_test.mat. Each data point represents a 28 x 28  grayscale image for hand written digits. 1-Nearest Neighbor classifier is applied to this dataset. The Euclidean distance is used to calculate the distance between the two images. At this point this runs in around 4 minutes and even at only 5 lines of code can be optimized. I report the confusion matrix, which is a measure of performance of the classifier. With the confusion matrix you can calculate properties like precision and recall to evaluate accuracy. The more zeroes or smaller the numbers on all cells but the diagonal, the better your classifier is doing. The CCR is the correct classification rate should be close to one for a good classifier.

If you can run the code, make sure the data files are in the same directory as the scripts.

[3]. PaperSim.m, Dependent_case.m:

The matlab files are simulations of Poisson shock processes. I have provided a simplified version of applying the Poisson shock model to determine the effect of dependent event frequencies and dependent losses. Shock events arrives with a Poisson distribution and the counting processes for different types of losses that occur from the events can then also be assumed Poisson. Therefore, the total loss is compound Poisson.  In this example, there is only one type of event and an individual may provide a rate for a single shock process. Additionally, it evaluates the process in the case that there could be only two different types of losses that could occur from the single type of event. Therefore, one should provide probabilities for losses of two different types.

If we consider the events to be independent, I generated two independent random variables to determine if the loss occurred or not. If we consider the events to be dependent, I generated a single random variable to compare with 2-dimensional marginal probabilities calculated from the input loss probabilities to determining which types of losses occurred.
I determined that the variance in the dependent case is larger which provides insight into properties like risk when applying this to insurance or credit risk.

PaperSim.m models loss in the independent case and Dependent_case.m models loss in the dependent case. I provided my report to give you a more comprehensive understanding of my work.

[4]. project4.cpp, test-1-MST.txt, test-2-MST.txt:

The project4.cpp file is a program that creates a minimum spanning tree for a given set of points when MST mode is specified and solves the traveling salesmen problem when FASTTSP and OPTTSP mode are specified. The program calculates distance using Euclidean distance. I used Prim's algorithm to construct an MST. FASTTSP is a near to optimal implementation of a solution to the TSP. OPTTSP is an implementation of the optimal solution to the TSP.

Inputs are a file with X,Y coordinates and mode corresponding to the type of algorithm the code will run specified at the command line. The test-1-MST.txt and test-2-MST.txt files are test inputs for the program. The first line of each file specifies the number of coordinates that will be given followed by the coordinates. 

The program essentially finds paths through the cartesian coordinate system. One of the conditions we were given was that the axes bounding the 3rd quadrant, the negative portions of the x and y axes including the origin (0, 0), were to be represented as "walls". This was only relevant for MST mode. If one of the points given lies in the 3rd quadrant then the you had to touch the "walls" before reaching the other point. For example, you are not allowed to make a path directly from (-5,-4)
to (6, 1). You must first make a path from (-5,-4)to (0, 1),and then from (0, 1) to (6, 1).

Output for MST mode is the weight of all the edges of the MST followed by all the edges of the MST unless it is not possible to construct an MST, in which case the program will output an error message.

Output for FASTTSP and OPTTSP mode is the overall length of the tour followed by the indices of the nodes hit along the tours.
