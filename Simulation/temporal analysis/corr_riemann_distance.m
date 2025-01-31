clear;clc;
dataset = 200;
max_ro = 0;
for num = 1:dataset
    %-----clean
    EEG = pop_loadset('samp.set',['E:\BCI\my_workplace\debrain_use_pvaf\data\data' num2str(num)]);
    data = eeglab2fieldtrip(EEG,'raw','none');
    cfg = [];
    cfg.method = 'corr';
    stat = ft_connectivityanalysis(cfg,data);
    clean_corr = stat.corr;
    ro = pvaf_find_regularize_p(clean_corr);
    if max_ro<ro
        max_ro = ro;
    end
    %-----noise
    for noise_t = 1:41

        EEG = pop_loadset(['noise' num2str(noise_t) '.set'],['E:\BCI\my_workplace\debrain_use_pvaf\data\data' num2str(num)]);
        data = eeglab2fieldtrip(EEG,'raw','none');
        cfg = [];
        cfg.method = 'corr';
        stat = ft_connectivityanalysis(cfg,data);
        noise_corr = stat.corr;
        ro = pvaf_find_regularize_p(noise_corr);
        if max_ro<ro
            max_ro = ro;
        end
    end

    %----debrain
    for debrain_t = 1:12
        EEG = pop_loadset(['debrain' num2str(debrain_t) '.set'],['E:\BCI\my_workplace\debrain_use_pvaf\data\data' num2str(num)]);
        data = eeglab2fieldtrip(EEG,'raw','none');
        cfg = [];
        cfg.method = 'corr';
        stat = ft_connectivityanalysis(cfg,data);
        debrain_corr = stat.corr;
        ro = pvaf_find_regularize_p(debrain_corr);
        if max_ro<ro
            max_ro = ro;
        end
        
    end
end


for num = 1:dataset
    %-----clean
    EEG = pop_loadset('samp.set',['E:\BCI\my_workplace\debrain_use_pvaf\data\data' num2str(num)]);
    data = eeglab2fieldtrip(EEG,'raw','none');
    cfg = [];
    cfg.method = 'corr';
    stat = ft_connectivityanalysis(cfg,data);
    clean_corr = stat.corr;
    cc_distance_corr(num) = pvaf_distance_riemann(clean_corr,clean_corr,max_ro);
    %-----clean

    %-----noise
    for noise_t = 1:41

        EEG = pop_loadset(['noise' num2str(noise_t) '.set'],['E:\BCI\my_workplace\debrain_use_pvaf\data\data' num2str(num)]);
        data = eeglab2fieldtrip(EEG,'raw','none');
        cfg = [];
        cfg.method = 'corr';
        stat = ft_connectivityanalysis(cfg,data);
        noise_corr = stat.corr;
        cn_distance_corr(num,noise_t) = pvaf_distance_riemann(clean_corr,noise_corr,max_ro);
    end

    %----debrain
    for debrain_t = 1:12
        EEG = pop_loadset(['debrain' num2str(debrain_t) '.set'],['E:\BCI\my_workplace\debrain_use_pvaf\data\data' num2str(num)]);
        data = eeglab2fieldtrip(EEG,'raw','none');
        cfg = [];
        cfg.method = 'corr';
        stat = ft_connectivityanalysis(cfg,data);
        debrain_corr = stat.corr;
        cd_distance_corr(num,debrain_t) = pvaf_distance_riemann(clean_corr,debrain_corr,max_ro);
    end

end
