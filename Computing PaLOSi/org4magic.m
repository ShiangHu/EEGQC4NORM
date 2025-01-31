
clc; clear; close all;
addpath(genpath(cd));
cmipath = 'D:\CMI_HBN_EEG_rest';
svpath = 'E:\Datasets\CMI_EEG1306';
rawset = dir(fullfile(cmipath,'**','raw','**','RestingState.mat')); 
prepset = dir(fullfile(cmipath,'**','preprocessed','**','RestingState.mat'));

for i=1:size(rawset,1)
    source = [rawset(i).folder,'\RestingState.mat'];
    goal = fullfile(svpath,rawset(i).folder(21:32));
    mkdir(goal);
    copyfile(source,[goal,'\RestRaw.mat'])
end

for i=1:size(prepset,1)
    source = [prepset(i).folder,'\RestingState.mat'];
    goal = fullfile(svpath,prepset(i).folder(21:32));
    if ~isdir(goal), mkdir(goal); end
    copyfile(source,[goal,'\RestPrep.mat'])
end