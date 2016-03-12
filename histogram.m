function histogram(img,colorwheel, n)

normCW = colorwheel/255;
hsv_img = rgb2hsv(img);
h = hsv_img(:,:,1);

interval = zeros(37,1);
for i = 1:36
    interval(i+1) = interval(i) + 1/36 ;
end

hist_color = zeros(36,1);

for i=1:size(h,1)
   for j=1:size(h,2)
        for k=2:size(interval,1)
            if (h(i,j) >= interval(k-1)) && (h(i,j) < interval(k))
                %p(k) = h(i,j);
                hist_color(k-1) = hist_color(k-1) + 1;
            end
        end
  end
end
loc = 'Frame\VID_20160215_162717_2\histogram\hist_';
image_name = strcat(loc,num2str(n),'.bmp');

x = hist_color(:);
%y = interval(1:36);

%bar(hist_color(:,1) ,hist_color(:,2))
fHand = figure;
aHand = axes('parent', fHand);
hold(aHand, 'on')
for i = 1:numel(x)
    bar(i, x(i), 'parent', aHand, 'facecolor', normCW(i,:));
end
print('-dpng', image_name);
