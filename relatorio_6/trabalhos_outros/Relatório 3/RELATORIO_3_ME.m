clear all; clc; close all
%% RELATÓRIO 3 - ME (4 BIMESTRE)
% INPUTS
load laderocha1_pos1.mat
load laderocha1_pos2.mat
load laderocha2_pos1.mat
load laderocha2_pos2.mat
load laderocha3_pos1.mat
load laderocha3_pos2.mat
load semamostra1_pos1.mat
load semamostra1_pos2.mat
% PARAMETROS DE ENTRADA
distancia_microfones = 24/1000; %Distância entre os dois microfones
distancia_mic2_final = distancia_microfones + 39.5/1000; %Distância do microfone 2 até o final do duto
diametro_tubo = 0.027;
f = laderocha1_pos1(:,2);
co = 343; w = 2*pi*f; k = w/co;
frequencia_corte = ((1.84*co)/(pi*diametro_tubo));
frequencia_maxima = 0.45*((co)/(distancia_microfones));
% CALCULO DE COEFICIENTES

for n=1:3
eval(['H_12_2_',num2str(n),'=laderocha',num2str(n),'_pos1(:,3)+1j*laderocha',num2str(n),'_pos1(:,4);'])
eval(['H_12_1_',num2str(n),'=laderocha',num2str(n),'_pos2(:,3)+1j*laderocha',num2str(n),'_pos2(:,4);'])
eval(['H_12_',num2str(n),'=sqrt(H_12_1_',num2str(n),')./sqrt(H_12_2_',num2str(n),');'])
eval(['r_',num2str(n),' = ((H_12_',num2str(n),'-exp(-1j*k*distancia_microfones))./(exp(1j*k*distancia_microfones)-H_12_',num2str(n),')).*exp(2*1j*k*distancia_mic2_final);'])
eval(['alpha_',num2str(n),'= 1 - abs(r_',num2str(n),'.^(2));'])
end

H_12_1_s=semamostra1_pos1(:,3)+1j*semamostra1_pos1(:,4);
H_12_2_s=semamostra1_pos2(:,3)+1j*semamostra1_pos2(:,4);
H_12_s=sqrt(H_12_2_s)./sqrt(H_12_1_s);
r_s=((H_12_s-exp(-1j*k*distancia_microfones))./(exp(1j*k*distancia_microfones)-H_12_s)).*exp(2*1j*k*distancia_mic2_final);
alpha_s=1-abs(r_s.^(2));

plot(alpha_1,'LineWidth',2);hold on
plot(alpha_2,'r','LineWidth',2);
plot(alpha_3,'g','LineWidth',2);
plot(alpha_s,'k--','LineWidth',2);
ylim([0 1])
k=legend('Amostra 1 - 25 mm','Amostra 2 - 24.85 mm','Amostra 3 - 24 mm','Sem Amostra','Location','Southeast');
set(k,'Fontsize',18)
xlabel('Frequencia [Hz]','Fontsize',24)
ylabel('\alpha [-]','Fontsize',24)
title('Coeficiente de Absorção Sonora','FontSize',24)

figure(2)
semilogx(alpha_1,'LineWidth',2);hold on
semilogx(alpha_2,'r','LineWidth',2);
semilogx(alpha_3,'g','LineWidth',2);
semilogx(alpha_s,'k--','LineWidth',2);
ylim([0 1]);xlim([60 6400])
k=legend('Amostra 1 - 25 mm','Amostra 2 - 24.85 mm','Amostra 3 - 24 mm','Sem Amostra','Location','northwest');
set(k,'Fontsize',18)
xlabel('Frequencia [Hz]','Fontsize',24)
ylabel('\alpha [-]','Fontsize',24)
title('Coeficiente de Absorção Sonora','FontSize',24)


