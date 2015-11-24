clc; clear('all'); close all; format longe;

% codigo para processar os dados
% abrindo os arquivos
dados_ruido_fundo = textread('Dados_experimento_5/dados_ruido_fundo.txt');
dados_medicao = textread('Dados_experimento_5/dados_medicao.txt');
frequencias = dados_ruido_fundo(:, 1);
% dados do ruido de fundo
nivel_pressao_geradora_fundo = 10*log10(dados_ruido_fundo(:, 2)/(2e-5)^2);
nivel_pressao_receptora_fundo = 10*log10(dados_ruido_fundo(:, 4)/(2e-5)^2);
aceleracao_fundo = dados_ruido_fundo(:, 6);
% dados da medicao
nivel_pressao_geradora_medicao = 10*log10(dados_medicao(:, 2)/(2e-5)^2);
nivel_pressao_receptora_medicao = 10*log10(dados_medicao(:, 4)/(2e-5)^2);
aceleracao_medicao = dados_medicao(:, 6);
% dados de T60
dados_T_60 = textread('Dados_experimento_5/tempo_reverberacao_receptora.txt');
T_60 = dados_T_60(:, 2);

nivel_pressao_geradora_fundo = nivel_pressao_geradora_fundo(find(frequencias==100):find(frequencias==10000));
nivel_pressao_receptora_fundo = nivel_pressao_receptora_fundo(find(frequencias==100):find(frequencias==10000));
nivel_pressao_geradora_medicao = nivel_pressao_geradora_medicao(find(frequencias==100):find(frequencias==10000));
nivel_pressao_receptora_medicao = nivel_pressao_receptora_medicao(find(frequencias==100):find(frequencias==10000));
frequencias = frequencias(find(frequencias==100):find(frequencias==10000));

volume_camara = 199,10; % [m^3]
area_placa = 1.8*1.13; % [m^2]

figure(1);
subplot(2,1,1);
bar(nivel_pressao_geradora_fundo, 'blue'); hold on;
set(gca,'XTick',1:1:21);
set(gca,'XTickLabel',{'100' '125' '160' '200' '250', '315','400', '500','630', '800' ,'1k', '1.25k' ,'1.6k', '2k' ,'2.5k',...
'3.15k', '4k','5k','6.3k' '8k' '10k'},'FontSize',12);
xlabel('Frequencia - [Hz]','FontSize',20);
ylabel('NPS - [dB]','FontSize',20);
title('Nivel de Pressao Sonora Geradora Ruido de Fundo','FontSize',20);
axis([1 21 0 100]);

subplot(2,1,2);
bar(nivel_pressao_geradora_medicao, 'r'); hold on;
set(gca,'XTick',1:1:21);
set(gca,'XTickLabel',{'100' '125' '160' '200' '250', '315','400', '500','630', '800' ,'1k', '1.25k' ,'1.6k', '2k' ,'2.5k',...
'3.15k', '4k','5k','6.3k' '8k' '10k'},'FontSize',12);
xlabel('Frequencia - [Hz]','FontSize',20);
ylabel('NPS - [dB]','FontSize',20);
title('Nivel de Pressao Sonora Geradora Medicao','FontSize',20);
axis([1 21 0 100]);

figure(2);
subplot(2,1,1);
bar(nivel_pressao_receptora_fundo, 'blue'); hold on;
set(gca,'XTick',1:1:21);
set(gca,'XTickLabel',{'100' '125' '160' '200' '250', '315','400', '500','630', '800' ,'1k', '1.25k' ,'1.6k', '2k' ,'2.5k',...
'3.15k', '4k','5k','6.3k' '8k' '10k'},'FontSize',12);
xlabel('Frequencia - [Hz]','FontSize',20);
ylabel('NPS - [dB]','FontSize',20);
title('Nivel de Pressao Sonora Receptora Ruido de Fundo','FontSize',20);
axis([1 21 0 100]);

subplot(2,1,2);
bar(nivel_pressao_receptora_medicao, 'r'); hold on;
set(gca,'XTick',1:1:21);
set(gca,'XTickLabel',{'100' '125' '160' '200' '250', '315','400', '500','630', '800' ,'1k', '1.25k' ,'1.6k', '2k' ,'2.5k',...
'3.15k', '4k','5k','6.3k' '8k' '10k'},'FontSize',12);
xlabel('Frequencia - [Hz]','FontSize',20);
ylabel('NPS - [dB]','FontSize',20);
title('Nivel de Pressao Sonora Receptora Medicao','FontSize',20);
axis([1 21 0 100]);

% calcular os graficos
% de acordo com o trabalho do MARCOS SOUZA LENZI: MODELOS VIBROACÚSTICOS DE MÉDIAS E ALTAS FREQUÊNCIAS DE PAINÉIS AERONÁUTICOS DE COMPÓSITOS
% para calcular o A usou-se essa referencia:

coeficiente_absorcao = 0.161*volume_camara./T_60;
perda_transmissao = abs(nivel_pressao_receptora_medicao - nivel_pressao_geradora_medicao + 10*log10(area_placa./coeficiente_absorcao));
figure(3);
semilogx(frequencias, perda_transmissao);
%bar(perda_transmissao, 'green'); hold on;
%set(gca,'XTick',1:1:21);
%set(gca,'XTickLabel',{'100' '125' '160' '200' '250', '315','400', '500','630', '800' ,'1k', '1.25k' ,'1.6k', '2k' ,'2.5k',...
%'3.15k', '4k','5k','6.3k' '8k' '10k'},'FontSize',12);
xlabel('Frequencia - [Hz]','FontSize',20);
ylabel('NPS - [dB]','FontSize',20);
title('Perda de Transmissao','FontSize',20);
axis([0 10e3 0 50]);

% plotar os graficos