clc; clear('all'); close all; format longe;

% codigo para processar os dados
% abrindo os arquivos
dados_ruido_fundo = textread('Dados_experimento_5/dados_ruido_fundo.txt');
dados_medicao = textread('Dados_experimento_5/dados_medicao.txt');
frequencias = dados_ruido_fundo(:, 1);
% dados do ruido de fundo
nivel_pressao_geradora_fundo = 20*log10(dados_ruido_fundo(:, 2)/(2e-5));
nivel_pressao_receptora_fundo = 20*log10(dados_ruido_fundo(:, 4)/(2e-5));
aceleracao_fundo = dados_ruido_fundo(:, 6);
% dados da medicao
nivel_pressao_geradora_medicao = 20*log10(dados_medicao(:, 2)/(2e-5));
nivel_pressao_receptora_medicao = 20*log10(dados_medicao(:, 4)/(2e-5));
aceleracao_gravidade = 9.795;
aceleracao_referencia = 10e-6/aceleracao_gravidade;
aceleracao_medicao = 20*log10(dados_medicao(:, 6)/aceleracao_referencia);
% dados de T60
dados_T_60 = textread('Dados_experimento_5/tempo_reverberacao_receptora.txt');
T_60 = dados_T_60(:, 2);

nivel_pressao_geradora_fundo = nivel_pressao_geradora_fundo(find(frequencias==100):find(frequencias==10000));
nivel_pressao_receptora_fundo = nivel_pressao_receptora_fundo(find(frequencias==100):find(frequencias==10000));
nivel_pressao_geradora_medicao = nivel_pressao_geradora_medicao(find(frequencias==100):find(frequencias==10000));
nivel_pressao_receptora_medicao = nivel_pressao_receptora_medicao(find(frequencias==100):find(frequencias==10000));
aceleracao_medicao = aceleracao_medicao(find(frequencias==100):find(frequencias==10000));
frequencias = frequencias(find(frequencias==100):find(frequencias==10000));

volume_camara = 199.10; % [m^3]
area_placa = 1.8*1.13; % [m^2]

figure(1);
%subplot(2,1,1);
%subplot(2,1,2);
bar(nivel_pressao_geradora_medicao, 'r'); hold on;
set(gca,'XTick',1:1:21);
set(gca,'XTickLabel',{'100' '125' '160' '200' '250', '315','400', '500','630', '800' ,'1k', '1.25k' ,'1.6k', '2k' ,'2.5k',...
'3.15k', '4k','5k','6.3k' '8k' '10k'},'FontSize',12);
xlabel('Frequencia - [Hz]','FontSize',20);
ylabel('NPS - [dB]','FontSize',20);
title('Nivel de Pressao Sonora da Camara Geradora de Ruido','FontSize',20);
%ylim([0 100]);
axis([0 22 0 100]);
bar(nivel_pressao_geradora_fundo, 'blue'); hold on;
set(gca,'XTick',1:1:21);
set(gca,'XTickLabel',{'100' '125' '160' '200' '250', '315','400', '500','630', '800' ,'1k', '1.25k' ,'1.6k', '2k' ,'2.5k',...
'3.15k', '4k','5k','6.3k' '8k' '10k'},'FontSize',12);
xlabel('Frequencia - [Hz]','FontSize',20);
ylabel('NPS - [dB]','FontSize',20);
%title('Nivel de Pressao Sonora Geradora Ruido de Fundo','FontSize',20);
axis([1 21 0 100]);
legend('Com ruido branco.', 'Somente ruido de fundo.');


figure(2);
%subplot(2,1,1);
%subplot(2,1,2);
bar(nivel_pressao_receptora_medicao, 'r'); hold on;
set(gca,'XTick',1:1:21);
set(gca,'XTickLabel',{'100' '125' '160' '200' '250', '315','400', '500','630', '800' ,'1k', '1.25k' ,'1.6k', '2k' ,'2.5k',...
'3.15k', '4k','5k','6.3k' '8k' '10k'},'FontSize',12);
xlabel('Frequencia - [Hz]','FontSize',20);
ylabel('NPS - [dB]','FontSize',20);
title('Nivel de Pressao Sonora da Camara Receptora de Ruido','FontSize',20);
axis([1 21 0 100]);
bar(nivel_pressao_receptora_fundo, 'blue'); hold on;
set(gca,'XTick',1:1:21);
set(gca,'XTickLabel',{'100' '125' '160' '200' '250', '315','400', '500','630', '800' ,'1k', '1.25k' ,'1.6k', '2k' ,'2.5k',...
'3.15k', '4k','5k','6.3k' '8k' '10k'},'FontSize',12);
xlabel('Frequencia - [Hz]','FontSize',20);
ylabel('NPS - [dB]','FontSize',20);
legend('Com ruido branco.', 'Somente ruido de fundo.');
%title('Nivel de Pressao Sonora Receptora Ruido de Fundo','FontSize',20);
axis([1 21 0 100]);

% calcular os graficos
% de acordo com o trabalho do MARCOS SOUZA LENZI: MODELOS VIBROACÚSTICOS DE MÉDIAS E ALTAS FREQUÊNCIAS DE PAINÉIS AERONÁUTICOS DE COMPÓSITOS
% para calcular o A usou-se essa referencia:

%% calculo usando o tempo de reverberacao
coeficiente_absorcao = 0.161*volume_camara./T_60;
perda_transmissao_tempo_reverberacao = nivel_pressao_geradora_medicao - ... 
nivel_pressao_receptora_medicao + 10*log10(area_placa./coeficiente_absorcao);
%% calculo usando a comparacao da fonte 
fonte = textread('Dados_experimento_5/fonte.txt');
frequencias_fonte = fonte(:, 1);
potencia_fonte = fonte(:, 2);
potencia_fonte = potencia_fonte(find(frequencias_fonte==100):find(frequencias_fonte==10000));
nivel_pressao_fonte = fonte(:, 3);
nivel_pressao_fonte = nivel_pressao_fonte(find(frequencias_fonte==100):find(frequencias_fonte==10000));
coeficiente_absorcao = 10.^((6.2 + potencia_fonte - nivel_pressao_fonte)/10);
perda_transmissao_comparacao = nivel_pressao_geradora_medicao - ... 
nivel_pressao_receptora_medicao + 10*log10(area_placa./coeficiente_absorcao);
figure(3);
semilogx(frequencias, perda_transmissao_tempo_reverberacao, 'red', frequencias, perda_transmissao_comparacao, 'blue');
%bar(perda_transmissao, 'green'); hold on;
%set(gca,'XTick',1:1:21);
%set(gca,'XTickLabel',{'100' '125' '160' '200' '250', '315','400', '500','630', '800' ,'1k', '1.25k' ,'1.6k', '2k' ,'2.5k',...
%'3.15k', '4k','5k','6.3k' '8k' '10k'},'FontSize',12);
xlabel('Frequencia - [Hz]','FontSize',20);
ylabel('NPS - [dB]','FontSize',20);
title('Perda de Transmissao','FontSize',20);
axis([0 10e3 0 50]);
legend('Metodo direto.', 'Metodo por comparacao (indireto).');

figure(4);
semilogx(frequencias, aceleracao_medicao, 'green'); hold on;
xlabel('Frequencia - [Hz]','FontSize',20);
ylabel('G - [dB]','FontSize',20);
title('Sinal do Acelerometro','FontSize',20);
%axis([1 21 0 100]);
% plotar os graficos