clc;
clear;
close;

moviefile=dir('*.mp4'); % load the video files
% for i=1:size(moviefile,1)
for i=1:1
    moviepath=moviefile(i).name;
   
% % total time is 60min, separate into 15min per group
% % c_pos_sum=Mice_trajectory(movie_input_filename,start_time,duration_time,group_no)
% %
    c_pos_sum=Mice_trajectory(moviepath,1,15,1);
    xlswrite('mice_position1.xlsx', c_pos_sum);
    
    c_pos_sum=Mice_trajectory(moviepath,16,15,2);
    xlswrite('mice_position2.xlsx', c_pos_sum);
    
    c_pos_sum=Mice_trajectory(moviepath,31,15,3);
    xlswrite('mice_position3.xlsx', c_pos_sum);
    
    c_pos_sum=Mice_trajectory(moviepath,46,15,4);
    xlswrite('mice_position4.xlsx', c_pos_sum);   
end

