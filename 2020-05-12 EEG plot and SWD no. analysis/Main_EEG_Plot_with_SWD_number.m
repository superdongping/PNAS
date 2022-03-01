% This is the main program to plot the raw EEG recording traces and count the SWD number in the absence seizure mouse models.
% The representative figures Fig 1C-F, Fig 3G-H is plotted by this program.
% Please cite as Dong, P. et al. Neuronal mechanism of a BK channelopathy in absence epilepsy and dyskineisa. PNAS (2022).
% If you have any question, please contact Ping Dong via
% superdongping@gmail.com or ping.dong@duke.edu

clc;
clear all;
close all;

% Load the data from the xls files recorded from the NI acquisition board
xlsfile=dir('*.xlsx');
xlsfile_number=size(xlsfile,1);
% transform the analog data (V) to the real EEG/EMG unit (uV),
% 1V=1,000,000uV, gain is 5000x, transform index is,1,000,000/5000=200
analog_output_offset=2.048;
transform_index=200;

% time selection data
start_t=1;
end_t=3599;

duration_t=end_t-start_t+1;
sample_hz=100;
SWD_bin_time=300; % bin the SWD event data into 5 min

EEG_power_sum=[];

SWD_event_num_sum=[];
SWD_event_time_sum=[];
SWD_no_bin_sum=[];
threshold=600;


for i=1:xlsfile_number
% for i=[3]
    xls_file=xlsfile(i).name;
    ori_data=xlsread(xls_file);
    x_time=ori_data(:,1);
    
    EEG1=(ori_data(:,2)-analog_output_offset)*transform_index;
    EEG2=(ori_data(:,4)-analog_output_offset)*transform_index;
    EMG=(ori_data(:,6)-analog_output_offset)*transform_index;
    Vibration=ori_data(:,8);
    
    figure(i)
    hFig = figure(i);
    set(hFig, 'Position', [40 40 380 400]);
    
    subplot(4,1,1)
    plot(x_time(start_t*sample_hz+1:end_t*sample_hz),EEG1(start_t*sample_hz+1:end_t*sample_hz))
    ylabel('EEG1 (uV)')
    axis([start_t end_t -500 500])
    
    
    %     axis off;
    
    subplot(4,1,2)
    plot(x_time(start_t*sample_hz+1:end_t*sample_hz),EEG2(start_t*sample_hz+1:end_t*sample_hz))
    ylabel('EEG2 (uV)')
    axis([start_t end_t -500 500])
    %     axis off;
    
    subplot(4,1,3)
    plot(x_time(start_t*sample_hz+1:end_t*sample_hz),EMG(start_t*sample_hz+1:end_t*sample_hz))
    ylabel('EMG (uV)')
    axis([start_t end_t -500 500])
    %     axis off;
    
    subplot(4,1,4)
    plot(x_time(start_t*sample_hz+1:end_t*sample_hz),Vibration(start_t*sample_hz+1:end_t*sample_hz))
    xlabel('Time(s)')
    ylabel('Vibration')
    axis([start_t end_t -3.5 -2.6])
    %     axis off;
    
    figure (10+i)
    hFig = figure(10+i);
    set(hFig, 'Position', [40 40 450 90]);
    %
    [P,EEG_power]=EEG_freq_analysis(EEG2(start_t*sample_hz:end_t*sample_hz-1),start_t,end_t);
    EEG_power_sum=[EEG_power_sum EEG_power];
    
    % statics of SWD event
    hFig70=figure (70+i);
    set(hFig70, 'Position', [40 40 450 90]);
    [SWD_no_output,SWD_event_time]=SWD_no_detect(P,duration_t-1,threshold);
    
    % set the bin time
    edges=start_t-1:SWD_bin_time:end_t+1;
    SWD_no_bin=histcounts(SWD_event_time,edges); % SWD number per bin time
    SWD_no_bin_sum=[SWD_no_bin_sum; SWD_no_bin]; % summary the SWD number per bin time
        
    SWD_event_num_sum=[SWD_event_num_sum SWD_no_output]; % summary the SWD episole
    
    SWD_event_num_sum_per_hour=SWD_event_num_sum/((duration_t-1)/3600);
    
    SWD_duration_output=SWD_duration_detect(P,threshold);
    SWD_event_time_sum=[SWD_event_time_sum SWD_duration_output]; % summary the SWD total time
    SWD_event_time_sum_per_hour=SWD_event_time_sum/((duration_t-1)/3600);

end

xlswrite('EEG_power_freq_sum.xls',EEG_power_sum)