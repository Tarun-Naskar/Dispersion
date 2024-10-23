%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROGRAM:
% Tau_P_Transform.m
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
% Program Tau_P_Transform.m is a Matlab script to generate dispersion image
% using Tau_P_Transform
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%                ########### This is a Script   ###############
%%
tic

 [X,Y,C]=Tau_P_Transform_Function(Data,T,t,f,fmin,fmax,M,dx,Vmin,Vmax,dv,N); % call the function Tau_P_Transform_Function.m
        
toc

%% Plot

figure();surf(X,Y,C,'EdgeColor','none')
ylim([Vmin Vmax])
xlim([fmin fmax])
set(gca,'YDir','normal');
colormap jet;
colorbar;
grid off
xlabel('Frequency (Hz)','fontweight','bold','fontsize',18);
ylabel('Phase Velocity (m/s)','fontweight','bold','fontsize',18);
%title('Tau-p method','fontweight','bold','fontsize',18);
set(gca,'fontsize',16)
view([0 90])
%% Tau-P Transform  






