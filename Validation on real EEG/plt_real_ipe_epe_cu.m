% modified from D:\OneDrive - CCLAB\Scripting\Toolbox\PaLOS\plot\plt_overallck.m
% use Cuba and BNS data to semi-simulate the IPE with Gaussian noise and
% EPE by removing ICs
dbstop if error
addpath(genpath(cd));
eeglabstart;
% clean;
% clean;
initpalos;
bb_path = 'E:\CCLAB\ash - qceeg\1 Raw and processing\Cuba2004';
ele = readlocs([bb_path,'\58.xyz'],'filetype','xyz');

bb_raw = dir(fullfile(bb_path,'**','Raw.mat'));
n_sbj = length(bb_raw);
regnm = {'Raw','Clean'};

nw = 3.5;  fm = 25; fmin= 0.39; fs = 200;
snr_vector = -10:2:30;
pro = zeros(n_sbj,length(snr_vector)+56); % 41 IPE, and 17 EPE
SDRM = zeros(223, 57);

for j=219:n_sbj

    %     for k = 1:2
    k=2;
    try
        EEG = pop_loadset(regnm{k},bb_raw(j).folder);
        nc = EEG.nbchan;
    catch
        continue;
    end

    %         if k==1   % raw EEG for IPE
    %
    %             % add gaussian noise
    %             H = Har(nc);
    %             mu = zeros(nc,1);
    %             sigma = eye(nc);
    %
    %             R = mvnrnd(mu,sigma,size(EEG.data,2))';
    %             for p = 1:length(snr_vector)
    %                 snr = snr_vector(p);
    %                 mo = norm(EEG.data)/(sqrt(10^(snr/10)));
    %                 EEG.ipe = EEG.data+mo*R/norm(R);
    %                 pro(j, p) = qcspectra(H*EEG.ipe, nw, fs, fm, fmin);
    %
    %                 %pop_saveset(EEG,['noise' num2str(snr+11)],datapath);
    %
    %                 disp(['--Current State:' blanks(10) 'Sbj:' num2str(j) '/' num2str(n_sbj) ...
    %                     blanks(10) 'IPE:' blanks(5) num2str(p) '/' num2str(41)])
    %             end
    %
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
    SDRM(j,:) = cumsum(sorted_pvaf);% add SDR

    for remove_i = 1:length(sorted_i)-1
        EPE = eeg_checkset(pop_subcomp(EEG,sorted_i(1:remove_i)));

        if remove_i>56, continue; end
        pro(j, length(snr_vector)+remove_i) = qcspectra(EPE.data, nw, fs, fm, fmin);

        disp(['--Current State:'  blanks(10) 'Sbj:' num2str(j) '/' num2str(n_sbj) ...
            blanks(10) 'EPE:' blanks(5) num2str(remove_i ) '/' num2str(length(sorted_i)-1)])
    end

    %         end

end

% end

save pro_cuba_ipe_epe pro SDRM;