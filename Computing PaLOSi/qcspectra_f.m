function [pro, f]= qcspectra_f(EEG,nw,fs,varargin)
% computing the palosi by dividing the orginal energy of raw noisy data instead of
% the clean data at its own step
% Input
%       EEG: data (nc-nt-ns / nc-nt)
%       nw: time-halfbandwidth product
%       fs: sampling rate
%       fmax: maximum frequency stored in varargin{1}
%       fmin: minimum frequency  stored in varargin{2}
%       ssd --- varargin{3}
% Output
%         pro ---- proportion
%
% The sum of power spectra equals to the sum of explained variance/engergy (eigenvalues)


% Shiang Hu, Jan. 9, 2020

% check if cross spectra failes
if size(EEG,1)<2
    pro=0;
    return;
end

fmax = varargin{1};   % filtering
fmin = varargin{2};   % filtering
ssd= varargin{3};

[S, f, nss] = xspt(EEG,nw,fs,fmax,fmin);

% idxing and referencing
nf = size(S,3);
n = nss*ones(1,nf);
pmax = 10;
lmax = 50;

% CPC
[lmd,~] = CPCstepwise1(S,n,pmax,lmax);
lmd = real(lmd');               % size: freq by CPs
% psd = abs(tdiag(S));        % get the multichannel psd
% ssd = sum(psd(:));          % sum of powers (explained variance)
% ssl = sum(lmd(:));        % sum of eigenvalues

% palos index
profd = lmd(:,1)/ssd;               % frequency dependent palosi of 1st cp
% procd = sum(lmd)/ssd;               % component dependent palosi
% proch = Q./repmat(sum(Q.^2),[nc,1]);% channal weights in the CPC
pro = sum(profd);                   % total palosi
end