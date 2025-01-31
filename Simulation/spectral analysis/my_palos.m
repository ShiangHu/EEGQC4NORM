function [pro, rkr, f] = my_palos(EEG,nw,fs,fm)
   %% edit at 2023/3/1 



   % check if cross spectra failes 
    if size(EEG,1)<2
        pro=0; 
        return; 
    end
    
    fmax = fm;   % filtering
    fmin = 0.5;   % filtering
%     loc = 'E:\BCI\my_workplace\debrain_use_pvaf\loc15.xyz';
    %[svfd,nm]=fileparts(varargin{4});
    [S, f, nss] = my_xspt(EEG,nw,fs,fmax,fmin);
    
    % idxing and referencing
    nf = size(S,3);
    n = nss*ones(1,nf);
    pmax = 10;
    lmax = 50;
    
    % CPC
    [lmd,~] = my_CPCstepwise1(S,n,pmax,lmax);
    lmd = abs(lmd(1:pmax,:)');  % freq by CPs
    psd = abs(tdiag(S));        % get the multichannel psd
    ssd = sum(psd(:));          % sum of powers (explained variance)
    % ssl = sum(lmd(:));        % sum of eigenvalues
    
    % palos index
    profd = lmd(:,1)/ssd;               % frequency dependent palosi of 1st cp
    % proch = Q./repmat(sum(Q.^2),[nc,1]);% channal weights in the CPC
    pro = sum(profd);                   % total palosi
    
    
    % ouput other qc measures
    rou = triu(corr(log10(psd)),1);
    mr = sum(rou(:))./(nf*(nf-1)/2);
    fid10 = (abs(f-10)==min(abs(f-10)));
    rkr = [rank(EEG), rank(psd), rank(S(:, :, fid10)), mr];
end

