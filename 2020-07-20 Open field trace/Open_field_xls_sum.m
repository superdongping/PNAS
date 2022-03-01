% open field summary 5 min
warning off;
clc;
close all;
clear all;


% Read all data from folder
my_file = dir('*.xls');
len = length(my_file);
output=[];
% output=zeros(len,3);
for i=1:len
    raw_data=xlsread(my_file(i).name);
    segment1=sum(raw_data(1:300));
    segment2=sum(raw_data(301:600));
    segment3=sum(raw_data(601:end));
    tmp=[segment1 segment2 segment3];
    output=[output;tmp];
end