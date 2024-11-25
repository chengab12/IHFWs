*************************************System requirements**************************************************************************************
This program has been successfully run on Matlab2022 and can be run on any operating system that can install Matlab2022. 
Non-standard hardware is not required.
*************************************Installation guide**************************************************************************************
The program can be opened directly on Matlab2022 in seconds.
******************************************Demo********************************************************************************************
Notice：Program use requires our device.
Simply click trianning to run the program. The expected output is as shown in demo1-2, which takes about a few minutes to run.
******************************************Introduction**************************************************************************************

This program is used for handwriting recognition and object recognition.
The information collection, training and recognition of the application can be completed through cap1.mlapp and cap2.mlapp.

Cap1.mlapp: Data collection, model training
Cap1.mlapp: Application identification
read_serial4.m: Serial communication, analysis and processing of information from sensors
Lvbo.m: Filter the original information
save_read_serial.m: Adjust the format of sensor information
data_label.m: Labeling all data to facilitate neural networks training
CNN.m: Models for neural networks
Classfy.m: recognition
cap_data.mat: Stored information matrix
cap_data_cap1to6.mat: Data format conversion matrix
cap_data_8_15: Object recognition 15 samples collected. (Participant 1)
cap_data_8_20: Object recognition 20 samples collected. (Participant 2)
cap_data_26_20: Handwriting recognition 20 samples collected. (Participant 1)
cap_data_26_40: Handwriting recognition 20 samples collected. (Participant 2)