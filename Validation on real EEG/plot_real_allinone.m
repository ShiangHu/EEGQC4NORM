% plot the figure for PaLOSi validation on the real datasets
% datasets include HBN, PMDT, LEMON, MNCS

addpath(genpath('../'));
clean;

fs = 12; % fontsize
afs = 12;
ub = 0.6;
lb = 0.3;
bw = 0.5; % box widths
bw1 = 0.4;
fa=0.6; % transprancy
fa1 = 0.9; % IPE EPE
ytk = [0, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 1];
% color for fig1, 4, 5
% color = [.65,.53,.10; .85,.33,.10; .47,.67,.19; .93,.69,.13; .56, .81, .78; ...
%     1, 0.74, 0.47; .06,.61,.83; .08, .35, .50; .62, .17, 0.58];
color = importdata('country_color.mat');
color1 = color(1:7,:);
n_color = size(color,1);
n_color1 = size(color1,1);
% color for fig IPE EPE
colormap = importdata('colormap13.mat');

%% set 6 figures in A4 paper
% A4 paper dimensions in pixels (approximate for 100 DPI)
A4_width = 827;   % Width in pixels
A4_height = 1169; % Height in pixels

% Define the number of figures and their layout
numFigures = 6;
fig_w = A4_width / 2;  % Width for each figure
fig_h = A4_height / 4; % Height for each figure

% Define positions for each figure in a 2x3 grid
fig_pos = [
    0, 0;                  % Figure 1 position
    fig_w, 0;
    0, fig_h;       % Figure 2 position
    fig_w, fig_h;
    0, 2*fig_h; 
    fig_w, 2*fig_h;
    ];
fig_pos = fig_pos + 60;


%% plot normative EEG palosi
palosFiles = dir(fullfile('../palos-contunry/*', 'palos.mat')); % load the data

MNCS = [];
samp_count = [];

