function MagHist(rad, n)

interval = zeros(37,1);
for i = 1:36
    interval(i+1) = interval(i) + 1/36 ;
end

rad_unsorted = zeros(36,1);

graycolor = zeros(37,3);
for i = 1 : 36
    for j = 1 : 3
    graycolor(i+1,j) = graycolor(i,j) + 1/36 ;
    end
end

for i=1:size(rad,1)
   for j=1:size(rad,2)
        for k=2:size(interval,1)
            if (rad(i,j) >= interval(k-1)) && (rad(i,j) < interval(k)) 
                rad_unsorted(k-1) = rad_unsorted(k-1) + 1;
            end
        end
  end
end

x = rad_unsorted(:);
loc = 'Frame\VID_20160215_162717_2\MagHist\MagHist_';
image_name = strcat(loc,num2str(n),'.bmp');

fHand = figure;
aHand = axes('parent', fHand);
hold(aHand, 'on')
for i = 1:numel(x)
    bar(i, x(i), 'parent', aHand, 'facecolor', graycolor(i,:));
end

print('-dpng', image_name);
