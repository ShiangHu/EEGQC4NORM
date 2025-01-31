function [coh,cohy] = cs2coh(data)
% CS2COH transform cross spectra tensor to cross cohernece/coherency tensor
% Input
%          data --- Nc*Nc*Nf
% Output
%          coh  --- real tensor Nc*Nc*Nf
%          cohy --- complex tensor Nc*Nc*Nf
%
% Andy, Apr. 2019
% See more in the meth toolbox (Guido Nolte)

psd = tdiag(data);
[Nc, Nf] = size(psd);
psdt = reshape(psd,[Nc 1 Nf]).*reshape(psd,[1 Nc Nf]);

coh = abs(data).^2./psdt;

cohy = data./sqrt(psdt);
end