% simulate IPE copyed from Ruan Jie Paper2

clear;clc;
dataset = 200;
mu = zeros(15,1);
sigma = eye(15,15);
for num = 1:dataset
    disp(['--------->dataset:' num2str(num) '<------------']);
    datapath = ['E:\BCI\my_workplace\debrain_use_pvaf\test_multi_channel\data\data' num2str(num) '\'];
    samp = pop_loadset('samp.set',datapath);
    noise = samp;
    R = mvnrnd(mu,sigma,2500)';
    for snr = -10:30
        mo = norm(samp.data)/(sqrt(10^(snr/10)));
        noise.data = samp.data+mo*R/norm(R);
        pop_saveset(noise,['noise' num2str(snr+11)],datapath);
    end
end