% grab all the resting raw and preprocessed EEG for QC metric

clc; clear; close all;
addpath(genpath(cd));
cmipath = 'E:\Datasets\CMI_61EEG';
svpath = 'D:\CMI_HBN_EEG_rest';
rawset = dir(fullfile(cmipath,'**','raw','**','RestingState.mat')); 
prepset = dir(fullfile(cmipath,'**','preprocessed','**','RestingState.mat'));

for i=1:size(rawset,1)
    source = [rawset(i).folder,'\RestingState.mat'];
    goal = fullfile(svpath,rawset(i).folder(23+6:34+6),'raw');
    mkdir(goal);
    copyfile(source,goal)
end

for i=1:size(prepset,1)
    source = [prepset(i).folder,'\RestingState.mat'];
    goal = fullfile(svpath,prepset(i).folder(23+6:34+6),'preprocessed');
    mkdir(goal);
    copyfile(source,goal)
end