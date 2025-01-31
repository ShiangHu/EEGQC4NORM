% set colorbars for the cu_bns_IPE_EPE

clean;

% Define the RGB values of PowerPoint theme colors (example theme)
ppt_colors = [

128, 53, 14; % warm5
192, 79, 21; %
233, 113, 50;
242, 170, 132;
246, 198, 173;
251, 227, 214;

235, 232, 230; % Raw

220, 237, 247; % cold1
166, 202, 236;
78, 149, 217;
33, 95, 154;
22, 62, 100;
14, 40, 65;
];

% Normalize RGB values to the range [0, 1]
ppt_colors_normalized = ppt_colors / 255;

% Apply the custom colormap
colormap(ppt_colors_normalized);

% Generate a demo plot
surf(peaks);        % Example 3D plot
colorbar;           % Add a colorbar to visualize the colormap


aa = mean(ppt_colors(6:7,:));