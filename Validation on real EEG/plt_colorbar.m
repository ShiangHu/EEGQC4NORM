% Define the RGB values of PowerPoint theme colors (example theme)
ppt_colors = [
    68, 114, 196;   % Blue
    237, 125, 49;   % Orange
    255, 192, 0;    % Yellow
    91, 155, 213;   % Light Blue
    112, 173, 71;   % Green
    255, 0, 0;      % Red
    165, 165, 165   % Gray
];

% Normalize RGB values to the range [0, 1]
ppt_colors_normalized = ppt_colors / 255;

% Apply the custom colormap
colormap(ppt_colors_normalized);

% Generate a demo plot
surf(peaks);        % Example 3D plot
colorbar;           % Add a colorbar to visualize the colormap

% Interpolate to create a smoother gradient of 256 colors
n_colors = 256; % Number of colors in the colormap
gradient_colormap = interp1(linspace(0, 1, size(ppt_colors_normalized, 1)), ...
                            ppt_colors_normalized, ...
                            linspace(0, 1, n_colors));

% Apply the interpolated colormap
colormap(gradient_colormap);

% Generate a demo plot
surf(peaks);
colorbar;