iEEG = load('E:\MNI iEEG\MatlabFile\MatlabFile.mat');
load('E:\BCI\PaLOS-source-analysis-by-SEED-G\paper_result\1_data\19channel\ftHeadmodel.mat');
load('E:\BCI\PaLOS-source-analysis-by-SEED-G\paper_result\1_data\19channel\elec.mat');
load('E:\BCI\PaLOS-source-analysis-by-SEED-G\paper_result\1_data\19channel\sourcemodel.mat');
% new simulation
s = 1;
source = iEEG.Data_W';
% one dipole
switch s
    case 1
        select_dipole = sourcemodel.Vertices(2575,:);
        dipole_signal = {source(62,:)/norm(source(62,:))};
        [palos,EEG] = dipole_simulation19(elec,ftHeadmodel,dipole_signal,select_dipole,200);
    case 3
        select_dipole = sourcemodel.Vertices([2575,7763,13366],:);
        dipole_signal = {[source(233,:)/norm(source(233,:));source(637,:)/norm(source(637,:));source(75,:)/norm(source(75,:))]};
        [palos,EEG] = dipole_simulation19(elec,ftHeadmodel,dipole_signal,select_dipole,200);
    case 19
        select_dipole = sourcemodel.Vertices(new_19_pos,:);
        dipole_signal = {ss};
        [palos,EEG] = dipole_simulation19(elec,ftHeadmodel,dipole_signal,select_dipole,200);
end

% cfg = [];
% cfg.dip.unit = 'm';
% cfg.dip.pos = select_pos;
% data = ft_dipolesimulation(cfg);


% ft_plot_dipole(cfg.dip.pos, cfg.dip.mom, 'unit', 'm');
