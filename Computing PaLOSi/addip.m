function addip(prjnm)
% Since the interpolation is manual started at the final step after mara
% This is to contain the EEG after interpolation into the allStep*mat to
% calculate all the index

% Confirmed with Nic that: Orgin=CRD, HighVar=Final
% see https://github.com/methlabUZH/automagic/wiki/Quality-Assessment-and-Rating#combination-of-file-prefixes

% add interpolated one or preprocessed one without interpolation

% Shiang Hu, Aug7, 2021

atmall = dir(fullfile(['*',prjnm,'*'],'**','all*.mat'));
preres  = dir(fullfile(['*',prjnm,'*'],'**','*p_*.mat'));

if length(atmall)~=length(preres), error('interpolation or rating not finished!'), end

tic
for i=1:length(preres)
    disp(['>>---------------------Appending subject:',blanks(15),num2str(i)]);
    
    sbjpath = preres(i).folder;
    
    load(fullfile(sbjpath,preres(i).name),'EEG');
    EEGItpl = EEG;
    
    save(fullfile(sbjpath,atmall(i).name),'EEGItpl','-append');
    toc
end


% for old version
%save(fullfile(sbjpath,sbjname),...
%        'EEGOrig','EEGprep','EEGfiltered','EEGRegressed',...
%        'EEGMARA','EEGdetrended','EEGitpl')