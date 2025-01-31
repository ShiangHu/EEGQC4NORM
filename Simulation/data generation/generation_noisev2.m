% simulate IPE

clear;clc;
datapath = 'D:\OneDrive\2_Projects\8 EEGQC\2022级\4. code\Paper2\DataGenerated';

dataset = 10;
mu = zeros(15,1);
sigma = eye(15,15);
% for num = 1:dataset
% disp(['--------->dataset:' num2str(num) '<------------']);

samp = pop_loadset('samp.set',datapath);
noise = samp;
R = mvnrnd(mu,sigma,2500)';
for snr = -10:30
    mo = norm(samp.data)/(sqrt(10^(snr/10)));
    noise.data = samp.data+mo*R/norm(R);
    pop_saveset(noise,['noise' num2str(snr+11)],datapath);
end
% end