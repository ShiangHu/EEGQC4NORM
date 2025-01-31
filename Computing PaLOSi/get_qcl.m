function ratio = get_qcl(resdir,varargin)
% Get the quality classification labels form the prefixes of rated EEG
%
% resdir --- the results folder of automagic

res = dir(fullfile(resdir,'**','*p_*.mat'));
subid = 1:length(res);

if ~ischar(resdir)||isempty(res)
    return;
elseif nargin==2
    subid = varargin{1};
end

ratio = cell(length(subid),2);

for j=1:size(ratio,1)
    
    i = subid(j);
    
    [~,ratio{j,1}] = fileparts(res(i).folder);
    
    prefix = res(i).name(1);
    
    if ismember(prefix,'gob')
        ratio{j,2} = fullname(prefix);
    else
        ratio{j,2} = nan;
        disp([ratio{j,1},':',blanks(15),'NOT rated!'])
    end
    
end

disp(ratio);
end

function label = fullname(prefix)
if prefix=='g'
    label='Good';
    
elseif prefix=='o'
    label='Ok';
    
elseif prefix=='b'
    label = 'Bad';
end
end