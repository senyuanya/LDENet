function AMI = AMI_bin(X,tau,b)
%绘出AMI的曲线，找到第一个达到最小值的点。
L=length(X);

for i=0:tau
    X1 = X(1:L-i);
    X2 = X(1+i:L);
    AMI(i+1) = MI_bin(X1,X2,b);
end


function [MI,NMI,ProbX,ProbY,ProbXY] = MI_bin(X,Y,b)

% MI  - Mutual information between X and Y
% NMI - Normalized mutual information between X and Y
%       NMI=MI/min(ENx,ENy);

% X and Y time series
% b - the number of bins

L=length(X);

Bix = binn(X,b);
Biy = binn(Y,b);

Bixy = zeros(b,b);

for i= 1:L
    Inx=Bix(i);
    Iny=Biy(i);
    Bixy(Iny,Inx)=Bixy(Iny,Inx)+1;
end

ProbXY = Bixy/sum(sum(Bixy));

ProbX=sum(ProbXY,1);
ProbY=sum(ProbXY,2);

px=ProbX(find(ProbX~=0));
ENx = -sum(px .* log(px));

py = ProbY(find(ProbY~=0));
ENy = -sum(py .* log(py));

ENxy = 0;

for i=1:b
    for j=1:b
        p = ProbXY(i,j);
        if p>0
            ENxy = ENxy - p .* log(p);
        end
    end
end


MI=ENx+ENy-ENxy;
NMI=MI/min(ENx,ENy);


function Bi = binn(X,b)

Xmin = min(X);
Xmax = max(X);

Xb = b*(X-Xmin)/(Xmax-Xmin);

Bi = ceil(Xb);

Bi(find(Bi<1))=1;
Bi(find(Bi>b))=b;