function [] = plot_dipoles19(positions,varargin)
% positions: dipoles positions
% opotion parameters:
%        colors: dipoles color
dipole_num = size(positions,1);
switch dipole_num
    case 1
        colors = [1,0,0];
    case 3
        colors = [1,0,0;0,1,0;0,0,1];
    case 19
        colors = repmat([1,0,0;0,1,0;0,0,1],7,1);
end
% if nargin==1
%     colors = rand(dipole_num,3);
% else
%     colors = varargin{1};
% end
% view_surface('@default_subject/tess_cortex_pial_low.mat', 0.8, [], [], 0);
view_surface('@default_subject/tess_cortex_pial_low.mat', [], [], [], 0);
% view_surface('@default_subject/tess_outerskull.mat', [], [], [], 0);
% view_surface('@default_subject/tess_innerskull.mat', [], [], [], 0);
view_surface('@default_subject/tess_head.mat', 0.6, [], [], 0);

for num = 1:dipole_num
    hold on;
    mom = positions(num,:)/norm(positions(num,:));
    q = quiver3(positions(num,1),positions(num,2),positions(num,3),mom(:,1),mom(:,2),mom(:,3),0.02);
    axis equal
    q.ShowArrowHead = 'off';
    q.Marker = '.';
    q.LineWidth = 5;
    q.MarkerSize = 50;
%     q.Color = [1,0,0];
    q.Color = colors(num,:);
%     text(positions(num,1),positions(num,2),positions(num,3),num2str(num),'FontSize',20);
end
end

