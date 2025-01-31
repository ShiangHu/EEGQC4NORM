function [pro, sbjnm, spectra,freqs,speccomp,contrib,specstd] = ck_palos(eegpath,varargin)
% check the presence of palos issue
% Input
%      eegpath -- where the eeglab struct or automagic results are
%      varargin{1} -- [integer] specify the srate
%      varargin{2} -- [indices vector] use for partial check
% Output
%      pro --- palos index
%      sbjnm --- sbjnm of checked files
%      eegpath_ckpls: parmaps of CPCs, EEGwave, spectopos

% See also plt_paramap, qcspectra  
% S. Hu, Aug20/2021


initpalos;
fs = 500;
if nargin>=2&&~isempty(varargin{1}), fs = varargin{1}; end

% create save fd
svfd = [eegpath,'_ckpls'];crtfd(svfd);

% EEG data at certain step
eegset = dir(fullfile(eegpath,'**','all*.mat'));   % check automagic result
if isempty(eegset), eegset = dir(fullfile(eegpath,'*.mat')); end % check eeglab structure

% partial check
sbjset = 1:length(eegset);
if nargin>2, sbjset = varargin{2}; end
nsbj = length(sbjset);

% qcspectra para
nw = 3; fmax = 30; fmin=0.99;
pro = zeros(length(sbjset),1);
sbjnm = cell(nsbj,1);

for i=1:length(sbjset)
    % load EEG
    disp(['>>>>-------------------processing sbj:',blanks(10),num2str(i),'/',num2str(length(sbjset))]);
    
    j = sbjset(i);                       % check automagic result
    if strcmp(eegset(1).name(1:3),'all')
        load(fullfile(eegset(j).folder,eegset(j).name),'EEGFinal'); EEG = EEGFinal;
    else                                 % check eeglab structure
        load(fullfile(eegset(j).folder,eegset(j).name),'EEG'); 
    end

    nmn = eegset(j).name(1:end-4);
    disp(['Sbjname:',blanks(5),nmn]);
    sbjnm{i} = nmn;
    
    % skip ref and bad channel/data
    idx = EEG.data(:,1)~=0&~isnan(EEG.data(:,1));
    data = EEG.data(idx,:); 
    chanlocs = EEG.chanlocs(idx);
    if size(data,1)<2, disp(['Skip:',blanks(5),eegset(j).name]); continue; end    % remove Sta_Alex_Test1_run02
    if ~isempty(EEG.srate)&&fs~=EEG.srate, fs=EEG.srate; end        % fix srate
    
    % calculate palos
    pro(i) = qcspectra(data,nw,fs,fmax,fmin,chanlocs,[svfd,filesep,nmn]);
    
    % check EEG
    eegplot_w(data,'title',nmn);
    a=gcf; a.Position= [0    0.0444    1.0000    0.9148];
    saveas(gcf,[svfd,'/wv_',nmn],'fig'); close;
    
    % check spectra topos
    f=figure('name',nmn);
    f.Position = [100   100   800   650];
    [spectra,freqs,speccomp,contrib,specstd]=spectopo(data,0,fs,'percent',100,...
        'winsize',2.56*fs,'nfft',fs,'overlap',1.28*fs,'freqrange',[0.25 30.5],'freq',2:2:20,...
        'style','map','chanlocs',chanlocs,'electrodes','off','plotrad',0.6); % 'plotchans',1:19, 'plotrad', 'headrad', 'intrad'
    
    saveas(gcf,[svfd,'/spt_',nmn],'svg'); close;
end
save([svfd,filesep,'z_pro'],'pro','sbjnm');
end