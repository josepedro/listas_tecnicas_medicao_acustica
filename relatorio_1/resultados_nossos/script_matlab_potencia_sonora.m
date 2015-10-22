clc; clear all; close all;

frequencias = textread('frequencies.txt');
% Esses valores ja sao em RMS
microphone_1 = textread('microphone_1.txt');
microphone_2 = textread('microphone_2.txt');
microphone_3 = textread('microphone_3.txt');
microphone_4 = textread('microphone_4.txt');
microphone_5 = textread('microphone_5.txt');
microphone_6 = textread('microphone_6.txt');
microphone_7 = textread('microphone_7.txt');
microphone_8 = textread('microphone_8.txt');
microphone_9 = textread('microphone_9.txt');
microphone_10 = textread('microphone_10.txt');

%% POTÊNCIA SONORA - CAMARA SEMI-ANECÓICA
% Média entre as pressões sonoras da câmara anecóica
pressao_rms(1:length(frequencias)) = 0;
for frequencia = 1:length(frequencias)
	pressao_rms(frequencia) = mean([microphone_1(frequencia) ...
		microphone_2(frequencia) ...
		microphone_3(frequencia) ...
		microphone_4(frequencia) ...
		microphone_5(frequencia) ...
		microphone_6(frequencia) ...
		microphone_7(frequencia) ...
		microphone_8(frequencia) ...
		microphone_9(frequencia) ...
		microphone_10(frequencia)].^2);
end
nivel_pressao_sonora_anecoica = 10*log10(pressao_rms(11:end)/(2e-5)^2);
diretividade = 2;
raio = 1;
nivel_potencia_sonora_anecoica = nivel_pressao_sonora_anecoica - 10*log10((diretividade)/(4*pi*raio^(2)));

% pegar a partir de 250 Hz pois eh a frequencia de corte da camara reverberante,
% pois abaixo disso os modos acusticos atuam na sala

% Plotando o nivel de pressao sonora para a camara anecoica
figure(1);
bar(nivel_pressao_sonora_anecoica, 'r'); hold on;
set(gca,'XTick',1:1:15);
set(gca,'XTickLabel',{'250', '315','400', '500','630', '800' ,'1k', '1.25k' ,'1.6k', '2k' ,'2.5k',...
'3.15k', '4k','5k','6.3k'},'FontSize',12);
xlabel('Frequência - [Hz]','FontSize',20);
ylabel('NPS - [dB]','FontSize',20);
title('Nível de Pressão Sonora na Câmara Anecóica','FontSize',20);

%% POTENCIA SONORA - CAMARA REVERBERANTE 
% ler valores rms reverberante
valores_rms_reverberante = textread('ReverberanteBoom.txt');
% pegando os valores rms
valores_rms_reverberante = valores_rms_reverberante(:,2);
% ler tempos de reverberacao (para a frequencia de 6.3k foi uma extrapolacao linear)
load TR_RV;
tempo_reverberacao = TR_RV;
% calcular nivel de pressao sonora
nivel_pressao_sonora_reverberacao = 20*log10((valores_rms_reverberante)./(2e-5));
area_superficial_total = 203.37; % m^2
volume_camara_reverberativa = 189.15; % m^3
A = -0.161*volume_camara_reverberativa;
B = tempo_reverberacao*area_superficial_total;
alpha_eyring = 1 - exp(A./B);
A = 0.161*volume_camara_reverberativa;
B = tempo_reverberacao*area_superficial_total;
alpha_sabine = A./B;
% calcular potencia sonora
A = 4*(1 - alpha_sabine);
B = area_superficial_total*alpha_sabine;
nivel_potencia_sonora_reverberacao = ...
nivel_pressao_sonora_reverberacao(11:end) - 10*log10(A./B);

% Plotando o nivel de pressao sonora para a camara reverberacao
figure(2);
bar(nivel_pressao_sonora_anecoica, 'g'); hold on;
set(gca,'XTick',1:1:15);
set(gca,'XTickLabel',{'250', '315','400', '500','630', '800' ,'1k', '1.25k' ,'1.6k', '2k' ,'2.5k',...
'3.15k', '4k','5k','6.3k'},'FontSize',12);
xlabel('Frequência - [Hz]','FontSize',20);
ylabel('NPS - [dB]','FontSize',20);
title('Nível de Pressão Sonora na Câmara Reverberante','FontSize',20);

