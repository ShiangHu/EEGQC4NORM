function [pro, rkr, f, ssd]= qcspectra(EEG,nw,fs,varargin)
% Quality check of cross spectra
% Input
%       EEG: data (nc-nt-ns / nc-nt)
%       nw: time-halfbandwidth product
%       fs: sampling rate
%       fmax: maximum frequency stored in varargin{1}
%       fmin: minimum frequency  stored in varargin{2}
%       loc --- chanlocs varargin{3}
%       svpath --- varargin{4}
% Output
%         pro ---- proportion
%         rkr ---- [rank of the EEG waveforms, the power spectra and
%    crossspectr at 10Hz, mean correlation interchannels powers topomaps]
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
[S, f, nss] = xspt(EEG,nw,fs,fmax,fmin);
fbd = [fmin fmax];

% idxing and referencing
nf = size(S,3);
n = nss*ones(1,nf);
pmax = 10;
lmax = 50;

% CPC
[lmd,Q] = CPCstepwise1(S,n,pmax,lmax);
lmd = real(lmd');               % size: freq by CPs
psd = abs(tdiag(S));        % get the multichannel psd
ssd = sum(psd(:));          % sum of powers (explained variance)
% ssl = sum(lmd(:));        % sum of eigenvalues

% palos index
profd = lmd(:,1)/ssd;               % frequency dependent palosi of 1st cp
procd = sum(lmd)/ssd;               % component dependent palosi
% proch = Q./repmat(sum(Q.^2),[nc,1]);% channal weights in the CPC
pro = sum(profd);                   % total palosi

% check if plot results
if nargin==7
    chanlocs = varargin{3};
    if length(chanlocs)<=21
        hr = 0.475;                        % headrad setting
    else
        hr = 0.5;
    end
    [svfd,nm]=fileparts(varargin{4});
    plt_paramap(lmd,Q,procd,fbd,pmax,svfd,nm,chanlocs,hr)
end
% close all;

% ouput other qc measures
rou = triu(corr(log10(psd)),1);
mr = sum(rou(:))./(nf*(nf-1)/2);
fid10 = (abs(f-10)==min(abs(f-10)));
rkr = [rank(EEG), rank(psd), rank(S(:, :, fid10)), mr];
end