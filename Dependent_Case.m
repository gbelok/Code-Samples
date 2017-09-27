%p = input('Please provide loss probabilities: ');
%eventLambda = input('Please provide rate for which an event happens: ');
eventLambda=10;
%T = input('Please provide time horizon: ');
T = 10;
p = [0.25,0.33];
n1 = 0;
n2 = 0;
%%%Calculate two-dimensional marginals
p11 = min(p);
p10 = p(1)-p11;
p01 = p(2)-p11;
p00 = 1 - max(p);
Ps = [p11,p10,p01,p00];
%%%Simulation number of events of a specific type over a given horizon
% while t<T
%     X = exprnd(eventLambda);
%     t = t + X;
%     N = N + 1;
% end
N = poissrnd(eventLambda*T);

V = zeros(500,1);
A = zeros(500,1);
for s = 1:length(V)
    num = zeros(N,1);
    for i = 1:N
        x = 0;
        U = rand;   
        for j = 1:4
            x = x + Ps(j);
            if U < x
                if j==1
                    n1 = n1 + 1;
                    n2 = n2 + 1;
                elseif j==2
                    n1 = n1 + 1;
                elseif j==3
                    n2 = n2 + 1;
                end
                break
            end
        end
        num(i) = n1+n2;
    end
    V(s) = var(num);
    A(s) = mean(num);
end
AVE = mean(num);
variance = var(num);
histogram(V,10)
figure
%histogram(A,10)
%figure



