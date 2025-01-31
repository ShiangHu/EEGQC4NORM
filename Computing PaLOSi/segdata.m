function [data] = segdata(data, fs, detf)
% input: 
%    data  : EEG data, ne-nt;
%        fs  : sampling rate;
%        detf:  frequency resolution;
% output 
%    data  : 
%       data: ne * nfft * nseg


[ne, nt] = size(data);

nfft  = round(fs/detf);

nseg   = floor(nt/nfft);

data(:,nfft*nseg+1:end)=[];

data = reshape(data, [ne, nfft, nseg]);
end