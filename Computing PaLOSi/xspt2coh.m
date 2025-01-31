function C = xspt2coh (spt)
% XSPT2COH convert the crossspectra to coherence matrix
% Input
%         spt --- [nc*nc*nf*nind..] crossspectra tensor
%           c  --- [nc*nc*nf*nind...] coherence tensor

% Andy, 29/Apr/2019

if isreal (spt)
    spt = real2hmt(spt);
end
[sz1,sz2,nslice] = size(spt);
sz3 = size(spt,3);
spt = reshape(spt,[sz1 sz2 nslice]);
C = zeros(size(spt));

% magnitude squared coherence
for i=1:nslice
    power = diag(spt(:,:,i));
    C(:,:,i) = abs(spt(:,:,i)).^2 ./ (power*power');
end

C = sqrt(C);
C = reshape(C,[sz1 sz2 sz3 nslice/sz3]);
end