% This is the main program to analyze the videos from the EEG recording.
% The analysis of total movement in the Fig S2 is done by this program.
% Please cite as Dong, P. et al. Neuronal mechanism of a BK channelopathy in absence epilepsy and dyskineisa. PNAS (2022).
% If you have any question, please contact Ping Dong via
% superdongping@gmail.com or ping.dong@duke.edu
clc;
clear;
close all;

moviefile=dir('*.mp4'); % load the video files

movie_start_time_aline=[128,132,128]; % the EEG recording start time
frame_rate=24;
analysis_interval=1; % down sample the video analyzed interval to 1 second
first_frame=round(movie_start_time_aline*24); 
duration_time=1200; % 20 min = 1200s

% Load the video to the matlab program

for i=1:1
moviepath=moviefile(i).name;
Video_base_motion_test(moviepath,first_frame(i),duration_time,analysis_interval,frame_rate);
end