%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROGRAM:
% Park_Synthetic_Function.m
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
% Program Park_Synthetic_Function.m is a Matlab function to create synthetic
% seismogram
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Input:
% S            % Source to first sensor distance
% dx           % Sensor spacing
% T            % duration time taken (Time shouldnt exceed recording duration)
% M            % No of sensor
% Fs           % Sampling rate
% dk           % Phase delay
% m            % No of modes (3 mode or 7 modes)
% Xk           % Location of the k-th source
% Q            % Quality factor
%
% Output:
% Data         % Synthetic seismograph data
%
% DEPENDENCIES
%              % curve_fitting_1.m
%  READS
%       'RV_1.txt' and 'RV_A.txt'
%                 or 
%   'Vel_Vs_Fre_7Mode.txt' and 'Amp_Vs_Fre_7Mode.txt'               
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                ########### This is a Function   ###############
%%
function[Data]=Park_Synthetic_Function(S,dx,T,M,Fs,dk,m,Xk,Q)

%% Intial Calculation
if (m==3)      % If number of mode is 3
    Vel=readmatrix('RV_1.txt');Amp=readmatrix('RV_A.txt');             
elseif (m==7)  % If number of mode is 7    
    Vel=readmatrix('Vel_Vs_Fre_7Mode.txt');Amp=readmatrix('Amp_Vs_Fre_7Mode.txt');          
end

df1=1/T;                          % Desired frequency resolution
d1=min(Vel);d2=max(Vel);          % Frequency and corrosponding velocity for different modes
l1=length(d1);l1=1:2:l1;          % Generate indices for min frequency of each mode 
f_01=(ceil(d1(l1)/df1))*df1;      % f_01= Min frequency of each mode compatible with df1 resolution;
f_02=(floor(d2(l1)/df1))*df1;     % f_02=Max frequency for each mode compatible with df1 resolution;
df=Vel(2,1)-Vel(1,1);             % Frquency Resolution of the input data 

Fmax=(Fs/2);Fmaxin=max(f_02);     % Compare the input maximum frequency with input text file max frequency
 if (Fmax<Fmaxin)
     f_02(:)=Fmax;
 else
     disp(" Input data's maximum frequency is less than the input fmax value") 
 end

                          %% User input of frequency resolution (For dispersion image)
%% Use smooth spline interpolation to increase the frequency resolution of input data
  
    
    n0_1=floor(max(f_02-f_01)/df1+1);    %% Determine the length of the longest input mode after spline interpolation (df1 resolution)
    n0_2=round((d2(l1)/df-d1(l1)/df)+1); %% calculate the length of each mode for original input frequency (df resolution)
    Vel_1=zeros(n0_1,m*2);               %% Assign memory for new velocity file  with df1 resolution
    Amp_1=zeros(n0_1,m*2);               %% Assign memory for new amplitude file  with df1 resolution 
    
    %% Loops to create smooth spline interpolated data with df1 resolution for all the modes
    for i1=1:m
        nk=n0_2(i1);
        fmin=f_01(i1);fmax=f_02(i1);        
        a1=Vel(1:nk,(i1-1)*2+1);b1=Vel(1:nk,i1*2);   % Extract frequency and corresponding velocity value from input data for i1th mode     
        a2=Amp(1:nk,(i1-1)*2+1);b2=Amp(1:nk,i1*2);   % Extract frequency and corresponding amplitude value from input data for i1th mode  
       
        %% Smooth Spline Interpolation for velocity
        C1=[];
        [xData, yData] = prepareCurveData( a1, b1 );
        ft = fittype( 'smoothingspline' );
        [fitresult1, gof] = fit( xData, yData, ft );
        sp1=fmin:df1:fmax;
        rp1=feval(fitresult1,sp1);
        C1(:,1)=sp1;C1(:,2)=rp1;

        
        %% Smooth Spline Interpolation for amplitude
        
        C2=[];
        [xData, yData] = prepareCurveData( a2, b2 );
        ft = fittype( 'smoothingspline' );
        [fitresult2, gof] = fit( xData, yData, ft );
        rp1=feval(fitresult2,sp1);
        C2(:,1)=sp1;C2(:,2)=rp1;
        %% Storing the data in a matrix
        
        n0(i1)=length(C1);          
        Vel_1(1:n0(i1),(i1-1)*2+1:i1*2)=C1;
        
        n01(i1)=length(C2);          
        Amp_1(1:n01(i1),(i1-1)*2+1:i1*2)=C2;
        
        
    end    
    
    Vel=Vel_1;Amp=Amp_1;             % New Velocity and amplitude as per required resolution  
    clear Vel_1 Amp_1        

%% Perform Park's Synthetic Signal Generation Procedure

for i1=1:M
    xi=S+(i1-1)*dx;
    l_ik=sqrt((xi-Xk)^2);
    
    R1=zeros(m,T*Fs);
        
    for i2=1:m
        n11=n0(i2);
        ak=Amp(1:n11,(i2*2));
        
        C_wm=Vel(1:n11,(i2*2));
        w=Vel(1:n11,(i2*2-1)).*(2*pi);
        
        S_km=ak.*exp(-1i*(w+dk));
        
        alpha=w./(C_wm*Q);              
        A_km=exp(alpha*l_ik)./l_ik;     
        
        P_km=exp((1i*l_ik*w)./(C_wm));        
        R_km=(A_km.*P_km).*S_km;        
        
        f_1=f_01(i2);f_2=f_02(i2);
        R1(i2,(f_1*T):(f_2*T))=R_km;
        R1(i2,:)=flip(R1(i2,:));
    end
    
    R0=zeros(1,T*Fs);
    %% Stacking the contribution of all the modes
    for i3=1:m
         R0=R0+R1(i3,:);
    end
    
    R2(:,i1)=ifft(R0);  %% Performing inverse Fourier  transform to generate synthetic data
   
end

 Data=real(R2);         %% Deleting imaginary part

%%  Bringing High Amplitude Part In Front

if (T>2)
    
    Data=circshift(Data,2*Fs+1);
end
%%

   