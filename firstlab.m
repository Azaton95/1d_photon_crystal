function []=firstlab()

delt = 0.1*10^(-9); %step in m
wl_range = delt:delt:2*10^(-6); %the values of the wavelengths
len = length(wl_range); %number of counts
n1 = 3.4; %refractive index
n2 = 1.34; %refractive index
n_d = n2;
c_l=800*10^(-9); %chosen_length


N1=8;
[k,T1] = mac(len,wl_range,c_l,n1,n2,N1,0,n_d);
N2=14;
[~,T2] = mac(len,wl_range,c_l,n1,n2,N2,0,n_d);
N3=20;
[~,T3] = mac(len,wl_range,c_l,n1,n2,N3,0,n_d);
N4=50;
[~,T4] = mac(len,wl_range,c_l,n1,n2,N4,0,n_d);

%Графики 1
figure
subplot(2,1,1)
plot(wl_range*10^(9),real(k),'r-','LineWidth',1)
axis([100 2000 -inf inf])
title('Зависимость блоховского волнового числа от длины волны',...
    'FontName', 'Times New Roman','fontsize',14)
xlabel('Длина волны, нм','FontName', 'Times New Roman','fontsize',14)
ylabel('real(k)','FontName', 'Times New Roman','fontsize',14)
grid on

subplot(2,1,2)
plot(wl_range*10^(9),abs(imag(k)),'b-','LineWidth',1)
axis([100 2000 -inf inf])
xlabel('Длина волны, нм','FontName', 'Times New Roman','fontsize',14)
ylabel('imag(k)','FontName', 'Times New Roman','fontsize',14)
grid on

%Графики 2
figure
subplot(2,2,1)
plot(wl_range.*10^(9),T1,'b-','LineWidth',1)
axis([100 2000 -inf inf])
xlabel('Длина волны, нм','FontName', 'Times New Roman','fontsize',14)
ylabel('Коэффициент пропускания','FontName', 'Times New Roman','fontsize',14)
title(['Зависимость коэффициента пропускания от длины волны, при количестве слоёв N=', num2str(N1)],...
    'FontName', 'Times New Roman','fontsize',14)
grid on
subplot(2,2,2)
plot(wl_range.*10^(9),T2,'b-','LineWidth',1)
axis([100 2000 -inf inf])
xlabel('Длина волны, нм','FontName', 'Times New Roman','fontsize',14)
ylabel('Коэффициент пропускания','FontName', 'Times New Roman','fontsize',14)
title(['N=', num2str(N2)],...
    'FontName', 'Times New Roman','fontsize',14)
grid on
subplot(2,2,3)
plot(wl_range.*10^(9),T3,'b-','LineWidth',1)
axis([100 2000 -inf inf])
xlabel('Длина волны, нм','FontName', 'Times New Roman','fontsize',14)
ylabel('Коэффициент пропускания','FontName', 'Times New Roman','fontsize',14)
title(['N=', num2str(N3)],...
    'FontName', 'Times New Roman','fontsize',14)
grid on
subplot(2,2,4)
plot(wl_range.*10^(9),T4,'b-','LineWidth',1)
axis([100 2000 -inf inf])
xlabel('Длина волны, нм','FontName', 'Times New Roman','fontsize',14)
ylabel('Коэффициент пропускания','FontName', 'Times New Roman','fontsize',14)
title(['N=', num2str(N4)],...
    'FontName', 'Times New Roman','fontsize',14)
grid on

%n1 = 3.4, n2 = 1.34
[~,T1]=mac(len,wl_range,c_l,n1,n2,N4,0,n_d);
%n1 = 3.4, n2 = 1.9
n22 = 1.9;
[~,T2]=mac(len,wl_range,c_l,n1,n22,N4,0,n_d);
%n1 = 3.4, n2 = 2.7
n23 = 2.7;
[~,T3]=mac(len,wl_range,c_l,n1,n23,N4,0,n_d);
%n1 = 3.4, n2 = 2.9
n24 = 2.7;
[~,T4]=mac(len,wl_range,c_l,n1,n24,N4,0,n_d);

%Графики 3
figure
subplot(2,2,1)
plot(wl_range.*10^(9),T1,'b-','LineWidth',1)
axis([100 2000 -inf inf])
xlabel('Длина волны, нм','FontName', 'Times New Roman','fontsize',14)
ylabel('Коэффициент пропускания','FontName', 'Times New Roman','fontsize',14)
title(['Зависимость коэффициента пропускания от длины волны, n1=', num2str(n1),', n2=', num2str(n2)],...
    'FontName', 'Times New Roman','fontsize',14)
grid on
subplot(2,2,2)
plot(wl_range.*10^(9),T2,'b-','LineWidth',1)
axis([100 2000 -inf inf])
xlabel('Длина волны, нм','FontName', 'Times New Roman','fontsize',14)
ylabel('Коэффициент пропускания','FontName', 'Times New Roman','fontsize',14)
title(['n1=', num2str(n1),', n2=', num2str(n22)],...
    'FontName', 'Times New Roman','fontsize',14)
grid on
subplot(2,2,3)
plot(wl_range.*10^(9),T3,'b-','LineWidth',1)
axis([100 2000 -inf inf])
xlabel('Длина волны, нм','FontName', 'Times New Roman','fontsize',14)
ylabel('Коэффициент пропускания','FontName', 'Times New Roman','fontsize',14)
title(['n1=', num2str(n1),', n2=', num2str(n23)],...
    'FontName', 'Times New Roman','fontsize',14)
