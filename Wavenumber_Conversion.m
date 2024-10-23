%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROGRAM:
% Wavenumber_Conversion.m
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
% Program Wavenumber_Conversion.m is a Matlab script to generate
% Frequency Vs Wavenumber dispersion image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%                ########### This is a Script   ###############

%% Wavenumber Conversion
Y=X./(Y);         % Converts Phase velocity to Wavenumber (1/distance)

%% Plot

figure();surf(X,Y,C,'EdgeColor','none')
ylim([Kmin Kmax])
xlim([fmin fmax])
set(gca,'YDir','normal');
colormap jet;
colorbar;
grid off
xlabel('Frequency (Hz)','fontweight','bold','fontsize',18);
ylabel('Wave Number (1/m)','fontweight','bold','fontsize',18);
title('Frequency Vs Wavenumber Image','fontweight','bold','fontsize',18);
set(gca,'fontsize',16)
view([0 90])
%%
