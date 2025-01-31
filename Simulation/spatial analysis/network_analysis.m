%%------------------------------
%coh,dtf,pdc,plv,psi,gc,icoh
%%------------------------------


clear;clc;
addpath 'E:\BCI\fieldtrip-master\connectivity'
disp('---------------------> there is rois = 15 <--------------------')
dataset = 200;
% method = {'coh','dtf','granger','pdc','plv','psi'};
method = {'plv'};
for method_i = 1:length(method)
    for num = 1:dataset
        disp(['--------->dataset:' num2str(num) '<------------']);
        clean_datapath = ['E:\BCI\my_workplace\debrain_use_pvaf\data\data' num2str(num) '\samp.set'];
        mfreq = calculate_freq_mvar(clean_datapath);
        clean_matrix = mvar_method_wu(method{method_i},mfreq);
        [clean.global_efficiency(num),clean.mean_local_efficiency(num),clean.transitity(num),clean.mean_clustering_coef(num),clean.global_clustering_coef(num),clean.short_path_length(num),clean.global_diffusion_efficiency(num)] = pvaf_bct_measures(clean_matrix);
    
        for noise_t = 1:41
            
            noise_datapath = ['E:\BCI\my_workplace\debrain_use_pvaf\data\data' num2str(num) '\noise' num2str(noise_t) '.set'];
            mfreq = calculate_freq_mvar(noise_datapath);
            noise_matrix = mvar_method_wu(method{method_i},mfreq);
            noise_DeVI(num,noise_t) = my_DeVI(clean_matrix,noise_matrix);
    
            [noise.global_efficiency(num,noise_t),noise.mean_local_efficiency(num,noise_t),noise.transitity(num,noise_t),noise.mean_clustering_coef(num,noise_t),noise.global_clustering_coef(num,noise_t),noise.short_path_length(num,noise_t),noise.global_diffusion_efficiency(num,noise_t)] = pvaf_bct_measures(noise_matrix);
        end
    
        for debrain_t = 1:12
    
            debrain_datapath = ['E:\BCI\my_workplace\debrain_use_pvaf\data\data' num2str(num) '\debrain' num2str(debrain_t) '.set'];
            mfreq = calculate_freq_mvar(debrain_datapath);
            debrain_matrix = mvar_method_wu(method{method_i},mfreq);
            debrain_DeVI(num,debrain_t) = my_DeVI(clean_matrix,debrain_matrix);
    
            [debrain.global_efficiency(num,debrain_t),debrain.mean_local_efficiency(num,debrain_t),debrain.transitity(num,debrain_t),debrain.mean_clustering_coef(num,debrain_t),debrain.global_clustering_coef(num,debrain_t),debrain.short_path_length(num,debrain_t),debrain.global_diffusion_efficiency(num,debrain_t)] = pvaf_bct_measures(debrain_matrix);
        end
    end

%     result_of_clean(method_i).palos = clean_pro;
    result1(method_i).global_efficiency = clean.global_efficiency;
    result1(method_i).mean_local_efficiency = clean.mean_local_efficiency;
    result1(method_i).transitity = clean.transitity;
    result1(method_i).mean_clustering_coef = clean.mean_clustering_coef;
    result1(method_i).global_clustering_coef = clean.global_clustering_coef;
    result1(method_i).short_path_length = clean.short_path_length;
    result1(method_i).global_diffusion_efficiency = clean.global_diffusion_efficiency;

%     result_of_noise(method_i).palos = noise_pro;
    result2(method_i).DEVI = noise_DeVI;
    result2(method_i).global_efficiency = noise.global_efficiency;
    result2(method_i).mean_local_efficiency = noise.mean_local_efficiency;
    result2(method_i).transitity = noise.transitity;
    result2(method_i).mean_clustering_coef = noise.mean_clustering_coef;
    result2(method_i).global_clustering_coef = noise.global_clustering_coef;
    result2(method_i).short_path_length = noise.short_path_length;
    result2(method_i).global_diffusion_efficiency = noise.global_diffusion_efficiency;

%     result_of_debrain(method_i).palos = debrain_pro;
    result3(method_i).DEVI = debrain_DeVI;
    result3(method_i).global_efficiency = debrain.global_efficiency;
    result3(method_i).mean_local_efficiency = debrain.mean_local_efficiency;
    result3(method_i).transitity = debrain.transitity;
    result3(method_i).mean_clustering_coef = debrain.mean_clustering_coef;
    result3(method_i).global_clustering_coef = debrain.global_clustering_coef;
    result3(method_i).short_path_length = debrain.short_path_length;
    result3(method_i).global_diffusion_efficiency = debrain.global_diffusion_efficiency;
end