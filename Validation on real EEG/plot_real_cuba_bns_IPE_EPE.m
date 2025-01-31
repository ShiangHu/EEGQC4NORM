% plot data processed by plt_real_ipe_epe_cu.m and plt_real_ipe_epe_bb.m

clean;

% CHBMP study
cu_path = 'E:\CCLAB\ash - qceeg\1 Raw and processing\Cuba2004';
cu_all = load(fullfile(cu_path, 'procbm1.mat'));
cu_cln = load(fullfile(cu_path, 'procbm_cln_.mat'));

cu_snr = 0:2:30;
cu_icr = 1:56;
% cu_dat = importdata ('pro_cuba_ipe_epe no abs.mat');
cu_dat = importdata ('pro_cuba_ipe_epe abs.mat');
cu_dat (cu_dat(:,22) == 0,:) = [];  % deleting the subjects without clean windows
cu_cln = cu_cln.pro;
cu_raw = cu_all.pro(1,cu_dat(:,22) ~= 0)';
cu_dat = cu_dat(:,6:end);
cu_NSRfactor = 10.^(-cu_snr/10);
cu_sdr = round((1:56)./57*100,0);
cu_xtklb = [num2cell(cu_snr), num2cell(cu_sdr(7:3:end))];


% plot IPE and EPE break at raw clean
figure,
subplot(2,1,1)
boxplot([cu_dat(:,1:16), cu_dat(:,23:3:end)]);
set(gca,'fontsize',14,'ylim',[0 1.1],'xtick',1:33,'xticklabel',cu_xtklb);
xlabel('Preprocessing states'); ylabel('PaLOSi');
title('CU IPE & EPE');


% BNS study 
bb_path = 'E:\CCLAB\ash - qceeg\1 Raw and processing\Barbados2018\';
bb_all = load(fullfile(bb_path, 'probns1.mat'));
bb_cln = load(fullfile(bb_path, 'probns_cln_.mat'));
bb_raw = bb_all.pro(1,:)';
bb_cln = bb_cln.pro;

% bb_snr = -10:30;
bb_snr = 0:2:30;
bb_icr = 1:17;
bb_sdr = round((1:17)./18*100,0);
bb_xtklb = [num2cell(bb_snr), num2cell(bb_sdr)];

% bb_dat = importdata('pro_bns_ipe_epe no abs.mat');
bb_dat = importdata('pro_bns_ipe_epe abs.mat');

subplot(2,1,2)
% boxplot([bb_dat(:,1:41), bb_raw, bb_cln, bb_dat(:,42:end)]);
bb_dat2plt = [bb_dat(:,11:2:41), bb_dat(:,42:end)];
boxplot(bb_dat2plt);
set(gca,'fontsize',14,'ylim',[0 1.1],'xtick',1:length(bb_dat2plt),'xticklabel',bb_xtklb);
xlabel('Preprocessing states'); ylabel('PaLOSi');
title('BB IPE & EPE');