
close all;
X1 = [];
X2 = [];
c1 = 0;
c2 = 0;
for i=1:length(Y)
    if Y(i) == 1
        c1 = c1 + 1;
        X1 = [X1; X(i, :)];
    else
        c2 = c2 + 1;
        X2 = [X2; X(i, :)];
    end
end

fig = figure;
ax = axes;
scatter(X2(:, 1), X2(:, 2), 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'b')
hold on
scatter(X1(:, 1), X1(:, 2), 'MarkerFaceColor', 'g', 'MarkerEdgeColor', 'b')

grid on
box on
ax.XTickLabel = string(ax.XTickLabel) + 'x';
ax.YTickLabel = string(ax.YTickLabel) + 'y';

ax.XLabel.String = 'Xlabel';
ax.YLabel.String = 'Ylabel';


% Create legend
legend1 = legend(ax,{'Non-fraud Firms', 'Fraud Firms'});
set(legend1,...
    'Position',[0.623732187238853 0.788095238095239 0.266071428571429 0.104968944099384],...
    'FontSize',16,...
    'FontName','Times New Roman');

set(gcf,'renderer','Painters')