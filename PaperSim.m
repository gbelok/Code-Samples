%p = input('Please provide loss probabilities: ');
%eventLambda = input('Please provide rate for which an event happens: ');
eventLambda=10;
%eventLambda = [3,4,4];
%T = input('Please provide time horizon: ');
T = 10;
p = [0.25,0.33];
t = 0;
n1 = 0;
n2 = 0;

% p11 = p(1)*p(2);
% p10 = p(1)*(1-p(2));
% p01 = (1-p(1))*p(2);
% p00 = (1-p(1))*(1-p(2));
% while t<T
%     X = exprnd(eventLambda);
%     t = t + X;
%     N = N + 1;
% end
N = poissrnd(eventLambda*T);
%num = zeros(N,1);
V = zeros(500,1);
A = zeros(500,1);
for j = 1:length(V)
    num = zeros(N,1);
    for i = 1:N
        U1 = rand;
        U2 = rand;
        if U1 < p(1)
            n1 = n1+1;
        end

        if U2 < p(2)
            n2 = n2+1;
        end
        num(i) = n1+n2;
    end
    V(j) = var(num);
    A(j) = mean(num);
end
AVE = mean(num);
variance = var(num);
histogram(V,10)
figure
%histogram(A,10)
%figure

