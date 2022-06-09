%lambda_1=lyapunov_wolf(data,N,m,tau,P)
%  �ú�����������ʱ�����е����Lyapunov ָ��--Wolf ����
%  m: Ƕ��ά��
%  tau:ʱ���ӳ�
%  data:ʱ������
%  N:ʱ�����г���
%  P:ʱ�����е�ƽ������,ѡ���ݻ����൱ǰ���λ�ò������ǰ���ΪI�����ݻ����ֻ����|I��J|>P���������Ѱ
%  lambda_1:�������lyapunovָ��ֵ
filename='C:\Users\lenovo\NOED AND NSDE\Stock-Prediction-using-Neural-ODE-and-Neural-SDE-main\Stock-Prediction-using-Neural-ODE-and-Neural-SDE-main\trainingshuchuxf80.csv';
x=csvread(filename)
data=x; % dataΪԭʼ����
N=length(data);
m=23;% Ƕ��ά��
P=30;
tau=1;    % tauΪʱ���ӳ�
min_point=1  ; %&&Ҫ�������������ĵ���
MAX_CISHU=5 ;  %&&�������������Χ����
%FLYINGHAWK
%   �������С��ƽ��������
    max_d = 0;                                         %���������
    min_d = 1.0e+100;                                  %��С������
    avg_dd = 0;
    Y=reconstitution(data,N,m,tau);                    %��ռ��ع�
    M=N-(m-1)*tau;                                     %�ع���ռ������ĸ���
    for i = 1 : (M-1)
        for j = i+1 : M
            d = 0;
            for k = 1 : m
                d = d + (Y(k,i)-Y(k,j))*(Y(k,i)-Y(k,j));
            end
            d = sqrt(d);
            if max_d < d
               max_d = d;
            end
            if min_d > d
               min_d = d;
            end
            avg_dd = avg_dd + d;
        end
    end
    avg_d = 2*avg_dd/(M*(M-1));                %ƽ��������
    
    dlt_eps = (avg_d - min_d) * 0.02 ;         %����min_eps��max_eps���Ҳ����ݻ����ʱ����max_eps�ķſ����
    min_eps = min_d + dlt_eps / 2 ;            %�ݻ�����뵱ǰ���������С��
    max_eps = min_d + 2 * dlt_eps  ;           %&&�ݻ�����뵱ǰ������������
    
%     ��P+1��M-1������������һ�������������λ��(Loc_DK)������̾���DK
    DK = 1.0e+100;                             %��i����㵽����������ľ���
    Loc_DK = 2;                                %��i������Ӧ������������±�
    for i = (P+1):(M-1)                        %���ƶ��ݷ��룬�ӵ�P+1��ʼ����
        d = 0;
        for k = 1 : m
            d = d + (Y(k,i)-Y(k,1))*(Y(k,i)-Y(k,1));
        end
        d = sqrt(d);
        if (d < DK) & (d > min_eps) 
           DK = d;
           Loc_DK = i;
        end
    end
%     ���¼��������Ӧ�����������浽lmd()������
%     i Ϊ�����ţ���1��(M-1)��Ҳ��i-1����ݻ��㣻Loc_DKΪ���i-1��Ӧ��̾�������λ�ã�DKΪ���Ӧ����̾���
%     Loc_DK+1ΪLoc_DK���ݻ��㣬DK1Ϊi�㵽Loc_DK+1��ľ��룬��Ϊ�ݻ�����
%     ǰi��log2��DK1/DK�����ۼƺ�������i���lambdaֵ
    sum_lmd = 0 ;                              % ���ǰi��log2��DK1/DK�����ۼƺ�
    for i = 2 : (M-1)                          % �����ݻ�����      
        DK1 = 0;
        for k = 1 : m
            DK1 = DK1 + (Y(k,i)-Y(k,Loc_DK+1))*(Y(k,i)-Y(k,Loc_DK+1));
        end
        DK1 = sqrt(DK1);
        old_Loc_DK = Loc_DK ;                  % ����ԭ���λ�����
        old_DK=DK;

%     ����ǰi��log2��DK1/DK�����ۼƺ��Լ�����i�������ָ��
        if (DK1 ~= 0)&( DK ~= 0)
           sum_lmd = sum_lmd + log(DK1/DK) /log(2);
        end
        lmd(i-1) = sum_lmd/(i-1);
%     ����Ѱ��i�����̾��룺Ҫ�������ָ�����뷶Χ�ھ����̣���DK1�ĽǶ���С
        point_num = 0  ; % &&��ָ�����뷶Χ���ҵ��ĺ�ѡ���ĸ���
        cos_sita = 0  ; %&&�н����ҵıȽϳ�ֵ ����Ҫ��һ�������
        zjfwcs=0     ;%&&���ӷ�Χ����
         while (point_num == 0)
           % * �������
            for j = 1 : (M-1)
                if abs(j-i) <=(P-1)      %&&��ѡ��൱ǰ��̫����������
                   continue;     
                end
                
                %*�����ѡ���뵱ǰ��ľ���
                dnew = 0;
                for k = 1 : m
                   dnew = dnew + (Y(k,i)-Y(k,j))*(Y(k,i)-Y(k,j));
                end
                dnew = sqrt(dnew);
                
                if (dnew < min_eps)|( dnew > max_eps )   %&&���ھ��뷶Χ��������
                  continue;             
                end
                               
                %*����н����Ҽ��Ƚ�
                DOT = 0;
                for k = 1 : m
                    DOT = DOT+(Y(k,i)-Y(k,j))*(Y(k,i)-Y(k,old_Loc_DK+1));
                end
                CTH = DOT/(dnew*DK1);
                
                if acos(CTH) > (3.14151926/4)      %&&����С��45�ȵĽǣ�������
                  continue;
                end
                
                if CTH > cos_sita   %&&�¼н�С�ڹ�ȥ���ҵ������ļнǣ�����
                    cos_sita = CTH;
                    Loc_DK = j;
                    DK = dnew;
                end

                point_num = point_num +1;
                
            end        
        
            if point_num <= min_point
               max_eps = max_eps + dlt_eps;
               zjfwcs =zjfwcs +1;
               if zjfwcs > MAX_CISHU    %&&�������ſ��������������ĵ�
                   DK = 1.0e+100;
                   for ii = 1 : (M-1)
                      if abs(i-ii) <= (P-1)      %&&��ѡ��൱ǰ��̫����������
                       continue;     
                      end
                      d = 0;
                      for k = 1 : m
                          d = d + (Y(k,i)-Y(k,ii))*(Y(k,i)-Y(k,ii));
                      end
                      d = sqrt(d);
        
                      if (d < DK) & (d > min_eps) 
                         DK = d;
                         Loc_DK = ii;
                      end
                   end
                   break; 
               end
               point_num = 0          ;     %&&������뷶Χ����������
               cos_sita = 0;
            end
        end
   end

%ȡƽ���õ����������ŵ��ָ��
lambda_1=sum(lmd)/length(lmd);
lambda_1