function k = ResizingVideo()
mkdir Frame\VID_20160215_162717_2\Resize

% output (k) - returns the number of frames in a video

% reads the input video
videoObj = VideoReader('VID_20160215_162717.mp4');

% The location and the prefix of the name of each frame stored
loc = 'Frame\VID_20160215_162717_2\Resize\Resize_';
k = 1;
while(hasFrame(videoObj))
    frame = readFrame(videoObj);
    % resizing each frame to 480 x 640 resolution
    frame = imresize(frame,[480 640]);
    image_name = strcat(loc,num2str(k-1),'.bmp');
    % writing the frame as an image to the disc
    imwrite(frame, image_name);
    k = k+1;
end

