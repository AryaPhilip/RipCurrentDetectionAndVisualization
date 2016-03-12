function drawArrow(x,y,a,w)
%x = 100;
%y = 200;
line([x x+a], [y y-a],'LineWidth',w,'Color',[0 1 0])
%line([x+a x+a], [y-a y+a])
line([x x+a], [y y+a],'LineWidth',w,'Color',[0 1 0])