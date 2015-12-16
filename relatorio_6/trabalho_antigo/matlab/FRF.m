clear all; close all; clc
%% FRF's
%PLACA
load FRF_placa
frequencias = FRF_placa(:,1);
H_11_placa = FRF_placa(:,2) + i*FRF_placa(:,3);
%H_11_placa = 1./(H_11_placa/max(H_11_placa));
H_12_placa = FRF_placa(:,5) + i*FRF_placa(:,6);
maximo_H_12_placa = max(H_12_placa);
H_12_placa = 1./abs(H_12_placa/maximo_H_12_placa);
H_1_placa = 20*log10(abs(H_12_placa));%./H_11_placa);
H_1_placa = H_1_placa(1:800);
frequencias = frequencias(1:800);
H_1_placa = abs(maximo_H_12_placa)*H_1_placa/max(H_1_placa);

figure(1); plot(frequencias, H_1_placa); hold on;
axis([0 800 0 1.2*max(H_1_placa)]);
title('Funcao Resposta em Frequencia - Acelerancia da Placa','FontSize',20);
xlabel('Frequencia [Hz]','FontSize',20);
ylabel('Amplitude [dB]','FontSize',20);

% Amortecimento via Banda de Meia-Potencia
f = frequencias;
[a,fc]=findpeaks(H_1_placa,'MinPeakDistance',40);
% ESCOLHENDO O PICO DE RESSONÂNCIA
a = a(1);fc = fc(1);
H_1_placa_peak = H_1_placa(fc-20:fc+20);
k = find(H_1_placa_peak>=a-8);
f1 = k(1);f2 = k(end);
netta=((f2-f1)/fc);
window = zeros(1,length(H_1_placa_peak));
window(f1:f2)=1;
figure(2)
str = ['\eta = ',num2str(netta)];
plot(H_1_placa_peak,'LineWidth',1.5);hold on
plot((a-4)*window,'r--','LineWidth',1.5)
text(f2+10,a-3,str,'FontSize',20)
k=legend('Primeira Ressonancia da Placa','Banda de meia-potencia','Location','Northwest');
set(k,'FontSize',18)
xlabel('Numero de Pontos','FontSize',20)
ylabel('Amplitude [dB]','FontSize',20)
title('Fator de Perda da Placa - Metodo da Banda de Meia-Potencia','FontSize',20)

%% FRF's
%VIGA
load FRF_viga
frequencias_viga = FRF_viga(:,1);
Y = FRF_viga(:,2) + i*FRF_viga(:,3);
FRFa = abs(Y);
FRF_dB = 20*log10(1./FRFa);
%FRF_dB = FRF_dB/max(FRF_dB);
figure(3); plot(frequencias_viga, abs(FRF_dB)); hold on;
axis([0 800 0 1.2*max(abs(FRF_dB))]);
title('Funcao Resposta em Frequencia - Acelerancia da Viga','FontSize',20);
xlabel('Frequencia [Hz]','FontSize',20);
ylabel('Amplitude [dB]','FontSize',20);

%% DECAIMENTO LOGARITIMICO 
load dado_decay
t = dado_decay(:,1);
a = sqrt((dado_decay(:,2)).^2);
a0 = 1e-5;
fc = [50 63 80 100 125 160 200 250 315 400 500 630 800 1000 1250 1600 2000 2500 3150 4000 5000 6300 8000 10000];
dB_ac=10*log10((a.^2)./(a0^2));
m=find(dB_ac>100);
U=polyfit(t(m:8e4),dB_ac(m:8e4),1);
E=polyval(U,t(m:8e4));
eta = (2.2./((60/-U(1)*fc)));
figure(4)
plot(t,dB_ac,'k');hold on
plot(t(m:8e4),E,'r--','LineWidth',3)
str2=['TR_{medio} = ',num2str(60/-U(1))];
text(1,15,str2,'FontSize',18)
axis([t(m(1)) t(8e4) 0 120])
title('Decaimento de Energia Vibratoria','FontSize',20)
xlabel('Tempo [s]','FontSize',20)
ylabel('Amplitude [dB]','FontSize',20)
robustdemo(t(m:8e4),dB_ac(m:8e4))
figure(5)
bar(eta)
title('Fator de Perda da Placa - Metodo do Decaimento Logaritimico','FontSize',20)
ylabel('\eta','FontSize',20)
xlabel('Frequencia - Hz','FontSize',20)
set(gca,'XTick',1:1:24)
set(gca,'XTickLabel',{'50','63','80','100','125', '160', '200', '250', '315',...
 '400', '500','630', '800' ,'1k', '1.25k' ,'1.6k', '2k' ,'2.5k',...
'3.15k', '4k','5k','6.3k','8k','10k'},'FontSize',12)
grid on
