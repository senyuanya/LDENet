
%该程序计算时间序列的嵌入维数
clc
clear
filename='C:\Users\lenovo\NOED AND NSDE\Stock-Prediction-using-Neural-ODE-and-Neural-SDE-main\Stock-Prediction-using-Neural-ODE-and-Neural-SDE-main\trainingshuchuxf80.csv';
x=csvread(filename)
data=x; % data为原始数据
min_m=1;
max_m=50;% min_m,max_m分别为最小和最大嵌入维数
tau=1;    % tau为时间延迟

%------------------------------------------------------

N=length(data);
k=1;

%-------------------------------------------------------
for m=min_m:max_m
    m
    Y=reconstitution(data,N,m,tau);%相重构
    [m,M]=size(Y);
    for i=1:N-m*tau
        i;
        %-----计算第i个向量与每个向量的距离存于d(j)中--------
        for j=1:N-m*tau
        d(j)=norm(Y(:,i)-Y(:,j),inf);
        end
        %-----求距离最短向量的下标-----------
        temp=sort(d);
        D(i,1)=i;      %D的第一列为向量序号
        temp1=find(temp>0);
        temp2=find(d==temp(temp1(1)));
        D(i,2)=temp2(1);  %第二列为与之对应的最短距离向量的序号
        D(i,3)=temp(temp1(1));%第三列为与之对应的最短距离
        %-----------计算a(i,m)-----------------------
         Y1=[Y(:,i);data(m*tau+i)];
         Y2=[Y(:,D(i,2));data(D(i,2)+m*tau)];
        ad(i)=norm(Y1-Y2,inf)/D(i,3);
        clear d Y1 Y2 temp temp1 temp2
    end
    D;
     %---------------求E(d)-----------------
    E(k,1)=m;
    E(k,2)=sum(ad)/(N-m*tau);
    % k=k+1;
    %---------------求E*(d)-----------------
    En(k,1)=m;
    En1(k,1)=m;
    for kk=1:N-m*tau
         dd(kk)=abs(data(D(kk,1)+m*tau)-data(D(kk,2)+m*tau));
         %dd1(kk)=abs(data(D(kk,1)+1)-data(D(kk,2)+1));
    end
    En(k,2)=sum(dd)/(N-m*tau);
   % En1(k,2)=sum(dd1)/(N-m*tau);
    k=k+1;

    clear D
end

%-----------求E1(d)-------------------
for i=1:(max_m-min_m)
    E1(i,1)=E(i,1);
    E1(i,2)=E(i+1,2)/E(i,2);
end
%-----------求E2(d)-------------------
for i=1:(max_m-min_m)
    E2(i,1)=En(i,1);
    E2(i,2)=En(i+1,2)/En(i,2);
end
%-----------画图------------------------
figure(1)
plot(E1(:,1),E1(:,2),'-bs',E2(:,1),E2(:,2),'-r*');xlabel('维数');ylabel('E1(d)&E2(d)');
grid on

% disp('-----------求使Ed最小的嵌入维数-------------------');
% min_E=min(En(:,2));
% for i=1:(max_m-min_m)
%     if En(i,2)==min_E
%         embed_m=En(i,1);
%         break
%     end
% end
% embed_m
% 
% min_E1=min(En1(:,2));
% for i=1:(max_m-min_m)
%     if En1(i,2)==min_E1
%         embed_m1=En1(i,1);
%         break
%     end
% end
% embed_m1

% figure(2)
% plot(En(:,1),En(:,2),En1(:,1),En1(:,2),'r');xlabel('维数');ylabel('E*(d)');
% grid on
% 
% disp('--------cao法求m---------')
e=0.1;embed_m=0;
h=1:length(E1(:,2))-1;
delt=abs(E1(h,2)-E1(h+1,2));
num=find(delt<e);
num1=find(delt==max(delt(num(1):length(delt))));
e=mean(delt(num1(1):length(E1(:,2))-1));
for kk=num1(1):length(E1(:,2))
     if kk+2<=length(E1(:,2))
         delt1=abs(E1(kk,2)-E1(kk-1,2));
         delt2=abs(E1(kk+1,2)-E1(kk,2));
         delt3=abs(E1(kk+2,2)-E1(kk+1,2));
         
         if (delt1>delt2)&(delt2>delt3)&(delt2<e)
            embed_m=kk
             break
         end
     end
 end


