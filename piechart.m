function piechart(colorwheel)

X = ones(36,1);
numberOfSegments = length(X);
normCW = colorwheel/255;
normCWshift = fliplr(normCW);
normCWshift = circshift(normCWshift, 36);
hPieComponentHandles = pie( ones(1,numberOfSegments));
    % Assign custom colors.
for k = 1 : numberOfSegments
    % Create a color for this sector of the pie
    pieColorMap = normCWshift(k,:);	% Color for this segment.
    % Apply the colors we just generated to the pie chart.
    set(hPieComponentHandles(k*2-1), 'FaceColor', pieColorMap);
    set(hPieComponentHandles(k*2), 'String', 360 - mod((k+12),36) *10);
end