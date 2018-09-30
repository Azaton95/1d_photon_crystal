function [k,T]=mac(len,wl_range,c_l,n1,n2,N,defect,n_d)

f = waitbar(0,'Progress...');


m = 0;
l = 0;

d1 = (2*m+1)*c_l/(4*n1); %thickness of first layer
d2 = (2*l+1)*c_l/(4*n2); %thickness of second layer

%объявление размеров матриц значений
T(1:len) = 0;
R(1:len) = 0;
k1(1:len) = 0;
k2(1:len) = 0;
k(1:len) = 0;

for j=1:len

     if mod(j,len/10) == 0
         % Update waitbar and message
         waitbar(j/len,f)
     end
    
    %волновые числа для 1-ого и 2-ого слоя на i-ой длине волны
    k1(j) = 2*pi*n1/wl_range(j); %wavenumber_1
    k2(j) = 2*pi*n2/wl_range(j); %wavenumber_2
    
    %задание 1 блоховское волновое число на i-ой длине волны
    k(j) = acos(cos(k1(j)*d1)*cos(k2(j)*d2) ...
    -0.5*(k1(j)/k2(j) + k2(j)/k1(j))*sin(k1(j)*d1)*sin(k2(j)*d2))/(d1+d2); % Bloch wavenumber

    %Возведение матрицы в степень N
    if defect
        %Расчёт элементов матрицы на i-ой длине волны
        m1 = [cos(k1(j)*d1) -1i*n1*(sin(k1(j)*d1));...
            -1i*(n1^(-1))*(sin(k1(j)*d1)) cos(k1(j)*d1)];
        m2 = [cos(k2(j)*d2) -1i*n2*(sin(k2(j)*d2));...
            -1i*(n2^(-1))*(sin(k2(j)*d2)) cos(k1(j)*d1)];
        %Составление матрицы из вычисленных элементов
        m_n = 1;
        for u=1:(N+1)*2
            if u < (N+1)
                if mod(u,2) == 1
                    m_n = m_n * m1;
                else
                    m_n = m_n * m2;
                end
            elseif u > (N+1)
                if mod(u,2) == 1
                    m_n = m_n * m2;
                else
                    m_n = m_n * m1;
                end           
            else
                m_d =[cos(k2(j)*d2) -1i*n_d*(sin(k2(j)*d2));...
                    -1i*(n_d^(-1))*(sin(k2(j)*d2)) cos(k1(j)*d1)];
                m_n = m_n*m_d;
            end
        end
    else
        %Расчёт элементов матрицы на i-ой длине волны
%         m11 = cos(k1(j)*d1) * cos(k2(j)*d2)  ...
%             - (n2/n1) * sin(k1(j)*d1) * sin(k2(j)*d2);
%         m12 = (-1i * n2^(-1))  * cos(k1(j)*d1) * sin(k2(j)*d2) ...
%             - (1i * n1^(-1)) * sin(k1(j)*d1) * cos(k2(j)*d2);
%         m21 = - 1i * n1 * sin(k1(j)*d1) * cos(k2(j)*d2) ...
%             - 1i * n2 * cos(k1(j)*d1) * sin(k2(j)*d2);
%         m22 = cos(k1(j)*d1) * cos(k2(j)*d2) ...
%             - (n1/n2)* sin(k1(j)*d1) * sin(k2(j)*d2);
        m1 = [cos(k1(j)*d1) -1i*n1*(sin(k1(j)*d1));...
            -1i*(n1^(-1))*(sin(k1(j)*d1)) cos(k1(j)*d1)];
        m2 = [cos(k2(j)*d2) -1i*n2*(sin(k2(j)*d2));...
            -1i*(n2^(-1))*(sin(k2(j)*d2)) cos(k1(j)*d1)];
        
        %Составление матрицы из вычисленных элементов
%         m_c = [m11 m12; m21 m22];
        m_c = m1*m2;
        m_n = m_c^N;
    end    
    
    T(j) = abs(2/(m_n(1,1)+m_n(1,2)+m_n(2,1)+m_n(2,2)));
    R(j) = abs(((m_n(1,1)+m_n(1,2))-(m_n(2,1)+m_n(2,2))) ...
        /((m_n(1,1)+m_n(1,2))+(m_n(2,1)+m_n(2,2))));
    
    
end

delete(f)

end