grid on
subplot(2,2,4)
plot(wl_range.*10^(9),T4,'b-','LineWidth',1)
axis([100 2000 -inf inf])
xlabel('Длина волны, нм','FontName', 'Times New Roman','fontsize',14)
ylabel('Коэффициент пропускания','FontName', 'Times New Roman','fontsize',14)
title(['n1=', num2str(n1),', n2=', num2str(n24)],...
    'FontName', 'Times New Roman','fontsize',14)
grid on

N1=2;
[~,T1] = mac(len,wl_range,c_l,n1,n2,N1,1,n_d);
N2=4;
[~,T2] = mac(len,wl_range,c_l,n1,n2,N2,1,n_d);
N3=6;
[~,T3] = mac(len,wl_range,c_l,n1,n2,N3,1,n_d);
N4=8;
[~,T4] = mac(len,wl_range,c_l,n1,n2,N4,1,n_d);

%Графики 2
figure
subplot(2,2,1)
plot(wl_range.*10^(9),T1,'b-','LineWidth',1)
axis([100 2000 -inf inf])
xlabel('Длина волны, нм','FontName', 'Times New Roman','fontsize',14)
ylabel('Коэффициент пропускания','FontName', 'Times New Roman','fontsize',14)
title(['Зависимость коэффициента пропускания от длины волны, при количестве слоёв N=', num2str(N1)],...
    'FontName', 'Times New Roman','fontsize',14)
grid on
subplot(2,2,2)
plot(wl_range.*10^(9),T2,'b-','LineWidth',1)
axis([100 2000 -inf inf])
xlabel('Длина волны, нм','FontName', 'Times New Roman','fontsize',14)
ylabel('Коэффициент пропускания','FontName', 'Times New Roman','fontsize',14)
title(['N=', num2str(N2)],...
    'FontName', 'Times New Roman','fontsize',14)
grid on
subplot(2,2,3)
plot(wl_range.*10^(9),T3,'b-','LineWidth',1)
axis([100 2000 -inf inf])
xlabel('Длина волны, нм','FontName', 'Times New Roman','fontsize',14)
ylabel('Коэффициент пропускания','FontName', 'Times New Roman','fontsize',14)
title(['N=', num2str(N3)],...
    'FontName', 'Times New Roman','fontsize',14)
grid on
subplot(2,2,4)
plot(wl_range.*10^(9),T4,'b-','LineWidth',1)
axis([100 2000 -inf inf])
xlabel('Длина волны, нм','FontName', 'Times New Roman','fontsize',14)
ylabel('Коэффициент пропускания','FontName', 'Times New Roman','fontsize',14)
title(['N=', num2str(N4)],...
    'FontName', 'Times New Roman','fontsize',14)
grid on

N=4;
n_d1 = 1.5;
[~,T1] = mac(len,wl_range,c_l,n1,n2,N,1,n_d1);
n_d2 = 1.8;
[~,T2] = mac(len,wl_range,c_l,n1,n2,N,1,n_d2);
n_d3 = 2.3;
[~,T3] = mac(len,wl_range,c_l,n1,n2,N,1,n_d3);
n_d4 = 2.8;
[~,T4] = mac(len,wl_range,c_l,n1,n2,N,1,n_d4);

%Графики 2
figure
subplot(2,2,1)
plot(wl_range.*10^(9),T1,'b-','LineWidth',1)
axis([100 2000 -inf inf])
xlabel('Длина волны, нм','FontName', 'Times New Roman','fontsize',14)
ylabel('Коэффициент пропускания','FontName', 'Times New Roman','fontsize',14)
title(['Зависимость коэффициента пропускания от длины волны, показатель преломления дефекта n_d=', num2str(n_d1)],...
    'FontName', 'Times New Roman','fontsize',14)
grid on
subplot(2,2,2)
plot(wl_range.*10^(9),T2,'b-','LineWidth',1)
axis([100 2000 -inf inf])
xlabel('Длина волны, нм','FontName', 'Times New Roman','fontsize',14)
ylabel('Коэффициент пропускания','FontName', 'Times New Roman','fontsize',14)
title(['n_d=', num2str(n_d2)],...
    'FontName', 'Times New Roman','fontsize',14)
grid on
subplot(2,2,3)
plot(wl_range.*10^(9),T3,'b-','LineWidth',1)
axis([100 2000 -inf inf])
xlabel('Длина волны, нм','FontName', 'Times New Roman','fontsize',14)
ylabel('Коэффициент пропускания','FontName', 'Times New Roman','fontsize',14)
title(['n_d=', num2str(n_d3)],...
    'FontName', 'Times New Roman','fontsize',14)
grid on
subplot(2,2,4)
plot(wl_range.*10^(9),T4,'b-','LineWidth',1)
axis([100 2000 -inf inf])
xlabel('Длина волны, нм','FontName', 'Times New Roman','fontsize',14)
ylabel('Коэффициент пропускания','FontName', 'Times New Roman','fontsize',14)
title(['n_d=', num2str(n_d4)],...
    'FontName', 'Times New Roman','fontsize',14)
grid on


end