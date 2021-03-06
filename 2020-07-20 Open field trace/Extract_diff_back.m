function c_pos=Extract_diff_back(background_frame,input_frame,xLeft, xRight, yUp, yDown,area_L,area_H)
% To chop the ori_image based on analysis area

background_frame_a=background_frame(yUp:yDown,xLeft:xRight,:);
input_frame_a=input_frame(yUp:yDown,xLeft:xRight,:);

% Import ori
I0_b=background_frame_a;
I0_m=input_frame_a;
% figure(2);
% imshow(I0_m);

% RGB to Grey
I0_b_g=rgb2gray(I0_b);
% figure(3);
% imshow(I0_b_g);
I0_m_g=rgb2gray(I0_m);
% figure(4);
% imshow(I0_m_g);

% substract the image to the background
I_s=imsubtract(I0_b_g,I0_m_g);
% figure(5);
% imshow(I_s);

I_s_BW = im2bw(I_s, 0.3); % Gray to BW,  to be set
% figure(6);
% imshow(I_s_BW);

I_s_BW_m = medfilt2(I_s_BW,[10,10]); % Medium Filter, get rid of pepper noise
% figure(7);
% imshow(I_s_BW_m);

% Count the connected area
L = bwlabeln(I_s_BW_m, 8);
S = regionprops(L, 'Area');

% To be set the area threshold
pos = ([S.Area] <= area_H) & ([S.Area] >= area_L);

bw2 = ismember(L, find(pos));
S1 = [S.Area];
S1 = S1(pos);
C = regionprops(bw2, 'Centroid');  % to be processed
% Get the center of connected areas
C1 = [C.Centroid];
C1 = reshape(C1, 2, length(C1)/2)';
c_pos=C1;

% Mark the connected region on the orignal picture

% figure(2); hold on;
% plot(C1(:,1), C1(:,2), 'g+', 'MarkerSize', 10);
% hold off;

end