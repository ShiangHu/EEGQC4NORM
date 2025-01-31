% plot the palosi of 9 countries from MNCS datasets

EEGdir = 'palos-contunry\*';
palosFiles = dir(fullfile(EEGdir, 'palos.mat')); % load the data

for i = 1:length(palosFiles)
    load([palosFiles(i).folder '\' palosFiles(i).name]);
    bar_data(i) = mean(palosi);
    err_data(i) = std(palosi);
end
B = bar(1:9,bar_data);
B.BarWidth = 0.6;
B.FaceColor = 'flat';
set(gca,'XTickLabel',{'Barbados','China','Colombia','Cuba','Germany','Malaysia','Russia','Switzerland','USA'});
ylabel('PaLOSi');
set(gca,'FontName','Celibri','FontSize',14);
hold on;
er = errorbar(1:9,bar_data,[],err_data);
er.Color = [0.5 0.5 0.5];
er.LineStyle = 'none';

color = [[200,228,188];
    [45,129,189];
    [165,119,42];
    [45,162,81];
    [216,121,117];
    [98,98,98];
    [116,106,175];
    [246,140,62];
    [251,218,45]]/255;
B.CData = color;
B.EdgeAlpha = 0;
B.FaceAlpha = 0.8;
set(gca,'YLim',[0 1]);