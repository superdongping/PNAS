% This is the main program to plot the open field traces and quantify the total distance traveled during 15 min open field test.
% The representative figures Fig 4A-B, Fig 6F is plotted by this program.
% This tracing method is based on the subtraction of the image from the
% video which contain the mouse with the background before the mouse is
% placed in the open field.
% Please note that the open field box is white and the fur of the mouse is
% black, which is darker than the backgroud.
% Please cite as Dong, P. et al. Neuronal mechanism of a BK channelopathy in absence epilepsy and dyskineisa. PNAS (2022).
% If you have any question, please contact Ping Dong via
% superdongping@gmail.com or ping.dong@duke.edu

clc;
clear all;
close all;

moviefile=dir('*.mp4'); % load the video files
start_time_begin=0.5;

% analyze left or right side in the open field
side_var=0; % 0 means left side
for i=1:size(moviefile,1)
% for i=[1]
moviepath=moviefile(i).name;

% % total time is 15 min, separate into 5 min per group, 3 group in total

duration_time=15;
for group_no=1:1
    start_time=start_time_begin+duration_time*(group_no-1);
    [c_pos_sum,a_x,a_y,a_w,a_h]=Mice_trajectory(moviepath,start_time,duration_time,group_no,side_var);
    c_pos_filename=[moviepath,'_position_', num2str(group_no),'_',num2str(side_var),'.xls'];
    xlswrite(c_pos_filename, c_pos_sum);    
end
Mice_trace_plot
end

%%
% analyze left or right side in the open field
side_var=1; % 1 means right side


for i=1:size(moviefile,1)
moviepath=moviefile(i).name;
% % total time is 15 min, separate into 5 min per group, 3 group in total
duration_time=15;
for group_no=1:1
    start_time=start_time_begin+duration_time*(group_no-1);
    [c_pos_sum,a_x,a_y,a_w,a_h]=Mice_trajectory(moviepath,start_time,duration_time,group_no,side_var);
    c_pos_filename=[moviepath,'_position_', num2str(group_no),'_',num2str(side_var),'.xls'];
    xlswrite(c_pos_filename, c_pos_sum);    
end
Mice_trace_plot
end



