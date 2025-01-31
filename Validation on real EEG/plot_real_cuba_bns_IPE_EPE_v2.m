% plot data processed by plt_real_ipe_epe_cu.m and plt_real_ipe_epe_bb.m

clean;

% CHBMP study
cu_path = 'E:\CCLAB\ash - qceeg\1 Raw and processing\Cuba2004';
cu_all = load(fullfile(cu_path, 'procbm1.mat'));
cu_cln = load(fullfile(cu_path, 'procbm_cln_.mat'));

cu_snr = -10:2:30;
cu_icr = 1:56;
% cu_dat = importdata ('pro_cuba_ipe_epe no abs.mat');
cu_dat = importdata ('pro_cuba_ipe_epe abs.mat');
cu_dat (cu_dat(:,22) == 0,:) = [];  % deleting the subjects without clean windows
cu_cln = cu_cln.pro;
cu_raw = cu_all.pro(1,cu_dat(:,22) ~= 0)';
cu_NSRfactor = 10.^(-cu_snr/10);
cu_sdr = round((1:56)./57*100,0);

% IPE in columns 1-21, EPE in columns 22-56

snr_show = [0,2,4,8,16,32];
sdr_show = [11,22,44,60,82,95];

[~,cu_snr_plt_id] = ismember([0,2,4,8,16,30],cu_snr);
[~,cu_sdr_plt_id] = ismember([12,23,44,60,81,96],cu_sdr);

cu_xtklb = [num2cell(snr_show), {'Raw'}, num2cell(sdr_show)];


% plot IPE and EPE break at raw clean
figure,
subplot(1,2,1)
boxplot([cu_dat(:,cu_snr_plt_id), cu_raw, cu_dat(:,21+ cu_sdr_plt_id)]);
set(gca,'fontsize',14,'ylim',[0 1.05],'xtick',1:length(cu_xtklb),'xticklabel',cu_xtklb);
xlabel('Preprocessing states'); ylabel('PaLOSi');
title('CU IPE & EPE'); axis square


% BNS study 
bb_path = 'E:\CCLAB\ash - qceeg\1 Raw and processing\Barbados2018\';
bb_all = load(fullfile(bb_path, 'probns1.mat'));
bb_cln = load(fullfile(bb_path, 'probns_cln_.mat'));
bb_raw = bb_all.pro(1,:)';
bb_cln = bb_cln.pro;

% bb_snr = -10:30;
bb_snr = -10:30;
bb_icr = 1:17;
bb_sdr = round((1:17)./18*100,0);

% IPE in columns 1-21, EPE in columns 22-56
[~,bb_snr_plt_id] = ismember([0,2,4,8,16,30],bb_snr);
[~,bb_sdr_plt_id] = ismember([11,22,44,61,83,94],bb_sdr);

bb_xtklb = [num2cell(snr_show), {'Raw'}, num2cell(sdr_show)];

% bb_dat = importdata('pro_bns_ipe_epe no abs.mat');
bb_dat = importdata('pro_bns_ipe_epe abs.mat');

subplot(1,2,2)
boxplot([bb_dat(:,bb_snr_plt_id), bb_raw, bb_dat(:,41+bb_sdr_plt_id)]);
set(gca,'fontsize',14,'ylim',[0 1.05],'xtick',1:length(bb_xtklb),'xticklabel',bb_xtklb);
xlabel('Preprocessing states'); ylabel('PaLOSi');
title('BB IPE & EPE'); axis square