%计算出的ED从4：14，当ED值增加平稳的时候，取m对应的值，即为嵌入维数
%t为延迟时间，自相关函数的值掉为1/e的时候，即为延迟时间的值。

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