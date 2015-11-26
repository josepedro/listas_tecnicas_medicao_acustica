clear all; close all; clc
%% RELAT�RIO 5 - PERDA DE TRANSMISS�O SONORA (ELEMENTOS CONSTRUTIVOS)
%% ALUNO: HENRIQUE ALENDE DA SILVEIRA
load dados
load fonte_referencia
altura_placa = 1800/1000;
largura_placa = 1130/1000;
espessura_placa = 2/1000;
S = altura_placa*largura_placa;
massa = 15;
pressao_referencia=2e-5;
frequencia=dados(4:end-1,1);
pressao_emissao = dados(4:end-1,2);
NPS_emissao = 20*log10(pressao_emissao./pressao_referencia);
pressao_recepcao = dados(4:end-1,4); 
NPS_recepcao =20*log10(pressao_recepcao./pressao_referencia);

%% CALCULO DE A (�REA DE ABSOR��O EQUIVALENTE)
NWS_referencia = fonte_referencia(:,2);
NPS_referencia = fonte_referencia(:,3);
K = NPS_referencia - NWS_referencia;
A = ((4)./(10.^((K)./(10))));
%% LEI DA MASSA
PT_lei_da_massa=20*log10(frequencia.*(massa/S))-47.3;
%% PERDA DE TRANSMISSAO SONORA
PT = NPS_emissao - NPS_recepcao + 10*log10(S./A);
plot(PT,'LineWidth',2);hold on
plot(PT_lei_da_massa,'r--','LineWidth',2)
xlabel('Frequ�ncia','FontSize',20)
ylabel('PT (dB)','FontSize',20)
title('Perda de Transmiss�o Sonora - Placa Alum�nio','FontSize',20)
set(gca,'XTick',1:1:24)
set(gca,'XTickLabel',{'50','63','80','100','125', '160', '200', '250', '315',...
 '400', '500','630', '800' ,'1k', '1.25k' ,'1.6k', '2k' ,'2.5k',...
'3.15k', '4k','5k','6.3k','8k','10k'},'FontSize',12)
k=legend('Experimental','Anal�tico (Lei da Massa)');
set(k,'FontSize',24)
