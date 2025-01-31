function [Pxy, f, nss] = xspt(data,nw,fs,varargin)
% xspt calculates the cross spectral matrix of multivariate time
% series with Thomson multitaper method.
% Usage: [Pxy, f] = crossspectrum(data,nw,nfft,fs,fmax)
% Input
%   data --- nchannel by sl by ns
%     nw --- time-bandwidth product, 2, 2.5, 3, 3.5, 4
%   nfft --- number of FFT. nFFT > 2*fs
%     fs --- sampling frequency
%   fmax --- maximum frequency
% Output
%    Pxy --- cross spectrum matrix, nchannel by nchannel by nfreq
%      f --- nfreq by 1
%  nss --- number of segments * (2*nw-1) 

% Shiang Hu, Sep. 15, 2019
% See also PMTM

[nc, nt, ns] = size(data);
nfft = 2.56*fs;
if ns == 1  %     warning('only 1 segment?')
    ns = floor(nt/nfft);
    data = reshape(data(:,1:ns*nfft),[nc nfft ns]);
end

f = fs/nfft*(1:nfft);

fftidx = 1:nfft;

if ~isempty(varargin)
    fmax = varargin{1}; fmin = varargin{2};
    fftidx = (f>=fmin&f<=fmax);
    f = f(fftidx);
end
nf = length(f);

% generate the slepian sequences
E = dpss(nfft, nw); E(:,end)=[];
E = repmat(shiftdim(E,-1),[nc,1,1]);

% cross spectrum
Pxy = zeros(nc,nc,nf);
for i = 1:ns
    dati = data(:,:,i);
    dati = repmat(dati,[1,1,size(E,3)]).*E;
    fc_i = fft(dati,[],2);
    fc_i = fc_i(:,fftidx,:);
    
    Pxy_i = zeros(nc,nc,nf);
    for j = 1:nf
        Pxy_i(:,:,j) = cov(squeeze(fc_i(:,j,:)).',1); % note the non-conjucate transpose
    end
    Pxy = Pxy + Pxy_i;
end
nss = ns*(2*nw-1);
Pxy = Pxy/nss;
end