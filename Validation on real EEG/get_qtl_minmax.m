% get the min and the max values of the quantiles

clc;
clearvars -except x01 x02 x03 x04 x05 x06 x07 x08 x09;

qtlm = [get_quantile(x01); get_quantile(x02); get_quantile(x03);...
    get_quantile(x04); get_quantile(x05); get_quantile(x06);...
    get_quantile(x07);get_quantile(x08);get_quantile(x09)];

figure, plot([min(qtlm);max(qtlm)]','.','MarkerSize',20);

set(gca,'fontsize',12,'XTick',1:5,'xlim',[0.5,5.5],'ylim',[0,1],'XTickLabel',{'0%','25%','Medians','75%','100%'});