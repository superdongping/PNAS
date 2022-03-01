function Video_base_motion_index=Video_base_motion_test(movie_input_filename,start_time,duration_time,group_no)



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


idx=0;
for i=120:2400:86400+120
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

for j=1:idx-1
    
    I_s=imsubtract(I_sum{j+1},I_sum{j}); % substract next image
figure (4)
I_s_bw_m = medfilt2(I_s,[5,5]); % Medium Filter, get rid of pepper noise
imshow(I_s_bw_m)
pause (0.01)
F(j)=sum(I_s_bw_m(:));
end
figure(5)
plot(F)
xlswrite('Video_base_motion_index.xls',F')
figure(6)
plot(abs(F))
figure(7)
hist(F, 50)

end
% figure, imshow(I), title('original image');
% text(size(I,2),size(I,1)+15, ...
%  'Image courtesy of Alan Partin', ...
%  'FontSize',7,'HorizontalAlignment','right');
% text(size(I,2),size(I,1)+25, ....
%  'Johns Hopkins University', ...
%  'FontSize',7,'HorizontalAlignment','right');
% 
% [~, threshold] = edge(I, 'sobel');
% fudgeFactor = .5;
% BWs = edge(I,'sobel', threshold * fudgeFactor);
% figure, imshow(BWs), title('binary gradient mask');
% 
% se90 = strel('line', 3, 90);
% se0 = strel('line', 3, 0);
% 
% BWsdil = imdilate(BWs, [se90 se0]);
% figure, imshow(BWsdil), title('dilated gradient mask');
% 
% 
% BWdfill = imfill(BWsdil, 'holes');
% figure, imshow(BWdfill);
% title('binary image with filled holes');
% 
% 
% BWnobord = imclearborder(BWdfill, 4);
% figure, imshow(BWnobord), title('cleared border image');
% 
% 
% seD = strel('diamond',1);
% BWfinal = imerode(BWnobord,seD);
% BWfinal = imerode(BWfinal,seD);
% figure, imshow(BWfinal), title('segmented image');
% 
% BWoutline = bwperim(BWfinal);
% Segout = I;
% Segout(BWoutline) = 255;
% figure, imshow(Segout), title('outlined original image');
