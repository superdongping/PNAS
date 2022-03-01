function [c_pos_sum,a_x,a_y,a_w,a_h]=Mice_trajectory(movie_input_filename,start_time,duration_time,group_no,side_var)

% close all;
% clear all;
% clc;

% This program is used to analysis the animal trajectory of the open field test based on the video
% taken previewously

% Load the movie
filename=movie_input_filename;

% Load movie_raw_data
E_M_movie = VideoReader(filename,'Tag','My reader object');
nFrames = E_M_movie.NumberOfFrames;
vidHeight = E_M_movie.Height;
vidWidth = E_M_movie.Width;
mov(1:nFrames) = ...
    struct('cdata',zeros(vidHeight,vidWidth, 3,'uint8'),...
    'colormap',[]);

% Select analysis area, draw rectangle
I_background=read(E_M_movie,1);
background_frame=I_background;
hf = figure(1);
set(hf, 'position', [150 150 vidWidth vidHeight])
imshow(I_background);


% [a_xLeft, a_xRight, a_yUp, a_yDown,a_x,a_y,a_w,a_h]=ManualDraw_analysisArea;
% variation only for multi-operation
% 
%

if side_var==0
% for left
a_xLeft=82;
a_xRight=317;
a_yUp=44;
a_yDown=271;
a_x=82;
a_y=44;
a_w=234;
a_h=227;

else
% for right
a_xLeft=318;
a_xRight=549;
a_yUp=44;
a_yDown=270;
a_x=318;
a_y=44;
a_w=232;
a_h=226;

end
% Manual input the length of drawed line
% Ruler_p=ManualDraw_Ruler();
Ruler_p=227;
% draw_length=input('Please enter the length of the Line (cm)');
draw_length=45;
% Calculate the length per pixels
len_per_pixels=draw_length/Ruler_p;

area_L=100;
area_H=10000;


mice_x=0;
mice_y=0;
c_pos_sum=[];
p_dis_sum=0;
p_vel=0;

framerate=E_M_movie.FrameRate;
time_interval_per_frame=1/framerate; % 24 frame per second
frame_sample_interval=1; % analysis sample interval
time_interval_per_sample_frame=time_interval_per_frame*frame_sample_interval;

first_analysis_frame=60*24*(start_time+0); %start time 3*60s*24frames/s +24*60*5*2
pos_sum=[];
pos_result_tmp=[];
mice_appear_frame=0;

% for idx = first_analysis_frame:frame_sample_interval:nFrames
nFrames=first_analysis_frame+24*60*duration_time; % analysis for 5 min

 for idx = first_analysis_frame:frame_sample_interval:nFrames
    idx
    mov(idx).cdata = read(E_M_movie,idx);
    input_frame = mov(idx).cdata;
    % Get the central point of the mouse
    c_pos=Extract_diff_back(background_frame,input_frame,a_xLeft, a_xRight, a_yUp, a_yDown,area_L,area_H);
    if isempty(c_pos)
        continue
    end
    
    if ~isempty(c_pos)
        mice_appear_frame=mice_appear_frame+1;
        
        
        mice_x=c_pos(1)+a_x;
        mice_y=c_pos(2)+a_y;
        pos_input_frame=[mice_x,mice_y];
    else
        pos_result = pos_result_tmp;
    end
    pos_result_tmp=pos_input_frame;
    
    
    % Distance between each point
    if mice_appear_frame==1
        p_dis(1)=0;
        p_vel(1)=0;
        r_vel(1)=0;
    else
        p_dis(mice_appear_frame,1)=norm(pos_sum(end,:)-pos_input_frame);
        
        % Speed calculate
        p_vel(mice_appear_frame,1)=p_dis(mice_appear_frame,1)/time_interval_per_sample_frame;
        % Real speed (cm/frame)
        r_vel(mice_appear_frame,1)=p_vel(mice_appear_frame,1)*len_per_pixels; %real speed per frame
    end
    % Distance summary
    p_dis_sum=[p_dis_sum;p_dis];
    % central point summary
    c_pos_sum=[c_pos_sum;pos_input_frame];
    pos_sum=[pos_sum;pos_input_frame];
%     figure(02);
%     imshow(input_frame);
%     hold on;
%     % plot the central point and the trajectory of the mouse
%     rectangle('Position',[a_x,a_y,a_w,a_h],'EdgeColor','k','LineWidth',2);
%     plot(mice_x,mice_y, 'g+', 'MarkerSize', 10);
%     plot(c_pos_sum(:,1),c_pos_sum(:,2),'r','LineWidth',2);
%     if idx==first_analysis_frame
%         disp('begin')
%     else
%         text(pos_input_frame(1)+5,pos_input_frame(2)+5,['Speed','=',num2str(r_vel(mice_appear_frame,1)),'cm/s'],'color','b');
%     end
%     hold off;
    
 end

% trace_fig_name=['trace_',filename(1:end-4),num2str(group_no),'_',num2str(side_var)];
% saveas(gcf,trace_fig_name,'tif');

% Calculate averange speed per second
nlen=length(r_vel);
ntime=floor(nlen/framerate);
for i=1:ntime
    aver_vel(i)=mean(r_vel(((i-1)*framerate)+1:(i*framerate)));
end
figure(03)
plot(aver_vel)
vel_fig_name=['vel_',filename(1:end-4),num2str(group_no),'_',num2str(side_var)];
saveas(gcf,vel_fig_name,'tif')
vel_file_name=['Speed_',filename(1:end-4),num2str(group_no),'_',num2str(side_var)','.xls'];
xlswrite(vel_file_name,aver_vel');
end


