%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROGRAM:
% Tau_p_Transform_Function.m
%
% PROGRAMMERS:
% XXXXXXXXXXXXXXXXX
%
% Last revision date:
% 08/05/2021
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
% Program Tau_p_Transform_Function.m is a Matlab function to perform Tau-p
% Transform of seismogram data
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Input:
%                           
% Data    seismograph data
% T       time duration of the recorded signal
% t       time resolution of the recorded signal
% fmin    Minimum and maximum Frequency of velocity spectra
% fmax    Minimum and maximum Frequency of velocity spectra
% M       No of geophone
% dx      Sensor spacing in meters                           
% Vmin    Minimum value of the velocity spectra
% Vmax    Maximum value of the velocity spectra 
% dv      velocity Step size  
%                                                          
% OUTPUT
% X     x-axis Mesh Grid
% Y     y-axis Mesh Grid
% C     Phase Velocity Spectra Matrix 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                ########### This is a Function   ###############
%%

function[X,Y,C]=Tau_P_Transform_Function(Data,T,t,f,fmin,fmax,M,dx,Vmin,Vmax,dv,N)

dt=t(2)-t(1);                         %% Sampling Rate                     

V1=Vmin:dv:Vmax;                      %% The velocity resolution of dispersion graph
P1=flip(((dx./V1)./dt));              %% Corresponding slant line index 

n1=round(T/dt);n2=length(P1);         %% n1= Total no of point in time; n2= Total no of velocity

%% In this section, Tau-p stacking is performed

i3_1=0:1:(M-1);i3_2=repmat(i3_1,n2,1);     %% n2= no of velocity, M= geophone; i3_2=[0 1 2 3....M;0 1 2 3....M;.....]
i2_1=repmat(transpose(P1),1,M);            %% P1=Time taken (index) to travel dx for all velocity, repeating M times ; i2_1=[t1 t1 t2.....;t2 t2 t2....;.....]
I1_1=i2_1.*i3_2;                           %% Calculates the arrival velocity(index) for all waves then just repeat (not calculate) it for all sensor (size = no of velocity x no of sensor)


n1_1=size(Data,1);
i3_3=0:1:(M-1);                            %% As source position is unknown, the "zero" negates the P1 value for first sensor
i3_3=i3_3*n1_1;                            %% No of each sensor x length of data [ Ex if M=24, n1_1=52k, i3_3=0, 52k, 104k.....]

i3_4=repmat(i3_3,n2,1);
I1_2=round(I1_1+i3_4);                     %% Calculates the arrival velocity(index) for all waves and for each sensor; (*)This is done to make index from matrix to vector

U1=zeros(n1,n2);

for i1=1:n1                               %% In this time length loop, each loop calculates and slant stack the data for all velocities

    Da_1=zeros(n2,M);
    I1=I1_2+i1;
    n10=find(I1<=n1*M);n11=I1(n10);       %% Identify index beyond time limit & delete them
    
    Da_1(n10)=Data(n11);                  %% This operation by default convert index from matrix to array (*)
    U1(i1,:)=(sum(Da_1,2));
end


K=fft(U1,N,1);     %% Perform Fourier transform
P1=(P1.*dt)./dx;    %% calculate the slowness value 
K=transpose(abs(abs(fftshift(K,1))));
clear U1 Data
%% Prepare the axis for 2D plot
lk_1=find(f>=fmin,1);
lk_2=find(f>=fmax,1);

f_2=f(lk_1:lk_2);
lk_10=length(P1);

[X,Y1] = meshgrid(f_2,P1);    %% Create 1D to 2D meshgrid
C=K(1:lk_10,lk_1:lk_2);       %% Truncate unnessesary value

cl2=max(max(C));
C=C./cl2;                  %% Normalize the data
clear K
%%
n1=length(f_2);
n2=length(P1);

Y=zeros(n2,n1);
for i1=1:n1
    for i2=1:n2
        Y(i2,i1)=1/Y1(i2);    %% Convert slowness to velocity
    end
end

%% Tau-P Transform 
