# Code-Samples

[1]. PaperSim.m, Dependent_case.m:

The matlab files are simulations of Poisson shock processes. I have provided a simplified version of applying the Poisson shock model to determine the effect of dependent event frequencies and dependent losses. Shock events arrives with a Poisson distribution and the counting processes for different types of losses that occur from the events can then also be assumed Poisson. Therefore, the total loss is compound Poisson.  In this example, there is only one type of event and an individual may provide a rate for a single shock process. Additionally, it evaluates the process in the case that there could be only two different types of losses that could occur from the single type of event. Therefore, one should provide probabilities for losses of two different types.

If we consider the events to be independent, I generated two independent random variables to determine if the loss occurred or not. If we consider the events to be dependent, I generated a single random variable to compare with 2-dimensional marginal probabilities calculated from the input loss probabilities to determining which types of losses occurred.
I determined that the variance in the dependent case is larger which provides insight into properties like risk when applying this to insurance or credit risk.

PaperSim.m models loss in the independent case and Dependent_case.m models loss in the dependent case. I provided my report to give you a more comprehensive understanding of my work.

[2]. project4.cpp, test-1-MST.txt, test-2-MST.txt:

The project4.cpp file is a program that creates a minimum spanning tree for a given set of points when MST mode is specified and solves the traveling salesmen problem when FASTTSP and OPTTSP mode are specified. The program calculates distance using Euclidean distance. I used Prim's algorithm to construct an MST. FASTTSP is a near to optimal implementation of a solution to the TSP. OPTTSP is an implementation of the optimal solution to the TSP.

Inputs are a file with X,Y coordinates and mode corresponding to the type of algorithm the code will run specified at the command line. The test-1-MST.txt and test-2-MST.txt files are test inputs for the program. The first line of each file specifies the number of coordinates that will be given followed by the coordinates. 

The program essentially finds paths through the cartesian coordinate system. One of the conditions we were given was that the axes bounding the 3rd quadrant, the negative portions of the x and y axes including the origin (0, 0), were to be represented as "walls". This was only relevant for MST mode. If one of the points given lies in the 3rd quadrant then the you had to touch the "walls" before reaching the other point. For example, you are not allowed to make a path directly from (-5,-4)
to (6, 1). You must first make a path from (-5,-4)to (0, 1),and then from (0, 1) to (6, 1).

Output for MST mode is the weight of all the edges of the MST followed by all the edges of the MST unless it is not possible to construct an MST, in which case the program will output an error message.

Output for FASTTSP and OPTTSP mode is the overall length of the tour followed by the indices of the nodes hit along the tours.
