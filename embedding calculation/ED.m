%�������ED��4��14����EDֵ����ƽ�ȵ�ʱ��ȡm��Ӧ��ֵ����ΪǶ��ά��
%tΪ�ӳ�ʱ�䣬����غ�����ֵ��Ϊ1/e��ʱ�򣬼�Ϊ�ӳ�ʱ���ֵ��

function Yout=ED(p,t)

Y=[];
for m=4:15
    YY=eaid(p,m,t);
    Y=[Y YY];
    disp(['The process has finished ' num2str(m-3) ' /12 ''.'])
end

L=length(Y);
ED1=[];
for i=1:L-1
    y=Y(i+1)/Y(i);
    ED1=[ED1 y];
end
Yout=ED1;