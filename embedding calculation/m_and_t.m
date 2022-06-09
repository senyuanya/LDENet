% compute embedding dimensiong and time lag
function [m,t]=m_and_t(x)
t=delay_t(x);
Yout=ED(x,t);
m=4;
for i=1:11
    if Yout(i)<0.95
        m=m+1;
    end
end
