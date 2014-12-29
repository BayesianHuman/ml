%Box-Mueller
%Z1=Rcos(theta)=sqrt(-2logU1)cos(2piU2)
%Z2=Rsin(theta)=sqrt(-2logU1)sin(2piU2)
%Z1 and Z2 are iid standard normal
%Z1^2+Z2^2 ~ chi-squared with 2 dof ~ Exp(1/2)
%z=lambda exp(-lambda x) -> x=-1/lambda log(1-z)
%For lambda=1/2: x = -2 log (1-z) = -2log(U1)

%% Monte Carlo Simulation
%  x[n] = A + w[n]
%  A is a const to be estimated
%  w[n] is a standard normal generated by Box-Mueller transform

clc;
n=1e2;                   %number of samples
num_iter=1e3;            %number of monte carlo iterations

A=floor(10*rand)         %constant to be estimated
A_hat=zeros(num_iter,1);
sigma=1;                 %noise standard deviation

for i=1:num_iter
    u1=rand(n,1); %~U[0,1]
    u2=rand(n,1); %~U[0,1]

    %Box-Mueller Transform
    w1=sqrt(-2*log(u1)).*cos(2*pi*u2); %~N(0,1)
    w2=sqrt(-2*log(u1)).*sin(2*pi*u2); %~N(0,1)

    x=A+sigma*w1; %x \in R
    A_hat(i)=-1/2+sqrt((x'*x)/length(x)+1/4);
end

%compute estimator statistics
A_hat_mean=sum(A_hat)/length(A_hat)
A_hat_var=sum((A_hat-A_hat_mean).^2)/length(A_hat)
A_hat_pdf=hist(A_hat)
hist(A_hat); grid on;
