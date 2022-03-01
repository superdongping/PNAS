figure(100)
hFig = figure(100);
set(hFig, 'Position', [40 40 451 150]);

video_motion_idx_ori=xlsread('02 2019-07-26 04_2637_HET_trial3_motion_idx.xlsx');
% change motion to abs motion change
video_motion_idx=zeros(length(video_motion_idx_ori),1);
video_motion_idx(1)=0;

for i=1:length(video_motion_idx_ori)-1
    video_motion_idx(i+1)=abs(video_motion_idx_ori(i+1)-video_motion_idx_ori(i));
end


subplot(2,1,1)
plot(x_time(start_t*sample_hz+1:end_t*sample_hz),EEG1(start_t*sample_hz+1:end_t*sample_hz))
ylabel('EEG1 (uV)')
axis([start_t end_t -500 500])
% axis off;

% subplot(5,1,2)
% plot(x_time(start_t*sample_hz+1:end_t*sample_hz),EEG2(start_t*sample_hz+1:end_t*sample_hz))
% ylabel('EEG2 (uV)')
% axis([start_t end_t -500 500])
% axis off;
% 
% subplot(5,1,3)
% plot(x_time(start_t*sample_hz+1:end_t*sample_hz),EMG(start_t*sample_hz+1:end_t*sample_hz))
% ylabel('EMG (uV)')
% axis([start_t end_t -500 500])
% axis off;
% 
% subplot(5,1,4)
% plot(x_time(start_t*sample_hz+1:end_t*sample_hz),Vibration(start_t*sample_hz+1:end_t*sample_hz))
% xlabel('Time(s)')
% ylabel('Vibration')
% axis([start_t end_t -3.5 -2.6])
% axis off;

subplot(2,1,2)
plot(video_motion_idx(start_t:end_t))

xlabel('Time(s)')
ylabel('Motion index')
axis([0 duration_t-1 0 1500])
% axis off;