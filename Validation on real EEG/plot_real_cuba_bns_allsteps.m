

clean;

cu_path = 'E:\CCLAB\ash - qceeg\1 Raw and processing\Cuba2004';
cu_all = load(fullfile(cu_path, 'procbm1.mat'));
cu_cln = load(fullfile(cu_path, 'procbm_cln_.mat'));

bb_path = 'E:\CCLAB\ash - qceeg\1 Raw and processing\Barbados2018\';
bb_all = load(fullfile(bb_path, 'probns1.mat'));
bb_cln = load(fullfile(bb_path, 'probns_cln_.mat'));


figure,
subplot(1,2,1)
cu_pro = cu_all.pro';
cu_pro = [cu_pro(:,1:3), [cu_cln.pro; nan(24,1) ], cu_pro(:,4:6)];

n_cu = size(cu_all.pro,2);
cu_sts = repmat({'RAW','CRD','FLT','CW','ICL','HV','ITP'},[n_cu,1]);

boxplot(cu_pro(:),cu_sts(:));
axis square;
title('CHBMP EEG');

set(gca,'LineWidth',0.5);           % 设置绘制箱体的线宽
color = [[.65,.53,.10]; [.85,.33,.10]; [.47,.67,.19]; [.93,.69,.13]; [143/255,207/255,199/255]; [255/255,191/255,122/255]];
color = [color; color; color(1:2,:)];
h = findobj(gca,'Tag','Box');
for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),color(j,:),'FaceAlpha',.5);
    h(j,1).Color = [.15,.15,.15];
end
set(gca,'FontName','celibri','FontSize',14,'YLim',[0 1],'YTick',0:0.2:1);
ylabel('PaLOSi');       % y轴的标签
xlabel('Preprocessing States');    % x轴的标签


subplot(1,2,2)
bb_pro = bb_all.pro';
bb_dat = [bb_pro(:,1:3), bb_cln.pro,bb_pro(:,4:6)];
n_bb = size(bb_dat,1);

bb_sts = repmat({'RAW','CRD','FLT','CW','ICL','HV','ITP'},[n_bb,1]);

boxplot(bb_dat(:),bb_sts(:));
axis square;
title('BBHC18');

set(gca,'LineWidth',0.5);           % 设置绘制箱体的线宽
color = [[.65,.53,.10]; [.85,.33,.10]; [.47,.67,.19]; [.93,.69,.13]; [143/255,207/255,199/255]; [255/255,191/255,122/255]];
color = [color; color; color(1:2,:)];
h = findobj(gca,'Tag','Box');
for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),color(j,:),'FaceAlpha',.5);
    h(j,1).Color = [.15,.15,.15];
end
set(gca,'FontName','celibri','FontSize',14,'YLim',[0 1],'YTick',0:0.2:1);
ylabel('PaLOSi');       % y轴的标签
xlabel('Preprocessing States');    % x轴的标签


