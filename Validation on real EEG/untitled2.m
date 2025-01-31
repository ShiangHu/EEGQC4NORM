% Generate some random data
data = randn(100, 3); % 100 data points, 3 groups

% Create a violin plot
figure; % Open a new figure window
violinplot(data);

% Add a title and labels
title('Violin Plot Example');
xlabel('Group');
ylabel('Value');