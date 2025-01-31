function [matrix] = mvar_method_wu(method,mfreq,band)

switch method
    case 'coh'    
        cfg = [];
        cfg.method = 'coh';
        stat = ft_connectivityanalysis(cfg, mfreq);
        matrix = stat.cohspctrm(:,:,stat.freq == 10);
        matrix = abs(matrix);
        matrix = symmetrization(matrix);
    case 'icoh'    
        cfg = [];
        cfg.method = 'coh';
        cfg.complex = 'imag';  
        stat = ft_connectivityanalysis(cfg, mfreq);
        matrix = stat.cohspctrm(:,:,stat.freq == 10);
        matrix = abs(matrix);
        matrix = symmetrization(matrix);

    case 'dtf'    
        cfg = [];
        cfg.method = 'dtf';
        stat = ft_connectivityanalysis(cfg, mfreq);
        matrix = stat.dtfspctrm(:,:,stat.freq == 10);
        matrix=matrix-diag(diag(matrix));
        matrix = abs(matrix);
        matrix = symmetrization(matrix);

    case 'granger'  
        cfg = [];
        cfg.method = 'granger';
        stat = ft_connectivityanalysis(cfg, mfreq);
        matrix = stat.grangerspctrm(:,:,stat.freq == 10);
        matrix = abs(matrix);
        matrix = matrix/(max(max(matrix)));
        matrix = symmetrization(matrix);

    case 'pdc'     
        cfg = [];
        cfg.method = 'pdc';
        stat = ft_connectivityanalysis(cfg, mfreq);
        matrix = stat.pdcspctrm(:,:,stat.freq == 10);
        matrix=matrix-diag(diag(matrix));
        matrix = abs(matrix);
        matrix = symmetrization(matrix);


    case 'plv' 
        cfg = [];
        cfg.method = 'plv';
        stat = ft_connectivityanalysis(cfg, mfreq);
        matrix = mean(stat.plvspctrm(:,:, stat.freq >= band(1) & stat.freq <= band(2)),3);
        matrix=matrix-diag(diag(matrix));
        matrix = abs(matrix);
        matrix = symmetrization(matrix);

    case 'psi' 
        cfg = [];
        cfg.method = 'psi';
        cfg.bandwidth = 2;
        stat = ft_connectivityanalysis(cfg, mfreq);
        matrix = stat.psispctrm(:,:,stat.freq == 10);
        matrix=matrix-diag(diag(matrix));
        matrix = abs(matrix);
        matrix = symmetrization(matrix);

end
end