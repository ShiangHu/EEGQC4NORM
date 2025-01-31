function [Lambda,Q] = CPCstepwise(S,n,lmax)
%CPCSTEPWISE calculate the common pricinple components
%Input  S=covariances matrices pxpxk with p number of variables,k number of
%       covariance matrices
%       n number of samples for each Cov 1Xk
%       lmax maximum number of cokponent <p
%Output
%       Lambda   eigenvalues pXk
%       Q              eigenvectors pXp (CPC)
% Reference: Stepwise Common Principal Components Trendafilov

% Pedro, Andy


n=n(:)';
n = shiftdim(n,-1);
[p,~,k]=size(S);
nt=sum(n);
Spooled=sum(S.*repmat(n./nt,[p,p,1]),3);
[qtilde,~]=eig(Spooled);
Pi=eye(p);
Lambda=zeros(p,k);
Q=zeros(p,p);
mu=zeros(1,k);

for  j=1:p
    x=qtilde(:,j);
    x=Pi*x;
    for i=1:k, mu(i)=x'*S(:,:,i)*x; end %i
    
    for l=1:lmax
        mus = shiftdim(mu,-1);
        Spooled=sum(S.*repmat(n./mus,p,p,1),3);
        y=Pi*Spooled*x;
        x=y./sqrt(y'*y);
        for i=1:k, mu(i)=x'*S(:,:,i)*x; end%i
    end%l
    
    Q(:,j)=x;
    Lambda(j,:)=mu;
    Pi=Pi-x*x';
    
end %p

end

