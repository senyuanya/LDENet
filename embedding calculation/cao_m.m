%function  cao_m(data,min_m,max_m,tau)
%�ó�����Cao�Ϸ�����ʱ�����е�Ƕ��ά��
 clc
 clear
 filename='C:\Users\lenovo\.spyder-py3\stockpredictionself\shangzheng50close.csv';
 x=csvread(filename)
 data=x; % dataΪԭʼ����,��������n��1��
 min_m=1;
 max_m=10;% min_m,max_m�ֱ�Ϊ��С�����Ƕ��ά��
 tau=2;    % tauΪʱ���ӳ�
% ����:Adu,�人��ѧ,adupopo@163.com

[E1,E2]=cao_old(data,min_m,max_m,tau);
n=length(E1);
plot(1:n,E1,'-bs',1:n,E2,'-r*');xlabel('ά��');ylabel('E1&E2');
title('Cao�Ϸ�����СǶ��ά��');
legend('E1','E2');
grid on
