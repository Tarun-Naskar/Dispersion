%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROGRAM:
% Example_Site_1.m
%
% PROGRAMMERS:
% XXXXXXXXXXXXXXXXX
%
% Last revision date:
% 07/12/2020
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This code is distributed as part of the source-code package for DISPERSION
%                   
% % Use of this code is subject to acceptance of the terms and conditions
% that can be found at http://software.seg.org/disclaimer.txt 
% Copyright 2020 by The Society of Exploration Geophysicists (SEG)
% Reference:
%   XXXXXXXXXXXXXXXX
% 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Program Example_Site_1.m is a Matlab script to process field data from
% Site-1
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%                ########### This is a Script   ###############
%%

clearvars; close all;warning off ; clc
tic

Data1=readmatrix('Site_1.txt');

S=2.5;                                  % Source to first sensor distance
dx=0.5;                                 % Sensor spacing in meters
T=2;                                    % duration time taken (Time shouldnt exceed recording duration)
F_res=1/T;                              % Frequency Resolution
fmin=20;fmax=140;                       % Minimum and maximum Frequency of velocity spectra
Vmin=100;Vmax=500;dv=1;                 % Resolution of  velocity spectra

Lambda=50;                               % Zero Padding (only for W-K method)
M=48;                                   % No of sensor

Type=1;                                 % The type of source and sensor placement. Source at front (1) or source at back(2) 

%%

V=Vmin:dv:Vmax;

Fs=round((1/Data1(9,2))*1000);          % Sampling Rate; Fs=round((1/Data1(9,2))*1000)=8000
n2=size(Data1,2);n1=length(Data1);

Data1=Data1(20:n1,2:n2);
Data1(:,1)=Data1(:,1)./Fs;              % Converting data indices to time
t=Data1(:,1);
t=t(1:T*Fs);
n1=length(t);

N=(1/F_res)*Fs;
f = 1*(-N/2:N/2-1);
f=f/N*(N-1)/((1/F_res)-(1/Fs));         % Frequency resolution

Data=zeros(n1,(n2-2));
%%  Data Orientation & Plot

if (Type==1)
    
    for i1=1:(n2-2)  
        
        Data(:,i1)=Data1(1:(T*Fs),(i1+1));
        figure(1);hold on;plot(t,((Data(:,i1))./max(abs(Data(:,i1))))+i1*0.5);
        grid on
        
    end
    
elseif (Type==2)
        
     for i1=1:(n2-2)             
                            
        Data(:,i1)=Data1(1:(T*Fs),(n2-i1));
        figure(1);hold on;plot(t,((Data(:,i1))./max(abs(Data(:,i1))))+i1*0.5);
        grid on        
                    
    end
end

figure(1); hold on; xlabel('Time (sec)','fontweight','bold','fontsize',18);
ylabel('Signal','fontweight','bold','fontsize',18);
title('Site-1 Field Data ','fontweight','bold','fontsize',18);
set(gca,'fontsize',16)

clear Data1
%%