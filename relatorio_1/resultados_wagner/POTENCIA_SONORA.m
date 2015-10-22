clc; clear all; close all

%% POTÊNCIA SONORA - CAMARA SEMI-ANECÓICA
% Média entre as pressões sonoras da câmara anecóica
load P1;load P2; load NWS_Ref
f = P1(:,1);
prms1=(mean(P1(:,2:2:end).^(2),2));
prms2=(mean(P2(:,2:2:end).^(2),2));
prms = mean([prms1 prms2],2);
Qo=2;
r=1;
NPS_A = 10*log10(prms(11:end)/(2e-5)^2);
NWS_A = NPS_A-10*log10((Qo)/(4*pi*r^(2)));



%% POTENCIA SONORA - CAMARA REVERBERANTE 
load TR_RV 
load p_R % pressao na reverberativa
NPS_R = 20*log10((p_R)./(2e-5));
St =[203.37 187.26]; % Area de todas as paredes da camara reverberacao
V =[189.15 144.18];  % Volume
for n = 1:2
	alpha_e(:,n) = 1 - exp((-0.161*V(n))./(TR_RV*St(n)));
	alpha_s(:,n) = ((0.161*V(n))./(TR_RV*St(n)));
	NWS_R(:,n)=NPS_R(11:end,2)-10*log10((4*(1-alpha_s(:,n)))./(St(n).*alpha_s(:,n)));
end


%bar([NWS_R(:,2) NWS_Ref])

%% PLOTS
figure(1)
bar(NPS_A); hold on
set(gca,'XTick',1:1:15)
set(gca,'XTickLabel',{'250', '315','400', '500','630', '800' ,'1k', '1.25k' ,'1.6k', '2k' ,'2.5k',...
'3.15k', '4k','5k','6.3k'},'FontSize',12)
xlabel('Frequência - [Hz]','FontSize',20)
ylabel('NPS - [dB]','FontSize',20)
title('Nível de Pressão Sonora da Câmara Anecóica','FontSize',20)

figure(2)
bar(NPS_R(11:end,1)); hold on
set(gca,'XTick',1:1:15)
set(gca,'XTickLabel',{'250', '315','400', '500','630', '800' ,'1k', '1.25k' ,'1.6k', '2k' ,'2.5k',...
'3.15k', '4k','5k','6.3k'},'FontSize',12)
xlabel('Frequência - [Hz]','FontSize',20)
ylabel('NPS - [dB]','FontSize',20)
title('Nível de Pressão Sonora da Câmara Reverberante','FontSize',20)


figure(3)
bar([NWS_A NWS_R(:,1) NWS_Ref])
ylim([0 115])
set(gca,'XTick',1:1:15)
set(gca,'XTickLabel',{'250', '315','400', '500','630', '800' ,'1k', '1.25k' ,'1.6k', '2k' ,'2.5k',...
'3.15k', '4k','5k','6.3k'},'FontSize',12)
xlabel('Frequência - [Hz]','FontSize',20)
ylabel('NWS - [dB]','FontSize',20)
title('Nível de Potência Sonora','FontSize',20)
k=legend('Med. Câmara Anecóica','Med. Câmara Reverberação','Fonte de Referência');
set(k,'FontSize',20)

figure(4)
bar([alpha_s(:,1) alpha_e(:,1)])
set(gca,'XTick',1:1:15)
set(gca,'XTickLabel',{'250', '315','400', '500','630', '800' ,'1k', '1.25k' ,'1.6k', '2k' ,'2.5k',...
'3.15k', '4k','5k','6.3k'},'FontSize',12)
xlabel('Frequência - [Hz]','FontSize',20)
ylabel('C. Absorção \alpha','FontSize',20)
title('C. Aborção Câmara Anecóica','FontSize',20)
k=legend('Sabine','Eyring');
set(k,'FontSize',20)
ylim([0 0.09])



