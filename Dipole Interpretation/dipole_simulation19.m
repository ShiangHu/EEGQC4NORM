function [palos,EEG] = dipole_simulation19(elec,ft_method_headmodel,dipole_signal,select_dipole,fsampe)
    cfg = [];
    cfg.dip.unit = 'm';
    cfg.dip.pos = select_dipole;
    for i = 1:size(select_dipole)
        mom(i,:) = select_dipole(i,:)/norm(select_dipole(i,:));
    end
    cfg.elec = elec;
    cfg.headmodel = ft_method_headmodel;
    cfg.dip.signal = dipole_signal; 
    cfg.dip.mom = mom;
    cfg.fsample = fsampe;
    data = ft_dipolesimulation(cfg.dip.signal);
    if size(cell2mat(dipole_signal),1) > 10
        palos.source = my_palos(dipole_signal,3,fsampe,40);
    end
    
    palos.scalp = my_palos(cell2mat(data.trial),3,fsampe,40);
    EEG = pop_importdata('data',data.trial,'chanlocs','E:\BCI\PaLOS-source-analysis-by-SEED-G\paper_result\1_data\19channel\Standard-10-20-Cap19.locs','srate',fsampe);
    eegplot(EEG.data);
    pop_spectopo(EEG, 1, [0  54396], 'EEG' , 'freq', [], 'freqrange',[0 30],'electrodes','off');
%     pop_spectopo(EEG, 1, [0  9996], 'EEG' , 'freq', 2:2:30, 'freqrange',[0 35],'electrodes','off');
%     saveas(gcf,['E:\BCI\PaLOS-source-analysis-by-SEED-G\paper_result\1_data\test_dipole_by_step\spectopo' num2str(size(select_dipole,1))]);
%     close;
%     eegplot(cell2mat(dipole_signal),'winlength',0.5);
    
    plot_dipoles19(select_dipole);
%     saveas(gcf,['E:\BCI\PaLOS-source-analysis-by-SEED-G\paper_result\1_data\test_dipole_by_step\dipole' num2str(size(select_dipole,1))]);
%     close;
    
end

