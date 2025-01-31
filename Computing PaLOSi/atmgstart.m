function atmgstart

st = dbstack;
toolpath = fileparts(which(st.file));

atmgpath = fullfile(toolpath,'../eeglabplugins/automagic');
addpath(atmgpath);

eeglabpath =  fullfile(toolpath,'../eeglab');
rmpath(genpath(eeglabpath));

clean;

runAutomagic

end