% Plotando a comparacao dos niveis de potencia sonora
load NWS_Ref;
nivel_potencia_sonora_referencia = NWS_Ref;
figure(3)
nivel_potencia_sonora_reverberacao = nivel_potencia_sonora_reverberacao';
nivel_potencia_sonora_referencia = nivel_potencia_sonora_referencia';
A = [nivel_potencia_sonora_anecoica; nivel_potencia_sonora_reverberacao; nivel_potencia_sonora_referencia]';
bar(A)
ylim([0 115])
set(gca,'XTick',1:1:15)
set(gca,'XTickLabel',{'250', '315','400', '500','630', '800' ,'1k', '1.25k' ,'1.6k', '2k' ,'2.5k',...
'3.15k', '4k','5k','6.3k'},'FontSize',12)
xlabel('Frequência - [Hz]','FontSize',20)
ylabel('NWS - [dB]','FontSize',20)
title('Nível de Potência Sonora','FontSize',20)
k=legend('Câmara Anecóica','Câmara Reverberante','Fonte de Referência');
set(k,'FontSize',20)

figure(4)
bar([alpha_sabine alpha_eyring])
set(gca,'XTick',1:1:15)
set(gca,'XTickLabel',{'250', '315','400', '500','630', '800' ,'1k', '1.25k' ,'1.6k', '2k' ,'2.5k',...
'3.15k', '4k','5k','6.3k'},'FontSize',12)
xlabel('Frequência - [Hz]','FontSize',20)
ylabel('C. Absorção \alpha','FontSize',20)
title('C. Aborção Câmara Reverberante','FontSize',20)
k=legend('Sabine','Eyring');
set(k,'FontSize',20)
ylim([0 0.09])

valores_ruido_fundo_anecoica = textread('RuidoFundoAnecoica.txt');
ruidos_fundo_anecoica = valores_ruido_fundo_anecoica(:, 2:5);
frequencias = valores_ruido_fundo_anecoica(:,1);
nps_fundo_media_anecoica(1:length(frequencias)) = 0;
for frequencia = 1:length(frequencias)
	media_ruido = mean(ruidos_fundo_anecoica(frequencia, :));
	nps_fundo_media_anecoica(frequencia) = 20*log10(media_ruido/0.00002);
end
figure(5);
bar(nps_fundo_media_anecoica);
hold on;
set(gca,'XTick',1:1:15);
set(gca,'XTickLabel',{'250', '315','400', '500','630', '800' ,'1k', '1.25k' ,'1.6k', '2k' ,'2.5k',...
'3.15k', '4k','5k','6.3k'},'FontSize',12);
xlabel('Frequência - [Hz]','FontSize',20);
ylabel('NPS - [dB]','FontSize',20);
title('Ruído de Fundo na Câmara Semianecóica ','FontSize',20);

valores_ruido_fundo_reverberante = textread('RuidoFundoReverberante.txt');
nps_fundo_reverberante = 20*log10(valores_ruido_fundo_reverberante(:,2)/0.00002);
figure(6);
bar(nps_fundo_reverberante);
hold on;
set(gca,'XTick',1:1:15);
set(gca,'XTickLabel',{'250', '315','400', '500','630', '800' ,'1k', '1.25k' ,'1.6k', '2k' ,'2.5k',...
'3.15k', '4k','5k','6.3k'},'FontSize',12);
xlabel('Frequência - [Hz]','FontSize',20);
ylabel('NPS - [dB]','FontSize',20);
title('Ruído de Fundo na Câmara Reverberante','FontSize',20);

% Grafico do erro da potencia
figure(7)
erro_potencia_reverberacao = nivel_potencia_sonora_reverberacao - nivel_potencia_sonora_referencia;
erro_potencia_anecoica = nivel_potencia_sonora_anecoica - nivel_potencia_sonora_referencia;
A = [erro_potencia_anecoica; erro_potencia_reverberacao]';
bar(A)
%ylim([0 115])
set(gca,'XTick',1:1:15)
set(gca,'XTickLabel',{'250', '315','400', '500','630', '800' ,'1k', '1.25k' ,'1.6k', '2k' ,'2.5k',...
'3.15k', '4k','5k','6.3k'},'FontSize',12)
xlabel('Frequência - [Hz]','FontSize',20)
ylabel('NWS - [dB]','FontSize',20)
title('Erro da Potência Sonora','FontSize',20)
k=legend('Erro Anecóica','Erro Reverberante');
set(k,'FontSize',20)

