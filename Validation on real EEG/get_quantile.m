% get the quantitle of the boxplots

function out = get_quantile(data)

p = [0,0.25,0.5,0.75,1];

out = quantile(data,p);

end