 function [cap1to6,cap_lv_cap1to6] = read_serial4()
clear;
N=3472;
s = serialport("COM6",9600);
flush(s);

% tic
tic
%代码块
data = read(s,N,"uint8");
size_data=size(data);
while size_data(2) ~= N
end
toc
disp(['运行时间: ',num2str(toc)]);
% aaa=toc

pp=1;j=1;data_TF1=1;data_TF2=1;

while data_TF1~=0xff||data_TF2~=0xff
data_TF1=data(pp);
data_TF2=data(pp+1);
pp=pp+1;
end

% if pp~=1
    pp=pp-1;
    for i=1:pp
        data(N+i)=data(N);
    end
% end

for i=pp:14:N+pp-1
    cap(j)=data(i+2)*256+data(i+3);
    j=j+1;
    cap(j)=data(i+4)*256+data(i+5);
    j=j+1;
    cap(j)=data(i+6)*256+data(i+7);
    j=j+1;
    cap(j)=data(i+8)*256+data(i+9);
    j=j+1;
    cap(j)=data(i+10)*256+data(i+11);
    j=j+1;
    cap(j)=data(i+12)*256+data(i+13);
    j=j+1;
end
% cap=cap(31:N/14*6-30)
size_cap=size(cap);
% figure(1);
X=1:size_cap(2);
Y=cap;
% plot(1:size_cap(2),cap)
% axis([0 j 0 300])
%%
%采集到的信息分离出六通道,存储到六行矩阵
for i=1:size(cap,2)
    j=mod(i,6);
    if j==0
        j=6;
    end
    cap1to6(j,ceil(i/6))=cap(1,i);
end

%%每通道数据进行滤波
for i=1:6  
    cap_lv=cap1to6(i,:);
    cap_lv_cap1to6(i,:)=lvbo(cap_lv);
% X_lv=1:size_cap_lv(2);
% Y_lv=cap_lv;
end
cap1to6=cap1to6(:,9:size(cap,2)/6-12);
cap_lv_cap1to6=cap_lv_cap1to6(:,9:size(cap,2)/6-12);
% save cap_lv_cap1to6

% load('net.mat')
% 
% % Y = classify(net,cap_lv_cap1to6)
% % clc;
% % disp(Y)
save('cap_data_cap1to6','cap_lv_cap1to6',"cap1to6")
% a=clock 
% a=fix(clock)
% filename=strcat('Am',num2str(a),'.mat')
% save(['..\cap\AM\',filename],'cap')
 end

