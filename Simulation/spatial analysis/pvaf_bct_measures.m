function [global_efficiency,mean_local_efficiency,mean_clustering_coef,global_clustering_coef,short_path_length] = pvaf_bct_measures(matrix)
    
    global_efficiency = efficiency_wei(matrix);
    local_efficiency = efficiency_wei(matrix,2);
    clustering_coef = clustering_coef_wu(matrix);
    [short_path_length, ~,~]  = distance_wei_floyd(matrix,'log');
    short_path_length = mean(mean(short_path_length));
    global_clustering_coef = clustCoeff(matrix);
    mean_local_efficiency = mean(local_efficiency);
    mean_clustering_coef = mean(clustering_coef);
end

