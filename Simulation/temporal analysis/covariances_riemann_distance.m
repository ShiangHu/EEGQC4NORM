clear;clc;
dataset = 200;
max_ro = 0;
for num = 1:dataset
    %-----clean
    EEG = pop_loadset('samp.set',['E:\BCI\my_workplace\debrain_use_pvaf\data\data' num2str(num)]);
    clean_cov = covariances(EEG.data);
    ro = pvaf_find_regularize_p(clean_cov);
    if max_ro<ro
        max_ro = ro;
    end
    %-----noise
    for noise_t = 1:41

        EEG = pop_loadset(['noise' num2str(noise_t) '.set'],['E:\BCI\my_workplace\debrain_use_pvaf\data\data' num2str(num)]);
        noise_cov = covariances(EEG.data);
        ro = pvaf_find_regularize_p(noise_cov);
        if max_ro<ro
            max_ro = ro;
        end
    end
    %----debrain
    for debrain_t = 1:12
        EEG = pop_loadset(['debrain' num2str(debrain_t) '.set'],['E:\BCI\my_workplace\debrain_use_pvaf\data\data' num2str(num)]);
        debrain_cov = covariances(EEG.data);
        ro = pvaf_find_regularize_p(debrain_cov);
        if max_ro<ro
            max_ro = ro;
        end
        
    end
end


for num = 1:dataset
    %-----clean
    EEG = pop_loadset('samp.set',['E:\BCI\my_workplace\debrain_use_pvaf\data\data' num2str(num)]);
    clean_cov = covariances(EEG.data);
    cc_distance_cov(num) = pvaf_distance_riemann(clean_cov,clean_cov,max_ro);
    %-----clean

    %-----noise
    for noise_t = 1:41

        EEG = pop_loadset(['noise' num2str(noise_t) '.set'],['E:\BCI\my_workplace\debrain_use_pvaf\data\data' num2str(num)]);
        noise_cov = covariances(EEG.data);
        cn_distance_cov(num,noise_t) = pvaf_distance_riemann(clean_cov,noise_cov,max_ro);
    end

    %----debrain
    for debrain_t = 1:12
        EEG = pop_loadset(['debrain' num2str(debrain_t) '.set'],['E:\BCI\my_workplace\debrain_use_pvaf\data\data' num2str(num)]);
        debrain_cov = covariances(EEG.data);
        cd_distance_cov(num,debrain_t) = pvaf_distance_riemann(clean_cov,debrain_cov,max_ro);
    end

end




