function [EEG,pvafval,class_id,pvaf_bic,p_bic] = sort_ic(EEG)
% sort the ICs as the type of ICs and the "% scalp data var. accounted for (vaf)"
% Sort the ICs as the Brain and Artifact (non-brain ICs)
% For the Brain ICs, sort it as the vaf with "descend";
% For the Artifact ICs, sort it as the  vaf with "ascend".
%
% Input
%         EEG -- eeglab structure with ICA and IClabel processed
% output
%         EEG    --- all the ICs info reordered as vaf
%         pvafval --- reordered % scalp data var. accounted for (vaf) 
%         classid --- reordered IC classes
%         index -- index to re-order the IC

% See also pop_prop_extended, iclabel, runica
% See also Reorder components by variance pop_runica.m 
% Shiang Hu, Nov7, 2021


maxsamp = 1e5;
n_samp = min(maxsamp, EEG.pnts*EEG.trials);
try
    samp_ind = randperm(EEG.pnts*EEG.trials, n_samp);
catch
    samp_ind = randperm(EEG.pnts*EEG.trials);
    samp_ind = samp_ind(1:n_samp);
end
if ~isempty(EEG.icachansind)
    icachansind = EEG.icachansind;
else
    icachansind = 1:EEG.nbchan;
end
datavar = mean(var(EEG.data(icachansind, samp_ind), [], 2));

Nic = size(EEG.icawinv,2);
pvafval = zeros(Nic,1);
for i=1:Nic
    % projvar varying with IC
    projvar = mean(var(EEG.data(icachansind, samp_ind) - EEG.icawinv(:,i) * EEG.icaact(i, samp_ind), [], 2));
    pvafval(i) = 100 *(1 - projvar/ datavar);
end


% icclass = EEG.etc.ic_classification.ICLabel.classes;
ic_scores = EEG.etc.ic_classification.ICLabel.classifications';
[class_id, ~] = ind2sub(size(ic_scores), find(ic_scores==max(ic_scores)));

% brain ICs
idx_bic = find(class_id==1);
[pvaf_bic, id2_bic] = sort(pvafval(idx_bic),'descend');

% non-brain ICs
idx_nbic = find(class_id~=1);
[pvaf_nbic, id2_nbic] = sort(-pvafval(idx_nbic),'descend');

pvafval = [pvaf_bic; pvaf_nbic];
index = [idx_bic(id2_bic); idx_nbic(id2_nbic)];

% reorder EEG IC info
class_id = class_id(index);
EEG.icawinv = EEG.icawinv(:,index);
EEG.icaact = EEG.icaact(index,:);
EEG.icaweights = EEG.icaweights(index,:);
EEG.etc.ic_classification.ICLabel.classifications = EEG.etc.ic_classification.ICLabel.classifications(index,:);

pvaf_bic= sum(pvaf_bic)/100;
p_bic = sum(class_id==1)/length(class_id);
end