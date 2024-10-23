%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROGRAM:
% Synthetic_Example.m
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
% Program Synthetic_Example.m is a Matlab script to make synthetic
% seismogram
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%                ########### This is a Script   ###############
%%
clearvars;clc ;close all;warning off ; clc
tic

%% INPUT

S=5;                       % Source to first sensor distance
X=46;                      % Sensor spread length 
T=4;                       % Duration time taken (Time shouldnt exceed recording duration of input data)
fmin=0;fmax=40;            % Minimum and maximum Frequency of velocity spectra                         

Vmin=1;Vmax=1000;dv=1;     % Resolution of  velocity spectra

Lambda=1;                  % Zero Padding (only for W-K method)    
M=96;                      % No of sensor 
Fs=1000;                   % Sampling rate
m=3;                       % No of modes (3 mode or 7 modes)

Kmin=0; Kmax=0;            % Only for requency vs Wavenumber plot 

%% Fixed Value
dk=0;                      % Phase delay
Xk=0;                      % Location of the k-th source
Q=100000;                  % Quality factor
%% Initial calculation
dx=X/(M-1);                % Sensor spacing in meters
t=0:(1/Fs):T-(1/Fs);       % Time resolution
V=Vmin:dv:Vmax;            % velocity resolution

N=T*Fs;                    % No of data per traces
f = 1*(-N/2:N/2-1);
f=f/N*(N-1)/(T-(1/Fs));    % Desired frequency resolution
%% Generation Of Synthetic Data

[Data]=Park_Synthetic_Function(S,dx,T,M,Fs,dk,m,Xk,Q);

%% Plot
   
    for i1=1:M
        
        
        figure(1);hold on;plot(t,((Data(:,i1))./max(abs(Data(:,i1))))*dx+S+(i1-1)*dx);      
        
        grid on
        
    end
    
figure(1); hold on; xlabel('Time (sec)','fontweight','bold','fontsize',18);
ylabel('Offset (m)','fontweight','bold','fontsize',18);
title('Synthetic Seismogram','fontweight','bold','fontsize',18);
set(gca,'fontsize',16)

%%