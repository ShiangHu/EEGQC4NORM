% plot the real data for illustration in fig1

clean;
% eeglabstart('');
lw = 2;
timerange = 1:200;

load colormap13.mat;

SEED_realdata_path = 'D:\OneDrive - CCLAB\Scripting\Toolbox\0-connectivity\SEED-G-toolbox\real data';
iEEGdata = 'D:\OneDrive\2_Projects\7 XiPi\6. 论文交接\1. 计算脚本和代码\XiPeaks-study\Figure\SharedData\IEEG1772_data.mat';

% sources
sos_sedg = load(fullfile(SEED_realdata_path,"EEG_real_sources.mat"));
sos_sedg = sos_sedg.EEG;

sos_sLOR_sedg = load(fullfile(SEED_realdata_path,"sLOR_cortical_sources.mat"));
sos_sLOR_sedg = reshape(sos_sLOR_sedg.EEG.samp,[125,65*130]);

sos_ieeg = load(iEEGdata);
sos_ieeg = sos_ieeg.Data_W;

%% source
figure,
subplot(2,2,1)
% data1 = sos_ieeg(12,1000+timerange);
% data2 = sos_ieeg(12,2000+timerange);
load sos_simulated.mat;
J(J(:,1)==0,:) = [];
data1 = J(12, timerange);
data2 = J(13, timerange);

plot(data1,'color','#77AC30','LineWidth',lw);
hold on;
plot(data2+10,'color','#77AC30','LineWidth',lw);
title('source activity');
ylim([-10, 20]);

%% CE
CE = pop_loadset('DataGenerated\samp.set');
subplot(2,2,2), 
plot(CE.data(12,timerange)','color',[100,100,100]/255,'LineWidth',lw);
hold on
plot(CE.data(13,timerange)'+1,'color',[100,100,100]/255,'LineWidth',lw);
title('CE');
ylim([-1, 2]);

%% IPE
IPE = pop_loadset('DataGenerated\debrain13.set');

subplot(2,2,3),
plot(IPE.data(12,timerange),'color','#A2142F','LineWidth',lw);
hold on;
plot(IPE.data(12,500+timerange)+0.4,'color','#A2142F','LineWidth',lw);
title('IPE');
ylim([-0.3, 0.8]);

%% EPE
EPE = pop_loadset('DataGenerated\noise1.set');

subplot(2,2,4),
plot(EPE.data(12,timerange),'color','#0072BD','LineWidth',lw);
hold on;
plot(EPE.data(13,timerange)+8,'color','#0072BD','LineWidth',lw);
title('EPE');
ylim([-10, 20]);