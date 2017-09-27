# Code-Samples
The matlab files are simulations of Poisson shock processes. Shock events arrives with a Poisson distribution and the counting processes for different types of losses that occur from the events can also be modeled with a Poisson distribution. I have provided a simplified version of applying the Poisson shock model to determine the effect of dependent event frequencies. In this example, there is only one type of event and an individual may provide a rate for a single shock process.
Additionally, it evaluates the process in the case that there could be only two different types of losses that could occur from the single type of event. Therefore, one should provide probabilities for losses of two different types.

If we consider the events to be independent, we generated two independent random variables to determine if the loss occurred or not. If we consider the events to be dependent, I generated a single random variable to compare with 2-dimensional marginal probabilities calculated from the input loss probabilities to determining which types of losses occurred.
I determined that the variance in the dependent case is larger which provides insight into properties like risk when applying this to insurance or credit risk.

PaperSim.m models loss in the independent case and Dependent_case.m models loss in the dependent case.

The project4.cpp file is a program that creates a minimum spanning tree for a given set of points when MST mode is specified and solves the traveling salesmen problem when FASTTSP and OPTTSP mode are specified. FASTTSP is a near to optimal implementation of a solution to the TSP. OPTTSP is an implementation of the optimal solution to the TSP.

Inputs are a file with X,Y coordinates and mode corresponding to the type of algorithm the code will run specified at the command line.
Output for MST mode is the weight of all the edges of the MST followed by all the edges of the MST unless it is not possible to construct an MST, in which case the program will output an error message.
Output for FASTTSP and OPTTSP mode is the overall length of the tour followed by the indices of the nodes hit along the tours
