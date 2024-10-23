%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROGRAM:
% W_C_Transform_Function.m
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
% Program W_C_Transform_Function.m is a Matlab function to perform W-C
% Transform of seismogram data
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Input:
%                           
% Data    seismograph data
% f       Frequency resolution (Hz)
% fmin    Minimum and maximum Frequency of velocity spectra
% fmax    Minimum and maximum Frequency of velocity spectra
% M       No of geophone
% dx      Sensor spacing in meters                           
% V       Resolution of  velocity spectra
% N       Total time data points for single traces
%                                                          
% OUTPUT
% C     Phase Velocity Spectra Matrix 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                ########### This is a Function   ###############
%%
function[C]=W_C_Transform_Function(Data,f,fmin,fmax,M,dx,V,N) 

lk_1=find(f>=fmin,1);
lk_2=find(f>=fmax,1);

Data3=fftshift(fft(Data,N),1);    % Performing  Fourier transform on data
Data3=Data3(lk_1:lk_2,:);         % Truncating frequency beyond the requiered range
d1=abs(Data3);
Data3=Data3./d1;                  % Normalizing the data

f01=transpose(f(lk_1:lk_2));
f02=repmat(f01,1,M);

j1=1:M;   
l1=lk_2-lk_1+1;
phi1=dx*(j1-1)*2*pi;
phi2=repmat(phi1,l1,1);

l2=length(V);
C=zeros(l2,l1);

%% calculation of dispersion data
 i1=0;
for i=V        
    v1=i;i1=i1+1;
    phi=(phi2.*f02)./v1;          % Phase angle correspondng to each velocity and frequency
    Ex=exp(1i*phi);

    c1=(Data3.*Ex);
    C(i1,:)=sum(c1,2);
   
end

end
%%