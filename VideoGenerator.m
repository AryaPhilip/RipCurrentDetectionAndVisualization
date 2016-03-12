% Author : Shweta Philip
% Email: sphilip@ucsc.edu

% Reference - http://www.mathworks.com/help/matlab/examples/convert-between-image-sequences-and-video.html?refresh=true
function outputVideo = VideoGenerator(frameCount)

% input (frameCount)- Number of frames
% output (outputVideo) - a Video that contains the overlap of the flow map onto the
%          frames


% stores the inputVideo to extract the frame rate
inVideo = VideoReader('20160105_163611.mp4');
loc = 'Frame\20160105_163611_5\Overlayed_';

% creates and video to store the frames
outputVideo = VideoWriter(fullfile('Frame\20160105_163611\' ...
    ,'RipCurrentvideo.mp4'));

% specifying the frame rate of the final video
outputVideo.FrameRate = inVideo.FrameRate;

% open the video for editing
open(outputVideo);

%stores each individual frame within the video
for ii = 1: frameCount - 2
    image_name = strcat(loc,num2str(ii),'.bmp');
    img = imread(image_name);
    writeVideo(outputVideo, img);
end

% close the video
close(outputVideo);