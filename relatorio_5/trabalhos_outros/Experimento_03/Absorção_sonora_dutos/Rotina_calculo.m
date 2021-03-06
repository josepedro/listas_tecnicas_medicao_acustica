%% C�lculo do coeficiente de absor��o sonora de uma amostra de material
%% ac�stico

%clear all
close all
clc
format long

H12_I = load('LA_VIDRO_VERDE_H1_new.txt');

H12_II = load('LA_VIDRO_VERDE_H2_new.txt');

Freq = H12_I(:,2);

N = length(H12_I(:,1));
NN = length(H12_II(:,1));
H12_1=zeros(N,1);
H12_2=zeros(N,1);

R = 287;
T = 22;
Co = ((1.4*R*(T+273.15))^(1/2));
X1 = 67.3/1000;
S = (24/1000);
X2 = X1 - S;
Si = (24+124)/2000;
d = 26.5/1000;

fmin = 0.05*Co/S
fmax = 0.58*Co/d
Smin = 0.45*Co/fmax
f_c  = (1.84*Co)/(pi*d);


for i=1:N   
    
    H12_1a(i) = ((H12_I(i,3)^2)+(H12_I(i,4)^2))^(-1/2);
    H12_2a(i) = ((H12_II(i,3)^2)+(H12_II(i,4)^2))^(1/2);
    
    H12_1(i) = ( H12_I(i,3)  +  1j*H12_I(i,4)  );   
    H12_2(i) = ( H12_II(i,3) +  1j*H12_II(i,4) );
    
    H(i)   = ((H12_1(i)^(1/2))/(H12_2(i)^(1/2)));
    H1(i)   = ((H12_1(i))/(H12_2(i)))^(1/2);

    k_o(i) = (2*pi*Freq(i))/Co;
    
    H_I(i) = (exp(-1j*k_o(i)*(S)));
    H_R(i) = (exp( 1j*k_o(i)*(S)));
    
    r(i)   = ((H(i) - H_I(i))/((H_R(i)) - H(i)))*(exp(2*1j*k_o(i)*X1));

    alpha(i) = 1 - ((abs(r(i)))^2);
    
end



 Hn = ((H12_1.^0.5)./(H12_2.^0.5));
 H_In = (exp(-1j.*k_o*(S)));
 H_Rn = (exp( 1j.*k_o*(S)));
% Hnn = (((H12_1)./(H12_2)).^0.5);

Q = exp(2*1i.*k_o*X1);
r1 = ((Hn'-H_In)./(H_Rn-Hn')).*Q;

a = 1 - ((abs(r1)).^2);

figure(1)
plot(Freq,abs(a),'k', Freq,abs(r1),'r', 'linewidth',2.5);
title('\bf{Curvas de coficiente de absor��o sonroa e de reflex�o da amostra de material ac�stico ensaiada}', 'fontsize', 22);
ylabel('\bf{Amplitude dos coeficientes }', 'fontsize', 18);
xlabel('\bf{Frequ�ncia [Hz]}', 'fontsize', 18);
legend('Coeficiente de absor��o sonora \bf{\alpha}','Coeficiente de reflex�o \bf{r}','fontsize', 14);
xlim([fmin 7000]);
ylim([0 1]);
grid on


figure(2)
plot(Freq, abs(H),Freq,abs(H1),Freq, real(H),Freq,real(H1),Freq, imag(H),Freq,imag(H1), 'linewidth',2);
legend('abs(H)','abs(H1)','real(H)','real(H1)','imag(H)','imag(H1)')
ylabel('\bf{FRF }', 'fontsize', 18);
xlabel('\bf{Frequ�ncia [Hz]}', 'fontsize', 18);
ylim([-1 1]);

figure(3)
plot(Freq, abs(H_I),Freq,abs(H_In),Freq, real(H_I),Freq,real(H_In),Freq, imag(H_I),Freq,imag(H_In), 'linewidth',2);
legend('abs(H)','abs(H1)','real(H)','real(H1)','imag(H)','imag(H1)')
ylabel('\bf{FRF }', 'fontsize', 18);
xlabel('\bf{Frequ�ncia [Hz]}', 'fontsize', 18);
ylim([-1 1]);


figure(4)
plot(Freq, abs(H_R),Freq,abs(H_Rn),Freq, real(H_R),Freq,real(H_Rn),Freq, imag(H_R),Freq,imag(H_Rn), 'linewidth',2);
legend('abs(H)','abs(H1)','real(H)','real(H1)','imag(H)','imag(H1)')
ylabel('\bf{FRF }', 'fontsize', 18);
xlabel('\bf{Frequ�ncia [Hz]}', 'fontsize', 18);
ylim([-1 1]);



figure(5)
plot(Freq,real(H_R),Freq,real(H_Ri),Freq,imag(H_R),Freq,imag(H_Ri))

figure(6)
plot(Freq,real(H_I),Freq,real(H_Ii),Freq,imag(H_I),Freq,imag(H_Ii))

figure(7)
plot(Freq, k0, Freq, k_o)
break
pause(2)

