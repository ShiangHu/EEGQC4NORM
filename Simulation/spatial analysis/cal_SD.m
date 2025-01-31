function mean_SD = cal_SD(LF,LFinv,sourceEEG,threshold)

    
    m = mean(sourceEEG.avg.pow,2);  %mean of the specified frequency band
    m(m<threshold) = 0;   %threshold
    t = find(~isnan(m)&m~=0);    %remove outside of the brain and pow <= threshold
    [~,SD] = f_resolution_analysis(LF(:,t),LFinv(t,:),sourceEEG.pos(t,:));
    mean_SD = mean(SD);
end

