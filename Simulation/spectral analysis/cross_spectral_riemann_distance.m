clear;clc;
dataset = 200;
Fs = 250;
Fm = 50;
deltaf = 1;
band=[1,4;5,8;9,13;14,30];
max_ro = 0;
for num = 1:dataset
    %-----clean
    EEG = pop_loadset('samp.set',['E:\BCI\my_workplace\debrain_use_pvaf\data\data' num2str(num)]);
    [Svv,F,~,~] = pvaf_xspectrum(EEG.data,Fs,Fm,deltaf);
    for band_i = 1:size(band,1)
        clean_cross = mean(Svv(:,:,F>=band(band_i,1) & F<=band(band_i,2)),3);
        ro = pvaf_find_regularize_p(real(clean_cross));
        if max_ro<ro
            max_ro = ro;
        end
    end
    %-----clean

    %-----noise
    for noise_t = 1:41
        EEG = pop_loadset(['noise' num2str(noise_t) '.set'],['E:\BCI\my_workplace\debrain_use_pvaf\data\data' num2str(num)]);
        [Svv,F,~,~] = pvaf_xspectrum(EEG.data,Fs,Fm,deltaf);
        for band_i = 1:size(band,1)
            noise_cross = mean(Svv(:,:,F>=band(band_i,1) & F<=band(band_i,2)),3);
            ro = pvaf_find_regularize_p(real(noise_cross));
            if max_ro<ro
                max_ro = ro;
            end
        end
    end

    %----debrain
    for debrain_t = 1:12
        EEG = pop_loadset(['debrain' num2str(debrain_t) '.set'],['E:\BCI\my_workplace\debrain_use_pvaf\data\data' num2str(num)]);
        [Svv,F,~,~] = pvaf_xspectrum(EEG.data,Fs,Fm,deltaf);
        for band_i = 1:size(band,1)
            debrain_cross = mean(Svv(:,:,F>=band(band_i,1) & F<=band(band_i,2)),3);
            ro = pvaf_find_regularize_p(real(debrain_cross));
            if max_ro<ro
                max_ro = ro;
            end
        end
    end
end

for num = 1:dataset
    %-----clean
    EEG = pop_loadset('samp.set',['E:\BCI\my_workplace\debrain_use_pvaf\data\data' num2str(num)]);
    [Svv,F,~,~] = pvaf_xspectrum(EEG.data,Fs,Fm,deltaf);
    for band_i = 1:size(band,1)
        clean_cross = mean(Svv(:,:,F>=band(band_i,1) & F<=band(band_i,2)),3);
        cc_distance_rm(num,band_i) = pvaf_distance_riemann(real(clean_cross),real(clean_cross),max_ro);
    end
    %-----clean

    %-----noise
    for noise_t = 1:41
        EEG = pop_loadset(['noise' num2str(noise_t) '.set'],['E:\BCI\my_workplace\debrain_use_pvaf\data\data' num2str(num)]);
        [Svv,F,~,~] = pvaf_xspectrum(EEG.data,Fs,Fm,deltaf);
        for band_i = 1:size(band,1)
            noise_cross = mean(Svv(:,:,F>=band(band_i,1) & F<=band(band_i,2)),3);
            cn_distance_rm(num,noise_t,band_i) = pvaf_distance_riemann(real(clean_cross),real(noise_cross),max_ro);
        end
    end

    %----debrain
    for debrain_t = 1:12
        EEG = pop_loadset(['debrain' num2str(debrain_t) '.set'],['E:\BCI\my_workplace\debrain_use_pvaf\data\data' num2str(num)]);
        [Svv,F,~,~] = pvaf_xspectrum(EEG.data,Fs,Fm,deltaf);
        for band_i = 1:size(band,1)
            debrain_cross = mean(Svv(:,:,F>=band(band_i,1) & F<=band(band_i,2)),3);
            cd_distance_rm(num,debrain_t,band_i) = pvaf_distance_riemann(real(clean_cross),real(debrain_cross),max_ro);
        end
    end

end
