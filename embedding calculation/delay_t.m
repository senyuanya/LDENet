function t=delay_t(p)
% n=1:100;
% p=sin(2*pi*1*n/40);
[M,T]=size(p);

for i=1:T
    x1=p(1:T-i);
    x2=p(i+1:T);
    if corr(x1.',x2.')<=1/exp(1)
        t=i;
    break;    
    end
end
