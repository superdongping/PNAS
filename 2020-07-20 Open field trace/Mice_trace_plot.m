% for left
a_xLeft=53;
a_xRight=319;
a_yUp=47;
a_yDown=313;
a_x=53;
a_y=47;
a_w=265;
a_h=266;




filename=moviepath;
first_analysis_frame=60*24*(start_time+0);
idx=first_analysis_frame+24*60*duration_time; % analysis for 5 min
E_M_movie = VideoReader(moviepath,'Tag','My reader object');
mov(idx).cdata = read(E_M_movie,idx);
input_frame = mov(idx).cdata;

figure(02);
imshow(input_frame);
hold on;
%     plot the central point and the trajectory of the mouse
rectangle('Position',[a_x,a_y,a_w,a_h],'EdgeColor','k','LineWidth',2);
%     plot(mice_x,mice_y, 'g+', 'MarkerSize', 10);
plot(c_pos_sum(:,1),c_pos_sum(:,2),'r','LineWidth',2);

trace_fig_name=['trace_',filename(1:end-4),num2str(group_no),'_',num2str(side_var)];
saveas(gcf,trace_fig_name,'tif');