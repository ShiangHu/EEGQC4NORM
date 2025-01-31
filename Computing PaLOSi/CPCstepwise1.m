function [Lambda,Q] = CPCstepwise1(S,n,pmax,lmax)
%CPCSTEPWISE calculate the common pricinple components
%Input  S=covariances matrices pxpxk with p number of variables,k number of
%       covariance matrices
%       n number of samples for each Cov 1Xk
%       pmax number of common principle components
%       lmax maximum number of component <p
%Output
%       Lambda   eigenvalues pXk
%       Q              eigenvectors pXp (CPC)

% Reference:Trendafilov, N.T., 2010. Stepwise estimation of common principal components. 
% Computational Statistics and Data Analysis 12.

% Pedro, Andy, Aug8, 2019


n=n(:)';
[p,~,k]=size(S);
n = reshape(n,[1,1,k]);
nt=sum(n);
Spooled=sum(S.*repmat(n./nt,[p,p,1]),3);
[qtilde,~]=eig(Spooled);
Pi=eye(p);
Lambda=zeros(p,k);
Q=zeros(p,p);
mu=zeros(1,1,k);

for  j=1:pmax
    x=qtilde(:,j);
    x = x./sqrt(x'*x);
    x=Pi*x;
    for i=1:k, mu(1,1,i)=x'*S(:,:,i)*x; end %i
    
    for l=1:lmax
        Spooled=sum(S.*repmat(n./mu,p,p,1),3);
        y=Pi*Spooled*x;
        x=y./sqrt(y'*y);
        for i=1:k, mu(1,1,i)=x'*S(:,:,i)*x; end%i
    end%l
    
    Q(:,j)=x;
    Pi=Pi-x*x';
    
end %p
for i=1:k, Lambda(:,i)=diag(Q'*S(:,:,i)*Q); end%i


% output predefined number of CPs
Lambda = Lambda(1:pmax,:);
Q = Q(:,1:pmax);
end

