function YY= eaid(P,d,t)
if nargin < 3, error('Not enough input arguments'),end
N=length(P);
X=[];Y=[];
for k=1:(N-d*t)
    Py=P(1,k+d*t);
    PP=[];
    for i=1:d
        PP=[PP P(1,k-t+i*t)];
    end
    X=[X;PP]; %X，Y 均是一维列向量
    Y=[Y;Py];
end 
N1=length(Y);

Dx=[];Dy=[];
for i=1:N1
    D1=[];D2=[];
    for j=1:N1
        d1=abs(X(i,:)-X(j,:));
        d1=max(d1);
        D1=[D1 d1];
        d2=abs(Y(i)-Y(j));
        D2=[D2 d2];
    end
    Dx=[Dx;D1];
    Dy=[Dy;D2];
end
%************************************************%

%************************************************%
%计算距离X(i)最近的点%
aids=[];
for i=1:N1
    DD=Dx(i,:);
    [DDa DDb]=sort(DD);
    Al=DDa(1,2);
    Ahh=DDb(1,2);
    Ah=max(Al,Dy(i,Ahh));
    aids=[aids Ah/Al];
end
YY=mean(aids);
