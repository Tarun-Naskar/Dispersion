%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROGRAM:
% W_K_Transform_Function.m
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
% Program W_K_Transform_Function.m is a Matlab function to perform W-K
% Transform of seismogram data
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Input:
%                           
% Data    seismograph data
% f       Frequency resolution (Hz)
% fmin    Minimum Frequency of velocity spectra
% fmax    Maximum Frequency of velocity spectra
% Vmin    Minimum velocity 
% Vmax    Maximum Velocity
% dx      Sensor spacing in meters                           
% Lambda  Zero Padding
% N       No of required time data per traces
%                                                          
% OUTPUT
% X     x-axis Mesh Grid
% Y     y-axis Mesh Grid
% C     Phase Velocity Spectra Matrix 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                ########### This is a Function   ###############
%%
function[X,Y,C]=W_K_Transform_Function(Data,f,fmin,fmax,Vmin,Vmax,dx,Lambda,N)


n1=Lambda*size(Data,2);
Data=fftshift(fft2(Data,N,n1),1);           % Performs 2D fourier transform on field/synthetic data
Data=abs(abs(transpose(Data)));             

x1=dx:dx:n1*dx;                             % Creates the offset array
k1 = 1*(0:n1-1);
k1=k1/n1*(length(x1)-1)/(max(x1)-min(x1));  % Calculates the wavenumbers
k1=flip(k1);                                % Flip the wavenumber to bring largest wavenumbers at front

%% Truncating wavenumbers beyond the required range

kmin=abs(f(2)-f(1))/Vmax;
kmax=fmax/Vmin;kmax1=max(k1);

if(kmax>kmax1)
    lk_1=find(k1<=kmin,1);
    k1=k1(1:lk_1);
    lk=1;
else
    lk_1=find(k1<=kmin,1);lk_2=find(k1<=kmax,1);
    k1=k1(lk_2:lk_1);
    lk=lk_2;
end

%% Truncating frequencies and dispersion data beyond the required range

lf_1=find(f>=fmin,1);lf_2=find(f>=fmax,1);
f_1=f(lf_1:lf_2);

C=Data(lk:lk_1,lf_1:lf_2);  %% Truncating the dispersion data
cmax=max(max(abs(C)));
C=C./cmax;                  %% Normalizing the dispersion data

%% Prepare the axis  for final plot

[X,Y1] = meshgrid(f_1,k1);           % Prepare frquency and wavenumber axis for 2D plot 

n1=length(f_1);
n2=length(k1);

Y=zeros(n2,n1);
for i1=1:n1
    for i2=1:n2
             
        Y(i2,i1)=f_1(i1)/Y1(i2,i1);  % Converting wavenumber to velocity
    end
end

%% W-K Transform 


