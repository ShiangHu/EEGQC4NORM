% set parameters for simulations
clean;
addpath(genpath(cd));

clear ;clc;
datadir   = 'E:\BCI\my_workplace\icoh\real data';
name      = 'sLOR_cortical_sources.mat'; 
Struct    = loadname(fullfile(datadir,name));

%2 Set parameters
DataLength =    2500;
Trials =        1;
ModelDel =      [];
SNR =           10;
sig_num =       15;
density =       0.05;
val_Range =     [-0.5 0.5];
AR_perc =       0.3;
AR_choice =     1;
popt =          10;

%3. Specify if the data should be projected on the scapl after the
%        generation
forward = 1;
%       1 for forward problem solution
%       0 otherwise (no prjection in the sensor space)

% If you select forwar = 1 --> please specify channel labels and ROI labels
% 3.1 Specify list of electrodes for forward model
sensors_labels = {'Fp1' 'Fpz' 'Fp2' 'F5' 'Fz' 'F6' 'C5' 'Cz' 'C6' 'P5' 'Pz' 'P6' 'O1' 'Oz' 'O2'}; %15.loc

%sensors_labels = {'Fp1' 'Fp2' 'F7' 'F3' 'Fz' 'F4' 'F8' 'T7' 'C3' 'Cz' 'C4' 'T8' 'P7' 'P3' 'Pz' 'P4' 'P8' 'O1' 'O2'}; %19.loc
%3.2 ROI selection
%   Each generated signal will be located on the brain cortex according to
%   the provided list of ROIs labels

ROI_labels = {'Brodmann area 1_L' 'Brodmann area 1_R' 'Brodmann area 19_L' 'Brodmann area 19_R','Brodmann area 10_L','Brodmann area 10_R' 'Brodmann area 17_L' 'Brodmann area 17_R'...
    'Brodmann area 23_L' 'Brodmann area 23_R' 'Brodmann area 29_L' 'Brodmann area 29_R' 'Brodmann area 33_L' 'Brodmann area 33_R' 'Brodmann area 37_L' };

if length(ROI_labels)~=sig_num
    error('The number of ROI lables must be equal to the number of generated signals.')
end
%3.3 path for dependencies NYH and Fieldtrip
nyh_path = 'E:\BCI\my_workplace\icoh\dependencies\NYH';
ft_path = 'E:\BCI\my_workplace\icoh\dependencies\Fieldtrip';

[Y_gen, E_gen, ModelDel, flag_out]=ft_generation(DataLength,...
    Trials,ModelDel,SNR,Struct.samp,sig_num,density,val_Range,AR_perc,AR_choice,popt,forward,sensors_labels,ROI_labels,nyh_path,ft_path,data_path);

