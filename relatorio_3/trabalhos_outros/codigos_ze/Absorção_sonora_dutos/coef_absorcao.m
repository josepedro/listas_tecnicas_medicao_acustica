% Experimento 4 - Obtenção do coeficiente de absorção de materiais por meio 
% de um tubo de impedância.
% MATERIAL EM TESTE: lã de vivro verde.

%% Definição de Variáveis -------------------------------------------------
clear all; close all; clc
format longe
T = 25+273.15;                                                              % [K] - Temperatura do Ambiente de Medição
c0 = 343.2*sqrt(T/293);                                                     % [m/s] - Velocidade do Som no Ar
k = 0.5;                                                                    % Constante para o Cálculo da Freq. de Corte
di = 0.027;                                                                 % [m] - Diâmetro Interno do Tudo
x1 = 0.0673;                                                                % [m] - Distância do Microfone mais Distante à Amostra em Teste
s = 0.024;                                                                  % [m] - Distância entre os Dois Microfones
x2 = x1-s;                                                                  % [m] - Distância da Amostra ao Microfone mais Próximo

fc = (1.84*c0)/(pi*di)                                                      % [Hz] - Frequência de Corte do Tubo de Impedância, para esta Configuração de Teste.
fmax = 0.45*(c0/s)                                                          % [Hz] - Frequência Máxima de Trabalho
fmin = 0.05*(c0/s)                                                          % [Hz] - Frequência Mínima de Trabalho

%% Importação das FRFs H12_1 e H12_2 calculadas pelo software a partir das 
% pressões medidas (Partes Real e Imaginária) -----------------------------

dados_1 = load('LA_VIDRO_VERDE_H1_new.txt');
dados_2 = load('LA_VIDRO_VERDE_H2_new.txt');

%% Funções de Transferência e Coeficientes --------------------------------

Re_1 = dados_1(:,3);
Im_1 = dados_1(:,4);

Re_2 = dados_2(:,3);
Im_2 = dados_2(:,4);

% Vetor de Frequência
f = dados_1(:,2);

%  Primeira Função de Transferência H12_I

H_12_II = Re_1 + 1i*Im_1;

%  Segunda Função de Transferência H12_II

H_12_I = Re_2 + 1i*Im_2;

% Correção de fase entre os microfones, intercalando as duas medições 
% I e II de cada ensaio.

H_12 = ((H_12_I.^.5)./(H_12_II.^0.5));

% Cálculo das Funções de Transferência para o caso de ondas incidentes (H_I)
% e ondas refletidas (H_II).
k0 = (2*pi.*f)/c0;                                                          % Número de Onda Função da Freq.

H_Ii = exp(-1i*k0*(x1-x2));
H_Ri = exp(1i*k0*(x1-x2));

% Cálculo do Coeficiente de Reflexão

r1 = ((H_12-H_Ii)./(H_Ri-H_12)).*exp(2*1i*k0*x1);

% Cálculo do Coeficiente de Absorção da Lã de Vidro (verde)

a = 1 - (abs(r1)).^2;

%% Gráficos dos Coeficientes ----------------------------------------------

figure(1)
plot(f,a,'linewidth',2); grid on
xlabel('Frequência (Hz)')
ylabel('Coeficiente de Absorção \alpha')
xlim([0 10000]); ylim([0 1])

figure(2)
plot(f,abs(r),'--b',f,a,'-r','linewidth',2)
xlabel('Frequência (Hz)')
ylabel('Amplitude')
xlim([721 6491]); ylim([0 1]); grid
legend('r - Coeficiente de Reflexão','\alpha - Coeficiente de Absorção')
a=abs(H_12);
figure(3)
semilogy(f,a)


% figure(2)
% plot(f,H_12_I,'linewidth',2)



