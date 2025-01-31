clear;
clc;
dataset = 200;
Fs = 250;
Fm = 50;
deltaf = 1;
for num = 1:dataset

    %-----clean
    EEG = pop_loadset('samp.set',['E:\BCI\my_workplace\debrain_use_pvaf\data\data' num2str(num)]);
    [~,F,~,clean_PSD] = pvaf_xspectrum(EEG.data,Fs,Fm,deltaf);
    clean_clean(num,:) = mean(clean_PSD-clean_PSD,1);
    clean(num).PSD = clean_PSD;
    %-----clean

    for noise_t = 1:41
        EEG = pop_loadset(['noise' num2str(noise_t) '.set'],['E:\BCI\my_workplace\debrain_use_pvaf\data\data' num2str(num)]);
        [~,F,~,noise_PSD] = pvaf_xspectrum(EEG.data,Fs,Fm,deltaf);
        noise_clean(num,noise_t,:) = mean(noise_PSD-clean_PSD,1);
        noise(num,noise_t).PSD = noise_PSD;
    end

    for debrain_t = 1:12
        EEG = pop_loadset(['debrain' num2str(debrain_t) '.set'],['E:\BCI\my_workplace\debrain_use_pvaf\data\data' num2str(num)]);
        [~,F,~,debrain_PSD] = pvaf_xspectrum(EEG.data,Fs,Fm,deltaf);
        debrain_clean(num,debrain_t,:) = mean(debrain_PSD-clean_PSD,1);
        debrain(num,debrain_t).PSD = debrain_PSD;
    end

end



