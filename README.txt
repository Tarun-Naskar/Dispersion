########################## The MASW DISPERSION IMAGING package ###########################

A set of 6 Matlab scripts and 4 functions to generate the Rayleigh-wave phase velocity
dispersion graph from any experimental/synthetic data

Below are descriptions for the scripts, the functions, and the examples.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SCRIPTS  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Synthetic_Example:       no reads 
                         no write
                         calls "Park_Synthetic_Function.m"

Example_Site_1:          reads "Site_1.csv" 
                         no write
                         calls none

Example_Site_2:          reads "Site_2.csv" 
                         no write
                         calls none

W_C_Transform:           reads "Data_File_1.csv" 
                         no write
                         calls "W_C_Transform_Function.m"

W_K_Transform:           reads "Data_File_1.csv"
                         no write
                         calls "W_K_Transform_Function.m"

Tau_P_Transform:         reads "Data_File_1.csv"
                         no write
                         calls "Tau_P_Transform_Function.m"

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   FUNCTIONS  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Park_Synthetic_Function:   INPUT

                           S       Source to first sensor distance
                           dx      Sensor spacing
                           T       duration time taken (Time shouldnt exceed recording duration)
                           M       No of sensor
                           Fs      Sampling rate
                           dk      Phase delay
                           m       No of modes (3 mode or 7 modes)
                           Xk      Location of the k-th source
                           Q       Quality factor
                                                                               

                         OUTPUT
                           Data         Synthetic seismograph data 
                                
                         
                        DEPENDENCIES
                           none

                        READS
                           'RV_1.xlsx' and 'RV_A.xlsx'
                            or 
                            'Vel_Vs_Fre_7Mode.xlsx' and 'Amp_Vs_Fre_7Mode.xlsx'

W_C_Transform_Function:       INPUT
                          
                           Data    seismograph data
                           T       time duration of the recorded signal
                           f       Frequency resolution (Hz)
                           fmin    Minimum and maximum Frequency of velocity spectra
                           fmax    Minimum and maximum Frequency of velocity spectra
		           M       No of geophone
                           dx      Sensor spacing in meters                           
                           V       Resolution of  velocity spectra
                                                         

                         OUTPUT
                           C     Phase Velocity Spectra Matrix 
                                
                         
                        DEPENDENCIES
                           none

W_K_Transform_Function:   INPUT
                          
                          Data    seismograph data
                          f       Frequency resolution (Hz)
                          fmin    Minimum and maximum Frequency of velocity spectra
                          fmax    Minimum and maximum Frequency of velocity spectra
                          dx      Sensor spacing in meters
                          Lambda  Zero padding
                        

                         OUTPUT
                           X     x-axis Mesh Grid
                           Y     y-axis Mesh Grid
                           C     Velocity Spectra Matrix 
                                
                         
                        DEPENDENCIES
                           none

Tau_P_Transform_Function:  INPUT
                           
                           Data    Seismograph data
                           T       time duration of the recorded signal
                           t       time resolution of the recorded signal
                           fmin    Minimum and maximum Frequency of velocity spectra
                           Fmax    Minimum and maximum Frequency of velocity spectra
                           M       No of geophone
                           dx      Sensor spacing in meters
                           Vmin    Minimum value of the velocity spectra
                           Vmax    Maximum value of the velocity spectra 
                           dv      velocity Step size 
                           
                        

                         OUTPUT
                           X     X-axis mesh grid for velocity spectra
                           Y     Y-axis mesh grid for velocity spectra
                           C     Velocity Spectra Matrix 
                                
                         
                        DEPENDENCIES
                           none                    

%%%%%%%%%%%%%%%%%%%%%%%%    The codes  read the following .csv files %%%%%%%%%%%%%%%%%%%%%%%%

RV_1.xlsx               Velocity  Profile corrosponds to Figurew 1b (first 3 modes only)
RV_A.xlsx               Amplitude corrosponds to Figure 2

Vel_Vs_Fre_7Mode.xlsx   Velocity  Profile corrosponds to Fig 1b (7 modes) 
Amp_Vs_Fre_7Mode.xlsx   Unit amplitude corrosponds to file Vel_Vs_Fre_7Mode.xlsx

Site_1.csv:             Raw MASW data file for Site 1 with 8k sampling rate
Site_2.csv:             Raw MASW data file for Site 2 with 48k sampling rate


%%%%%%%%%%%%%%%%%%%%%%%%                  EXAMPLES                 %%%%%%%%%%%%%%%%%%%%%%%%%%
 
Place all 11 scripts and 5 functions into the same directory. 

For the synthetic data example, execute the 
following scripts in order

>> Synthetic_Example
>> W_C_Transform/W_K_Transform/Tau_P_Transform

This generates Figures 2,3,4,5,6,7,8 and 9 in the paper.


For the Field data example of site -1, execute the 
following scripts in order

>> Example_Site_1
>> W_C_Transform/W_K_Transform/Tau_P_Transform

This generates Figure 10 in the paper.

For the Field data example of site -2, execute the 
following scripts in order

>> Example_Site_2
>> W_C_Transform/W_K_Transform/Tau_P_Transform

This generates Figure 11 in the paper.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            ***        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%