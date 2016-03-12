loc = 'Frame\VID_20160215_162717_2\Magnitude\Magnitude_';
close all

k = ResizingVideo();

loc_img = 'Frame\VID_20160215_162717_2\Resize\Resize_';
for l = 0:k/30
    for j = 1: 90
        sum = zeros(480, 640, 'uint8');
        average = zeros(480, 640);
        for i = j:90+j
            if(l*30 + i) > k
                return;
            end
            image_name = strcat(loc, num2str(l*30 + i),'.bmp');
            image = imread(image_name);
            sum = imadd(sum, image/255);
            average = average + im2double(image)/255;
        end
        
      if(l*30 + 90 + j -1) > k
         return; 
      end
      img_name = strcat(loc_img, num2str(l*30 + 90+j-1),'.bmp');
        
      img = imread(img_name);
      acc = sum;
      figure('name','acc')
      imshow(acc);
      angle = 0.5417 * 180/pi ;
        
      BW = acc > 23;
  
      iptsetpref('ImshowBorder','tight');
      acc = imrotate(acc, angle, 'crop');
      average = imrotate(average, angle, 'crop');
      BW = imrotate(BW, angle,'crop');
      se = strel('disk',10);
      BW = imclose(BW, se);
      BW = imfill(BW, 'holes');
      BW = bwareaopen(BW, 100);
      acc(~BW) = 0;
      fh = figure('name','After Rotation');
      
      imshow(acc)
      
      bb  = regionprops(BW, {'BoundingBox','Centroid'});
      boundingboxes = cat(1, bb.BoundingBox);
      centroids = cat(1, bb.Centroid);
      area = size(boundingboxes,1);
       
      for b = 1:size(boundingboxes,1)
          area(b) = boundingboxes(b,3) * boundingboxes(b,4);
      end
        
      areaMax = max(area);
      for b = 1:size(boundingboxes,1)
          if( (boundingboxes(b,3) * boundingboxes(b,4)) < areaMax /4)
              boundingboxes(b,:) = 0;
          end
      end
        
      hold on
      nol = 3;
      a = 5;
        
      for b = 1:size(boundingboxes,1)
          if(boundingboxes(b,3) ~= 0 && boundingboxes(b,4) ~= 0)
              x = floor(boundingboxes(b,1));
              y = floor(boundingboxes(b,2));
              w = floor(boundingboxes(b,3));
              h = floor(boundingboxes(b,4));
              mat = average(y:y+h,x:x+w);
              avg = mean2(nonzeros(mat));
               
              y1 = linspace(y,y+h,nol);
              line([x+w/3 x+w-10],[y1(2) y1(2)],'LineWidth'...
                  ,avg*50,'Color',[0 1 0])
              drawArrow(x+w/3, y1(2), a ,avg*50);
          end
      end
        
      fig = getframe(fh);
        
      hold off
      figure
      imshow(BW)
      fig_r = imrotate(fig.cdata, -angle, 'crop');
      BW = imrotate(BW,-angle, 'crop');
        
      imshow(fig_r)
      imresize(fig_r,[480 640]);
         
      imshow(fig_r);

      fh = figure;
      imshow(img);
      hOVM = alphamask(BW, [1 0 0], 0.5);
      hold on
      h = imshow(fig_r);
      set(h, 'AlphaData',0.5);
      hold off
      im = getframe(fh);
      loc_result = 'Frame\VID_20160215_162717_2\Overlayed_';
        
      image_result = strcat(loc_result,num2str(l*30 + 90+j-1), '.bmp');
      imwrite(im.cdata,image_result);
      close all
  end
end