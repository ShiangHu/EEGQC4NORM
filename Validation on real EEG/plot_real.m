% plot the figure for PaLOSi validation on the real datasets
% datasets include HBN, PMDT, LEMON, MNCS

addpath(genpath(cd));
clean;

% fig2
palosFiles = dir(fullfile('palos-contunry/*', 'palos.mat')); % load the data

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
load('all_palos/DSTR.mat');
load('all_palos/HBN.mat');
load('all_palos/MIPDB.mat');
load('all_palos/PDHC.mat');
load('all_palos/TRCS.mat');

HBN = reshape(HBN,[2951,10]);
HBN = HBN(:,1:5);
HBN = mean(HBN,2);
HBN = reshape(HBN, [size(HBN,2)*size(HBN,1),1]);
% HBN = mean(HBN(:,1:5),2);
x = [x01;x02;x03;x04;x05;x06;x07;x08;x09; HBN; PDHC; MIPDB; DSTR; TRCS];

g01 = repmat({'BB'},size(x01));
g02 = repmat({'CN'},size(x02));
g03 = repmat({'CO'},size(x03));
g04 = repmat({'CU'},size(x04));
g05 = repmat({'DE'},size(x05));
g06 = repmat({'MY'},size(x06));
g07 = repmat({'RU'},size(x07));
g08 = repmat({'CH'},size(x08));
g09 = repmat({'US'},size(x09));
g0 = repmat({'MNCS'},size(MNCS));
g1 = repmat({'HB'},size(HBN));
g2 = repmat({'PD'},size(PDHC));
g3 = repmat({'IP'},size(MIPDB));
g4 = repmat({'DS'},size(DSTR));
g5 = repmat({'TR'},size(TRCS));
g = [g01; g02; g03; g04; g05; g06; g07; g08; g09; g1; g2; g3; g4; g5];

positions = 0.25*(3:16);
figure, 
% subplot(2,1,1);
bh = boxplot(x,g,'positions', positions);
hold on
plot(0.25*(0:17),0.7*ones(18,1),'LineStyle','--');
plot(0.25*(0:17),0.3*ones(18,1),'LineStyle','--');
plot(0.25*11.5*ones(21,1),0:0.05:1,'LineStyle','--');

bhg = gca;
xlm = bhg.XLim;
xtk = bhg.XTick;
xtklb = bhg.XTickLabel;

set(bh,'LineWidth',0.5);           % 设置绘制箱体的线宽
color = [[.65,.53,.10]; [.85,.33,.10]; [.47,.67,.19]; [.93,.69,.13]; [143/255,207/255,199/255]; [255/255,191/255,122/255]];
color = [color; color; color(1:2,:)];

h = findobj(gca,'Tag','Box');
for j=1:length(h)
   patch(get(h(j),'XData'),get(h(j),'YData'),color(j,:),'FaceAlpha',.5);
   h(j,1).Color = [.15,.15,.15];
end
set(gca,'FontName','celibri','FontSize',14,'YLim',[0 1],'YTick',0:0.2:1);
ylabel('PaLOSi');       % y轴的标签     
xlabel('Datasets');    % x轴的标签


% subplot(2,1,2);
samp_count = [samp_count, length(g1), length(g2), length(g3), length(g4), length(g5)];
% bar(positions,log2(samp_count),0.35);
% set(gca,'FontName','celibri','FontSize',14,'xlim',xlm,'YLim',[0 13],'YTick',0:1:13);
% set(gca,'xtick',xtk,'xticklabel',xtklb);



a2 = copyobj(gca,gcf);
set(a2,'Ytick',[]);
set(a2,'XAxisLocation','top');
set(a2,'XTickLabel',num2cell(samp_count));
set(a2,'FontName','celibri','FontSize',14,'YLim',[0 1]);
xlabel(a2,'Counts');
ylabel(a2,[]);





% figure, 
% B = bar(1:9,bar_data);
% B.BarWidth = 0.6;
% B.FaceColor = 'flat';
% set(gca,'XTickLabel',{'BB','CN','CO','CU','DE','MY','RU','CH','US'});
% ylabel('PaLOSi');
% set(gca,'FontName','Celibri','FontSize',14);
% hold on;
% er = errorbar(1:9,bar_data,[],err_data);
% er.Color = [0.5 0.5 0.5];
% er.LineStyle = 'none';
% 
% color = [[200,228,188];     [45,129,189];     [165,119,42];     [45,162,81];     [216,121,117];
%     [98,98,98];     [116,106,175];     [246,140,62];     [251,218,45]]/255; 
% B.CData = color;
% B.EdgeAlpha = 0;
% B.FaceAlpha = 0.8;
% set(gca,'YLim',[0 1]);
