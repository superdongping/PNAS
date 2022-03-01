clc;
clear;
close;

xls_fileName=dir('*.xlsx');

for i=1:6
    xls_file=xls_fileName(i).name;
    ori_data=xlsread(xls_file);
    motion_idx=ori_data(:,1);
    
    figure(i)
    
    hFig = figure(i);
    set(hFig, 'Position', [40 40 960 540]);
    
    subplot(4,1,1)
    plot(motion_idx)
    ylabel('EEG1 (uV)')
    axis([1 3600 min(motion_idx) max(motion_idx)])
end