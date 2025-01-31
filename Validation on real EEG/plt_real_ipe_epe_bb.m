% modified from D:\OneDrive - CCLAB\Scripting\Toolbox\PaLOS\plot\plt_overallck.m
% use Cuba and BNS data to semi-simulate the IPE with Gaussian noise and
% EPE by removing ICs
dbstop if error
addpath(genpath(cd));
% eeglabstart;
clean;
% clean;
initpalos;
bb_path = 'E:\CCLAB\ash - qceeg\1 Raw and processing\Barbados2018';
ele = readlocs([bb_path,'\19Cuba10-20.locs'],'filetype','loc');

bb_raw = dir(fullfile(bb_path,'**','Raw.mat'));
n_sbj = length(bb_raw);
regnm = {'Raw','Clean'};

H = Har(19);
nw = 3.5;  fm = 25; fmin= 0.39; fs = 200;
mu = zeros(19,1);
sigma = eye(19);
snr_vector = -10:30;
pro = zeros(n_sbj,41+17); % 41 IPE, and 17 EPE
SDRM = zeros(51, 17);

for j=1:n_sbj

    %     for k = 1:2
    %         try
    k=2;
    EEG = pop_loadset(regnm{k},bb_raw(j).folder);
    %         catch
    %             continue;
    %         end
    %
    %         if k==1   % raw EEG for IPE
    %             % add gaussian noise

    %     R = mvnrnd(mu,sigma,size(EEG.data,2))';
    %     for p = 1:41
    %
    %         snr = snr_vector(p);
    %         mo = norm(EEG.data)/(sqrt(10^(snr/10)));
    %         EEG.ipe = EEG.data+mo*R/norm(R);
    %         pro(j, p) = qcspectra(H*EEG.ipe, nw, fs, fm, fmin);
    %
    %         %pop_saveset(EEG,['noise' num2str(snr+11)],datapath);
    %
    %         disp(['--Current State:' blanks(10) 'Sbj:' num2str(j) '/' num2str(n_sbj) ...
    %             blanks(10) 'IPE:' blanks(5) num2str(p) '/' num2str(41)])
    %     end

    %         elseif k==2 % clean EEG for EPE

    if isempty(EEG.chanlocs), EEG.chanlocs = ele; end
    EEG.data = reref(EEG.data,[]);
    EEG.ref = 'AR';
    EEG = pop_runica(EEG,'icatype','runica');

    for ic = 1:size(EEG.data,1)-1
        [~,pvaf(ic)] = compvar(EEG.data,EEG.icaact,EEG.icawinv,ic);
    end

    % EEG = iclabel(EEG);
    [sorted_pvaf,sorted_i] = sort(abs(pvaf));
    SDRM(j,:) = cumsum(sorted_pvaf(1:length(sorted_i)-1));% add SDR

    for remove_i = 1:length(sorted_i)-1
        EPE = eeg_checkset(pop_subcomp(EEG,sorted_i(1:remove_i)));
        pro(j, 41+remove_i) = qcspectra(EPE.data, nw, fs, fm, fmin);

        disp(['--Current State:'  blanks(10) 'Sbj:' num2str(j) '/' num2str(n_sbj) ...
            blanks(10) 'EPE:' blanks(5) num2str(remove_i ) '/' num2str(length(sorted_i)-1)])
    end
end

%     end

% end
figure, plot(SDRM(SDRM(:,17)<100,:)')

% save pro_bns_ipe_epe pro;