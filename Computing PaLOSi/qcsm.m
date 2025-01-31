function [qcs, mnm] = qcsm(EEG,varargin)
% Calculate the QC spectral metrics for large scale EEG processing
% The new metrics include:
%       1. qc_rd: channel rank deficency of the multichannel EEG
%       2. qc_pvaf_nbic: percentage of scalp data the non-brain IC variance accounted for
%       3. qc_pnbic: percentage of non-brain ICs among all the ICs
%       4. qc_clt: extent of collinear test of the spectral curves
%       5. qc_rou: similarity of the spectral topographies across frequencies
%       6. PaLoSi.

% Input
%           EEG --- EEGLAB structure and done with ICA

% Andy Mar. 2022

plotflag = false;
if nargin == 2, plotflag = true; end

EEG = eeg_checkset(EEG);

% multitaper cs estimate   
nw = 3; 
fs = EEG.srate;
fmax = 30;
fmin = 0;

[cs, fbins] = xspt(EEG.data,nw,fs,fmax,fmin);

qc_palos = qcspectra(EEG.data,nw,fs,fmax,fmin);

% similarity of power spectral topographies
ps = tdiag(cs);
rou = corr(ps);
rouh = vect_tria(rou);
qc_dps = sum(rouh>=0.9)/length(rouh);

% similarity of coherence matrices
coh = cs2coh(cs);
% rk_coh = trank(coh); used for riemannian distance

dist_c = pdist(vect_tria(coh)','cosine');
qc_dcoh = sum(dist_c<0.15)/length(dist_c);

% ICLABEL
EEG = iclabel(EEG);
[~,~,~,pvaf_bic,pbic] = sort_ic(EEG);
qc_pnbic = 1 - pbic;
qc_pvaf_nbic = 1 - pvaf_bic;

% EEG rank deficency
qc_rd = 1 - rank(EEG.data)/size(EEG.data,1);

% collinear test
% ps_r = ps ./ repmat(sum(ps,2),[1,size(ps,2)]);         % relative power
ps_log = log10(ps);
% ps_log = ps_log - log10(repmat(sum(ps,2),[1,size(ps,2)]));         % relative power
ps_dem = ps_log - repmat(median(ps_log),[size(ps_log,1), 1]); % de-median across channels

ps_std = var(ps_dem,[],2);
qc_clt = 1 - mean(ps_std)./mean(abs(ps_dem(:)));

% output qcs
qcs = [qc_palos; qc_dps; qc_dcoh; qc_rd; qc_pvaf_nbic; qc_pnbic; qc_clt];
mnm = {'palos', 'similarity_power', 'similarity_coh', 'rank deficency', 'pvaf_nbic', 'pn_nbic', 'colinear test'};

%% plot figures
if plotflag 
    
 % multichannel power by EEGLAB
psdnm= 'psd by EEGLAB (pwelch)'; 
figure('name',psdnm),
spectopo(EEG.data,0,500,'percent',15,'freq',2:2:20,'title',psdnm,'chanlocs',EEG.chanlocs);

% multichannel power by multitaper
figure('name','multichannel power by multitaper'), 
subplot(121), plot(fbins,ps), title('Natural Power'); subplot(122), semilogy(fbins,ps), title('Log Power');

% pearson correlation of ps
figure('name','qc_dps'),
subplot(121), histogram(rouh,2,'normalization','probability'); xlabel('qc\_dps: spectral similarity'); ylabel('Probability');
subplot(122),imagesc(rou); caxis([0 1]); colorbar; axis square; 
xlabel('Freq'), ylabel('Freq'), title('similarity of power spectral topos'), 

% similarity of coherence matrices 
figure('name','qc_dcoh'), histogram(dist_c,3, 'normalization','probability'); 
xlabel('qc\_dcoh: coherence similarity'); ylabel('Probability');

% dist to median across channels
figure('name','collinear dist'), plot(fbins, ps_dem);
xlabel('Freqs'), title('dist to median across channels'), 

set(findall(findall(0,'Type','Figure'),'-property','FontSize'),'FontSize',12);
end

end