%function  cao_m(data,min_m,max_m,tau)
%该程序用Cao氏法计算时间序列的嵌入维数
 clc
 clear
 filename='C:\Users\lenovo\.spyder-py3\stockpredictionself\shangzheng50close.csv';
 x=csvread(filename)
 data=x; % data为原始数据,列向量，n行1列
 min_m=1;
 max_m=10;% min_m,max_m分别为最小和最大嵌入维数
 tau=2;    % tau为时间延迟
% 作者:Adu,武汉大学,adupopo@163.com

[E1,E2]=cao_old(data,min_m,max_m,tau);
n=length(E1);
plot(1:n,E1,'-bs',1:n,E2,'-r*');xlabel('维数');ylabel('E1&E2');
title('Cao氏法求最小嵌入维数');
legend('E1','E2');
grid on
