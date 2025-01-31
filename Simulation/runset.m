%  set the necessary paths for running toolboxes

% add the packages SEED-G, BCT, fieldtrip, EEGLAB

fieldtrip_start;

eeglabstart('nogui');

% SEED-G path

SEEDG_path = 'D:\OneDrive - CCLAB\Scripting\Toolbox\0-connectivity\SEED-G-toolbox';

addpath (genpath(SEEDG_path));


clean;

addpath (genpath(cd));