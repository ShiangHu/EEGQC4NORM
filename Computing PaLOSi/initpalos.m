function initpalos 
% Initializing the PALOS running environment

% add palos toolbox
dpalos = 'D:\OneDrive - CCLAB\Scripting\Toolbox\PaLOS';

addpath(genpath(dpalos));
rmpath(genpath(fullfile(dpalos,'.git')));

% add reference
dref = 'D:\OneDrive - CCLAB\Scripting\Toolbox\RESTref\Unified-EEG-reference-rREST\unipolar_ref';
addpath(dref);

% add eeglab
% eeglabstart('');

% ext = {'_1O','_2C','_3F','_4L','_5H','_6E'};
% stepnm = {'EEGOrig','EEGcrd','EEGfiltered','EEGICLabel','EEGHighvarred','EEGItpl'};


% add riemannian distance
% Note the revised code in D:\OneDrive - CCLAB\Scripting\Riemann\higgs_ridge\distance
drie = 'D:\OneDrive - CCLAB\Scripting\Toolbox\Riemannian\covariancetoolbox-master\lib\distance';
addpath(drie);

% to produce the old results
% addpath('D:\CCLAB\ash - qceeg\5 Quality Check');

% add sim_pack
addpath(genpath('d:/OneDrive - CCLAB/Scripting/palos'));

fprintf('PaLOS set!\n');
end
