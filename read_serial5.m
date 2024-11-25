close all;  
clear all;  
clc;  
% fclose(instrfindall)  
hold on      %这一句经测试是必要的，没有这句的话~波形显示的句柄好像无法调用  

global t;  
global x;  
global m;  
global ii;  
global data;    %数据缓冲矩阵  
  
data = [0];  
t = [0];        %显示的时候为x轴变量，本质是采样点数  
m = ones(6,1);  %m为数据存储矩阵，每一行为一个通道，从串口打开到结束，每一行的数据都存放于这个矩阵，接收到波形后可以进行数据分析、拟合  
x = -100;       %x轴起始坐标  
ii = 1;         %也是一个类似起始位的东西  
  
% h1 = plot(1,'b','MarkerSize',20);   %通道1的颜色与线粗，h1为句柄，以下同  
% h2 = plot(0,'g','MarkerSize',20);  
% h3 = plot(0,'r','MarkerSize',20);  
% h4 = plot(0,'c','MarkerSize',20);  
% h5 = plot(0,'m','MarkerSize',20);  
%   
% h6 = plot(0,'y','MarkerSize',20);  
% h7 = plot(0,'k','MarkerSize',20);  
h1 = plot(1,LineWidth=1);   %通道1的颜色与线粗，h1为句柄，以下同  
h2 = plot(0,LineWidth=1);  
h3 = plot(0,LineWidth=1);  
h4 = plot(0,LineWidth=1);  
h5 = plot(0,LineWidth=1);  
h6 = plot(0,LineWidth=1); 
H = [h1;h2;h3;h4;h5;h6];         %所有通道句柄的入口矩阵，方便回调函数传参  
  
title('Matlab Scope');   
legend('ch1','ch2','ch3','ch4','ch5','ch6');    %在左上角标注通道  
%grid on;  
xlabel('采样点数');             %标注X轴  
ylabel('数值大小');             %标注Y轴  
s = serial('COM6');            %选择串口~  
s.BaudRate = 9600;              %选择波特率  
s.DataBits = 8;                 %设置数据位数  
s.StopBits = 1;                 %设置停止位  
set(s,'Parity', 'none','FlowControl','none');   %无校验位，无流控制  
s.ReadAsyncMode = 'continuous';                 %异步接收模式为连续  
s.BytesAvailableFcnMode = 'byte';               %回调函数模式为字节  
s.BytesAvailableFcnCount = 18;                  %每接收到20个字节，触发中断，调用回调函数，0xff,0xa5，0x5a(0x5b) 三位帧头+七位数据  
s.BytesAvailableFcn = {@callback_16bit,H};      %回调函数地址，以及相应波形显示通道句柄  
  
try  
    fopen(s);                               %打开串口  
catch err  
    fprintf('串口打开失败。\n');  
end  


function callback_16bit(s,BytesAvailable,p)  
%function callback(s, p)   
% 串口接收中断的回调函数  
global t;   
global x;   
global m;   
global ii;  
global data;  
  
n_bytes = s.BytesAvailable;         %获取串口接收到数据的个数  
  
out = fread(s,[1 n_bytes],'uint8'); %将串口数据以一行8位整型的形式显示出来  
mat = zeros(6,1);                   %8位转16位数据处理矩阵  
data = [data out];                  %合并缓存矩阵  
% if size(data,2)>3000
%     data(1:size(data,2)-3000)=[];
% end  
while(length(data) >= 14)           %当data长度大于14时，不停循环  
% if(data(1) == 255 && data(2) == 165 && data(3) == 90)   %有符号整型帧头 0xff,0xa5,0x5a  
% %确认为一帧数据  
% data(1:3) = [];             %清空帧头位  
% for i = 1:7                 %将7个通道的数据提取出来  
% mat(i,1) = data(1)*256+data(2);     %将两个8位数据合并成16位数据  
% if (mat(i,1) > 32768)               %提取符号位  
% mat(i,1) = -(65536-mat(i,1));   %求补码  
% end  
% data(1:2) = [];                     %清空提取到的data缓存数据  
% end  
% m = [m mat];    %合并波形显示矩阵  
% ii = ii + 1;    %计数+1  
% t = [t ii];     %合并采样点数矩阵  
% x = x +  1;     %移动x轴  
% for j = 1:7     %刷新7通道的显示句柄  
% set(p(j),'xdata',t,'ydata',m(j,1:length(t)));  
% end  
%   
if(data(1) == 255 && data(2) == 255)   %无符号整型帧头 0xff，0xa5，0x5b  
%确认为一帧数据  
data(1:2) = [];     %同上  
for i = 1:6  
mat(i,1) = data(1)*256+data(2);  
data(1:2) = [];  
end  
m = [m mat]; %读取帧数据  
% if size(m,2)>2000
%     data(1:size(m,2)-3000)=[];
% end  
ii = ii + 1;  
t = [t ii];  
x = x +  1;  
for j = 1:6  
set(p(j),'xdata',t,'ydata',m(j,1:length(t)));  
end  
else  
data(1) = [];       %如果不是帧头，则数据错误？？跳过错误数据直到找到帧头  
end  
end  
  
y = length(m(1,:));     %求m矩阵的列数  
%     ymin = min(m(1:7,y)); %求同列的最小值  
%     ymax = max(m(1:7,y)); %求同列的最大值  
ymin = min(min(m));     %求整个矩阵的最小值  
ymax = max(max(m));     %求整个矩阵的最大值  
drawnow                 %更新图形窗口  
axis([x-500 x+1500 ymin-10 ymax+20]);       %更新两轴  
 %axis([x-500 x+150 60 350]);  
end   