for i = 1:length(palosFiles)
    load([palosFiles(i).folder '\' palosFiles(i).name]);
    MNCS = [MNCS, palosi];
    samp_count = [samp_count, length(palosi)];
    bar_data(i) = mean(palosi);
    err_data(i) = std(palosi);
end

MNCS=MNCS';

x01 =  importdata([palosFiles(1).folder '\' palosFiles(i).name])'; % BB
x02 =  importdata([palosFiles(2).folder '\' palosFiles(i).name])'; % CN
x03 =  importdata([palosFiles(3).folder '\' palosFiles(i).name])'; % CO
x04 =  importdata([palosFiles(4).folder '\' palosFiles(i).name])'; % CU
x05 =  importdata([palosFiles(5).folder '\' palosFiles(i).name])'; % DE
x06 =  importdata([palosFiles(6).folder '\' palosFiles(i).name])'; % MY
x07 =  importdata([palosFiles(7).folder '\' palosFiles(i).name])'; % RU
x08 =  importdata([palosFiles(8).folder '\' palosFiles(i).name])'; % CH
x09 =  importdata([palosFiles(9).folder '\' palosFiles(i).name])'; % US

% figure1
load('all_palos/HBN.mat');

HBN = reshape(HBN,[2951,10]);
HBN = HBN(:,1:5);
HBN = mean(HBN,2);
HBN = reshape(HBN, [size(HBN,2)*size(HBN,1),1]);

x = [x01;x02;x03;x04;x05;x06;x07;x08;x09; ];

g01 = repmat({'BB'},size(x01)); g02 = repmat({'CN'},size(x02));
g03 = repmat({'CO'},size(x03)); g04 = repmat({'CU'},size(x04));
g05 = repmat({'DE'},size(x05)); g06 = repmat({'MY'},size(x06));
g07 = repmat({'RU'},size(x07)); g08 = repmat({'CH'},size(x08));
g09 = repmat({'US'},size(x09)); g0 = repmat({'MNCS'},size(MNCS));
% g1 = repmat({'HB'},size(HBN));
g = [g01; g02; g03; g04; g05; g06; g07; g08; g09;];

figure,
boxplot(x,g, 'Widths', 0.5);
hold on
plot((0:length(unique(g))+1),ub*ones(length(unique(g))+2,1),'LineStyle','--');
plot((0:length(unique(g))+1),lb*ones(length(unique(g))+2,1),'LineStyle','--');

bhg = gca;
xlm = bhg.XLim;
xtk = bhg.XTick;
xtklb = bhg.XTickLabel;

h = findobj(gca,'Tag','Box');
for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),color(n_color - j+1,:),'FaceAlpha',fa);
    %     h(j,1).Color = [.15,.15,.15];
end
set(gca,'LineWidth',0.2,'FontSize',fs,'YLim',[0 1],'YTick',ytk);
ylabel('PaLOSi');   xlabel('Datasets');  title('Normative EEG');
set(gcf,'position',[fig_pos(5,1),fig_pos(5,2),fig_w,fig_h]);
print('real1.pdf', '-dpdf');
% plot sample counts
figure,
bh = bar(1:9,samp_count,0.45);
% ,'FontName','celibri'
set(gca,'FontSize',fs,'xtick',1:9,'xticklabel',xtklb,'ylim',[1 450],'YGrid','on','XLim',[0.5, 9.5]);
bh.FaceColor = 'flat';
bh.FaceAlpha = fa;
bh.CData = color;
xlabel('Countries'); ylabel('Counts'); title('Sample quantities');
set(gcf,'position',[fig_pos(6,1),fig_pos(6,2),fig_w,fig_h]);
print('real2.pdf', '-dpdf');
%% plot real_IPE_EPE

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
% sdr_show = [11,22,44,60,82,95]; % actual
sdr_show = [10,20,40,60,80,95]; % fixed

[~,cu_snr_plt_id] = ismember([0,2,4,8,16,30],cu_snr);
[~,cu_sdr_plt_id] = ismember([12,23,44,60,81,96],cu_sdr);

cu_xtklb = [num2cell(snr_show), {'RW'}, num2cell(sdr_show)];
cu_xtklb(1) = {'dB/0'};
cu_xtklb(end) = {'%/95'};

% plot IPE and EPE break at raw clean
figure,
% subplot(3,2,3)
boxplot([cu_dat(:,cu_snr_plt_id), cu_raw, cu_dat(:,21+ cu_sdr_plt_id)], 'Widths', bw);
hold on
plot(0:length(cu_xtklb)+1,ub*ones(length(cu_xtklb)+2,1),'LineStyle','--','linewidth',1);
plot(0:length(cu_xtklb)+1,lb*ones(length(cu_xtklb)+2,1),'LineStyle','--','linewidth',1);

h = findobj(gca,'Tag','Box');
for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),colormap(14-j,:),'FaceAlpha',fa1);
    h(j,1).Color = [0.15,0.15,0.15];
end

set(gca,'fontsize',fs,'ylim',[0 1.05],'xtick',1:length(cu_xtklb),'xticklabel',cu_xtklb,'YTick',ytk);
ax = gca;
ax.XAxis.FontSize = afs; 
xlabel('Preprocessing states'); ylabel('PaLOSi');
title('CHBMP IPE EPE');
set(gcf,'position',[fig_pos(3,1),fig_pos(3,2),fig_w,fig_h]);
% axis square
print('real3.pdf', '-dpdf');

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

bb_xtklb = [num2cell(snr_show), {'RW'}, num2cell(sdr_show)];
bb_xtklb(1) = {'dB/0'};
bb_xtklb(end) = {'%/95'};

% bb_dat = importdata('pro_bns_ipe_epe no abs.mat');
bb_dat = importdata('pro_bns_ipe_epe abs.mat');

figure
% subplot(3,2,4)
boxplot([bb_dat(:,bb_snr_plt_id), bb_raw, bb_dat(:,41+bb_sdr_plt_id)], 'Widths', bw);
hold on
plot(0:length(bb_xtklb)+1,ub*ones(length(bb_xtklb)+2,1),'LineStyle','--','linewidth',1);
plot(0:length(bb_xtklb)+1,lb*ones(length(bb_xtklb)+2,1),'LineStyle','--','linewidth',1);
h = findobj(gca,'Tag','Box');
for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),colormap(14-j,:),'FaceAlpha',fa1);
    h(j,1).Color = [.15,.15,.15];
end
set(gca,'fontsize',fs,'ylim',[0 1.05],'xtick',1:length(bb_xtklb),'xticklabel',bb_xtklb,'YTick',ytk);
ax = gca;
ax.XAxis.FontSize = afs; 
xlabel('Preprocessing states'); ylabel('PaLOSi');
title('BBHC18 IPE EPE');
set(gcf,'position',[fig_pos(4,1),fig_pos(4,2),fig_w,fig_h]);
% axis square
print('real4.pdf', '-dpdf');

%% ploy ATMG
cu_path = 'E:\CCLAB\ash - qceeg\1 Raw and processing\Cuba2004';
cu_all = load(fullfile(cu_path, 'procbm1.mat'));
cu_cln = load(fullfile(cu_path, 'procbm_cln_.mat'));

bb_path = 'E:\CCLAB\ash - qceeg\1 Raw and processing\Barbados2018\';
bb_all = load(fullfile(bb_path, 'probns1.mat'));
bb_cln = load(fullfile(bb_path, 'probns_cln_.mat'));

figure,
% subplot(3,2,5)
cu_pro = cu_all.pro';
cu_pro = [cu_pro(:,1:3), [cu_cln.pro; nan(24,1) ], cu_pro(:,4:6)];

n_cu = size(cu_all.pro,2);
cu_sts = repmat({'RW','CRD','FLT','CW','ICL','HV','ITP'},[n_cu,1]);

boxplot(cu_pro(:),cu_sts(:), 'Widths', bw1);
hold on
plot(0:size(cu_sts,2)+1,ub*ones(size(cu_sts,2)+2,1),'LineStyle','--','linewidth',1);
plot(0:size(cu_sts,2)+1,lb*ones(size(cu_sts,2)+2,1),'LineStyle','--','linewidth',1);

h = findobj(gca,'Tag','Box');
for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),color1(n_color1 - j+1,:),'FaceAlpha',fa);
    h(j,1).Color = [.15,.15,.15];
end
set(gca,'LineWidth',0.2, 'FontSize',fs,'YLim',[0 1],'YTick',ytk);
ylabel('PaLOSi'); xlabel('Automagic stages'); title('CHBMP EEG');
set(gcf,'position',[fig_pos(1,1),fig_pos(1,2),fig_w,fig_h]);
print('real5.pdf', '-dpdf');

figure,
% subplot(3,2,6)
bb_pro = bb_all.pro';
bb_dat = [bb_pro(:,1:3), bb_cln.pro,bb_pro(:,4:6)];
n_bb = size(bb_dat,1);

bb_sts = repmat({'RW','CRD','FLT','CW','ICL','HV','ITP'},[n_bb,1]);

boxplot(bb_dat(:),bb_sts(:), 'Widths', bw1);
hold on
plot(0:size(bb_sts,2)+1,ub*ones(size(bb_sts,2)+2,1),'LineStyle','--','linewidth',1);
plot(0:size(bb_sts,2)+1,lb*ones(size(bb_sts,2)+2,1),'LineStyle','--','linewidth',1);

h = findobj(gca,'Tag','Box');
for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),color1(n_color1 - j+1,:),'FaceAlpha',fa);
    h(j,1).Color = [.15,.15,.15];
end
set(gca,'LineWidth',0.2,'FontSize',fs,'YLim',[0 1],'YTick',ytk);
ylabel('PaLOSi');  xlabel('Automagic stages');  title('BBHC18 EEG');
set(gcf,'position',[fig_pos(2,1),fig_pos(2,2),fig_w,fig_h]);
print('real6.pdf', '-dpdf');