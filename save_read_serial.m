function [cap_num] = save_read_serial()
%SAVE 
%   用来保存数据
clear
load cap_data.mat 
% load cap_num.mat
load cap_data_cap1to6.mat
%size_cap=size(cap_data);
% figure(1);
% X=1:size_cap(2);
% Y=cap;
cap_Xtrain=mat2cell(cap_lv_cap1to6,size(cap_lv_cap1to6,1),size(cap_lv_cap1to6,2))
cap_num=cap_num+1;
cap_data(cap_num,1)=cap_Xtrain;
% save cap_data.mat 
% save cap_num.mat
save('cap_data.mat','cap_data',"cap_num")
end

