%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROGRAM:
% W_C_Transform.m
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
% Program W_C_Transform.m is a Matlab script to generate dispersion image
% using W_C_Transform
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%                ########### This is a Script   ###############
%%

tic
[C]=W_C_Transform_Function(Data,f,fmin,fmax,M,dx,V,N); % Calls the function W_C_Transform_Function.m
toc

%%
lk_1=find(f>=fmin,1);
lk_2=find(f>=fmax,1);

C=abs(C);
fre=f(lk_1:lk_2);
[X,Y] = meshgrid(fre,V);

%% Plot

cl=max(max(C));C=C./cl;

figure();surf(X,Y,C,'EdgeColor','none')
set(gca,'YDir','normal');
ylim([Vmin Vmax])
xlim([fmin fmax])
colormap jet;
colorbar;
grid off
xlabel('Frequency (Hz)','fontweight','bold','fontsize',18);
ylabel('Phase Velocity (m/s)','fontweight','bold','fontsize',18);
title('w-c method','fontweight','bold','fontsize',18);
set(gca,'fontsize',16)
view([0 90])


%% W-C Transform 
