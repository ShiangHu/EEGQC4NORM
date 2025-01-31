% simulate EPE 

% clear;clc;


dataset = 200;
for num = 1:dataset
    datapath = ['E:\BCI\my_workplace\debrain_use_pvaf\data\data' num2str(num) '\'];
    EEG = pop_loadset('samp.set',datapath);
    [EEG, ~] = pop_runica(EEG,'icatype','runica');

    for component = 1:size(EEG.data,1)
        [~,pvaf(component)] = compvar(EEG.data,EEG.icaact,EEG.icawinv,component);
    end

    [sorted_pvaf,sorted_i] = sort(pvaf);
    for remove_i = 1:length(sorted_i)-1
        OUTEEG = pop_subcomp(EEG,sorted_i(1:remove_i));
        pop_saveset(OUTEEG,'filename',['debrain' num2str(remove_i)],'filepath',datapath);
    end
    
end

