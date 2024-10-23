%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROGRAM:
% Validation_Dalmoro.m
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
% Program Validation_Dalmoro.m is a Matlab script to process field data 
% published by Dal Moro et al. (2003)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%                ########### This is a Script   ###############
%% Input 

clearvars; close all;warning off ; clc
Data1=readmatrix('dalmoro.txt');

S=5;                                  % Source to first sensor distance
dx=2;                                 % Sensor spacing in meters
T=1;                                  % duration time taken (Time shouldnt exceed recording duration)
fmin=0;fmax=30;                       % Minimum and maximum Frequency of velocity spectra
F_res=0.125; Ts=1/F_res;              % Frequency Resolution
Vmin=50;Vmax=350;dv=1;                % Resolution of  velocity spectra

Lambda=50;                            % Zero Padding (only for W-K method)
M=24;                                 % No of sensor
Fs=round(1/Data1(1,1));               % Sampling rate

Kmin=0; Kmax=0.2;                     % Only for requency vs Wavenumber plot 

Type=1;                               % The type of source and sensor placement. Source at front (1) or source at back(2) 

%% Initial Calculations
V=Vmin:dv:Vmax;                       % Velocity resolution
n2=size(Data1,2);                     % Number of traces+1(time)
t=Data1(:,1);                         % Extract the time from input data
n1=length(t);                         % time length

N=(1/F_res)*Fs;                       % Total number of time data per traces                  
f = 1*(-N/2:N/2-1);
f=f/N*(N-1)/((1/F_res)-(1/Fs));       % Desired frequency resolution
Data=zeros(n1,(n2-1));                % Assign memory

%%  Data Orientation & Plot

if (Type==1)
    
    for i1=1:(n2-1)  
        
        Data(:,i1)=Data1(1:(T*Fs),(i1+1));
        figure(1);hold on;plot(t,((Data(:,i1))./max(abs(Data(:,i1))))+i1*0.5);
        grid on
        
    end
    
elseif (Type==2)
        
     for i1=1:(n2-1)             
                            
        Data(:,i1)=Data1(1:(T*Fs),(n2-i1));
        figure(1);hold on;plot(t,((Data(:,i1))./max(abs(Data(:,i1))))+i1*0.5);
        grid on        
                    
    end
end

figure(1); hold on; xlabel('Time (sec)','fontweight','bold','fontsize',18);
ylabel('Offset (m)','fontweight','bold','fontsize',18);
title('Digitized Dalmoro Data ','fontweight','bold','fontsize',18);
set(gca,'fontsize',16)

clear Data1
%%

