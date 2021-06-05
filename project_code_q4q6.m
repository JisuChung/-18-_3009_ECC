% 2019 Fall - Communications Lab. Project
% Prepared by Prof. Hyunggon Park
% Multiagent Communications and Networking Lab.
% Dept. of Electronic and Electrical Engineering
% Ewha Womans University

clear all
close all

% Generation of 10 PN sequences with different shifts
% 
PN_max=10;
tmp=[];
for kk=1:PN_max
    h = commsrc.pn('Shift',kk);
    set(h,'NumBitsOut',100);
    tmp=generate(h)*2-1;
    PN_seq(kk,:)=tmp';
end

% Parameters for oroginal data
row = 100;  % row size of image matrix
col = 100;  % column size of image matrix 


load('encoded_data.mat'); %variable name: mod_data



% Decoding - You should write your codes for decoding 








% you may use several built-in MATLAB functions such as 
% subplot, imshow, axis, etc. 

