function Video_base_motion_test(moviepath,first_frame,duration_time,analysis_interval,frame_rate)


% Load the movie
filename=moviepath;

% Load movie_raw_data
E_M_movie = VideoReader(filename,'Tag','My reader object');
nFrames = E_M_movie.NumberOfFrames;
vidHeight = E_M_movie.Height;
vidWidth = E_M_movie.Width;
mov(1:nFrames) = ...
    struct('cdata',zeros(vidHeight,vidWidth, 3,'uint8'),...
    'colormap',[]);


% begin to analysis movie
% step 1, extract the blace mice from background
idx=0;

for i=first_frame:analysis_interval*frame_rate:first_frame+duration_time*frame_rate
% for i=120+2400*11:2400:120+2400*12
    idx=idx+1;
% i=2400;

% read the orignal image
I=read(E_M_movie,i);
% image to gray
I_g=rgb2gray(I);
figure(1);
imshow(I_g)
% image gray to bw
I_bw= im2bw(I_g, 0.05); % Gray to BW,  to be set
I_bw=imcomplement(I_bw); % invert the black and white
figure(2);
imshow(I_bw)

I_bw_m = medfilt2(I_bw,[10,10]); % Medium Filter, get rid of pepper noise
figure(3);
imshow(I_bw_m)

I_sum{idx}=I_bw_m;
% 

end

% step 2 compare image difference between sequential frames
for j=1:idx-1
    
    I_s=imsubtract(I_sum{j+1},I_sum{j}); % substract next image
figure (4)
I_s_bw_m = medfilt2(I_s,[5,5]); % Medium Filter, get rid of pepper noise
imshow(I_s_bw_m)
% pause (0.01)
F(j)=sum(I_s_bw_m(:));
end

% Export the motion index to the excel files
xls_fileName=[filename(1:end-4),'_motion_idx.xlsx'];
xlswrite(xls_fileName,F')

end

% Segout(BWoutline) = 255;
% figure, imshow(Segout), title('outlined original image');
