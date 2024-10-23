%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROGRAM:
% Frequency_Normalized_Graph.m
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
% Program Frequency_Normalized_Graph.m is a Matlab script to generate
% frequency wise amplitude normalizeddispersion image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%                ########### This is a Script   ###############
%% Input
ymin=Vmin;ymax=Vmax; %% Set Y axis for dispersion image (use wave number for vs f )
xmin=fmin;xmax=fmax; %% Set X axis for dispersion image 

%% Normalization
n1=size(C,2);n2=size(C,1);
Cmax=max(abs(C));              % Find aboulute maximum amplitude for each frequency
C_normalized=zeros(n2,n1);     % Assign memory 

for i1=1:n1    
    C_normalized(:,i1)=C(:,i1)/Cmax(i1);   % Normalize the amplitude for each frequency   
end

%% Plot

figure();surf(X,Y,C_normalized,'EdgeColor','none')
ylim([ymin ymax])
xlim([xmin xmax])
set(gca,'YDir','normal');
colormap jet;
colorbar;
grid off
xlabel('Frequency (Hz)','fontweight','bold','fontsize',18);
ylabel('Phase Velocity (m/s)','fontweight','bold','fontsize',18);
%ylabel('Wave Number (1/m)','fontweight','bold','fontsize',18);     %% Use this line  for wavenumber vs frequency plot
title('Frequnecy Wise Normalize Amplitude','fontweight','bold','fontsize',18);
set(gca,'fontsize',16)
view([0 90])
%%