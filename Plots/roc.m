close all
clear Area

fig = figure;
ax = axes;



plot(fp, tp);
Area = area(fp, tp);

set(Area(1),'FaceColor',[245, 112, 110]./255);
set(Area(1),'LineWidth', 1);

ax.XLim = [0, 1];
ax.YLim = [0, 1.5];

box on
ax.XTickLabel = string(ax.XTickLabel) + 'x';
ax.YTickLabel = string(ax.YTickLabel) + 'y';

ax.XLabel.String = 'Xlabel';
ax.YLabel.String = 'Ylabel';


% Create textbox
annotation(fig,'textbox',...
    [0.324710255956071 0.774530124062106 0.357432601186786 0.124804992199688],...
    'String',{'ROC Curve And AUC of BAS'},...
    'LineWidth',1,...
    'HorizontalAlignment','center',...
    'FontWeight','bold',...
    'FontSize',20,...
    'FontName','Times New Roman',...
    'FitBoxToText','off');


% Create textbox
annotation(fig,'textbox',...
    [0.333142857142857 0.328571428571429 0.352571428571429 0.0904761904761909],...
    'String','AUC = $0.774$',...
    'LineStyle','none',...
    'Interpreter','latex',...
    'HorizontalAlignment','center',...
    'FontWeight','bold',...
    'FontSize',22,...
    'FontName','Times New Roman',...
    'FitBoxToText','off')

set(gcf,'renderer','Painters')