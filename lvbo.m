function [outputArg1] = lvbo(Tstruct)
%LVBO 此处显示有关此函数的摘要
%   此处显示详细说明
% Tstruct=Tstruct'

Y=size(Tstruct)
% subplot(4,1,1)
% plot(1:Y(2),Tstruct)
% axis([0 Y(2) 0 300])

x1= smoothts(Tstruct)
% subplot(4,1,2)
% plot(1:Y(2),x1)
% axis([0 Y(2) 0 300])

x2= smoothts(x1)
% subplot(4,1,3)
% plot(1:Y(2),x2)
% axis([0 Y(2) 0 300])

x3= smoothts(x2)
% subplot(4,1,3)
% plot(1:Y(2),x3)
% axis([0 Y(2) 0 300])

x4= smoothts(x3)
% subplot(4,1,4)
% plot(1:Y(2),x4)
% axis([0 Y(2) 0 300])

x5= smoothts(x4)
% subplot(4,1,4)
% plot(1:Y(2),x5)
% axis([0 Y(2) 0 300])

outputArg1=x5;
end

