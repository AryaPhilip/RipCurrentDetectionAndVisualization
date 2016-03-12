% Author : Shweta Philip
% Email: sphilip@ucsc.edu

% Reference - http://www.mathworks.com/matlabcentral/answers/48797-how-to-extract-frames-of-a-video

videoObj = VideoReader('20160105_163611.mp4');
loc_dir= 'Frame\20160105_163611\Direction\Direction_';
loc_mag = 'Frame\20160105_163611\Magnitude\Magnitude_';
mkdir Frame\20160105_163611\histogram;
mkdir Frame\20160105_163611\Direction;
mkdir Frame\20160105_163611\MagHist;
mkdir Frame\20160105_163611\Magnitude;
k = 1;

% creates the color wheel that maps direction to a Hue and Magnitude to
% saturation in an HSV model
colorwheel = makeColorWheel();
while(hasFrame(videoObj))
    if k == 1
        prev_frame = readFrame(videoObj);
    end
    if k > 1
        new_frame = readFrame(videoObj);
        % Performs optical flow algorithm on two consecutive frames.
        % Before passing the frames to LucasKanade, the frames are
        % converted to grayscale and resized to 480 x 640 resolution to
        % reduce the computation and the noise.
        [u, v] = LucasKanade(rgb2gray(imresize(prev_frame, [480, 640])),...
            rgb2gray(imresize(new_frame,[480, 640])),20);
        f(:,:,1) = u;
        f(:,:,2) = v;
        [img, rad] = flowtoColor(f,colorwheel);
        image_name_dir = strcat(loc_dir,num2str(k-1),'.bmp');
        image_name_mag = strcat(loc_mag,num2str(k-1),'.bmp');
        % Stores the color map of the optical flow as an image
        % imwrite(img, image_name);
        [img, rad] = MaskingFlow(img, rad);
        fh = figure;
        image(img, 'xdata', (1:10)/10);
        hold on
        axes('position', [0.7,0.7,0.3,0.3]);
        piechart(colorwheel);
        fig = getframe(fh);
        imwrite(fig.cdata, image_name_dir);
        imwrite(rad, image_name_mag);
        histogram(img,colorwheel, k-1);
        MagHist(rad, k-1);
        prev_frame = new_frame;
        close all;
    end
    k = k+1;
end