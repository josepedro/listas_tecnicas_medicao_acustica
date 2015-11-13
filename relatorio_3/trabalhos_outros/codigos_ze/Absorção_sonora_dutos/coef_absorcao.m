% Experimento 4 - Obten��o do coeficiente de absor��o de materiais por meio 
% de um tubo de imped�ncia.
% MATERIAL EM TESTE: l� de vivro verde.

%% Defini��o de Vari�veis -------------------------------------------------
clear all; close all; clc
format longe
T = 25+273.15;                                                              % [K] - Temperatura do Ambiente de Medi��o
c0 = 343.2*sqrt(T/293);                                                     % [m/s] - Velocidade do Som no Ar
k = 0.5;                                                                    % Constante para o C�lculo da Freq. de Corte
di = 0.027;                                                                 % [m] - Di�metro Interno do Tudo
x1 = 0.0673;                                                                % [m] - Dist�ncia do Microfone mais Distante � Amostra em Teste
s = 0.024;                                                                  % [m] - Dist�ncia entre os Dois Microfones
x2 = x1-s;                                                                  % [m] - Dist�ncia da Amostra ao Microfone mais Pr�ximo

fc = (1.84*c0)/(pi*di)                                                      % [Hz] - Frequ�ncia de Corte do Tubo de Imped�ncia, para esta Configura��o de Teste.
fmax = 0.45*(c0/s)                                                          % [Hz] - Frequ�ncia M�xima de Trabalho
fmin = 0.05*(c0/s)                                                          % [Hz] - Frequ�ncia M�nima de Trabalho

%% Importa��o das FRFs H12_1 e H12_2 calculadas pelo software a partir das 
% press�es medidas (Partes Real e Imagin�ria) -----------------------------

dados_1 = load('LA_VIDRO_VERDE_H1_new.txt');
dados_2 = load('LA_VIDRO_VERDE_H2_new.txt');

%% Fun��es de Transfer�ncia e Coeficientes --------------------------------

Re_1 = dados_1(:,3);
Im_1 = dados_1(:,4);

Re_2 = dados_2(:,3);
Im_2 = dados_2(:,4);

% Vetor de Frequ�ncia
f = dados_1(:,2);

%  Primeira Fun��o de Transfer�ncia H12_I

H_12_II = Re_1 + 1i*Im_1;

%  Segunda Fun��o de Transfer�ncia H12_II

H_12_I = Re_2 + 1i*Im_2;

% Corre��o de fase entre os microfones, intercalando as duas medi��es 
% I e II de cada ensaio.

H_12 = ((H_12_I.^.5)./(H_12_II.^0.5));

% C�lculo das Fun��es de Transfer�ncia para o caso de ondas incidentes (H_I)
% e ondas refletidas (H_II).
k0 = (2*pi.*f)/c0;                                                          % N�mero de Onda Fun��o da Freq.

H_Ii = exp(-1i*k0*(x1-x2));
H_Ri = exp(1i*k0*(x1-x2));

% C�lculo do Coeficiente de Reflex�o

r1 = ((H_12-H_Ii)./(H_Ri-H_12)).*exp(2*1i*k0*x1);

% C�lculo do Coeficiente de Absor��o da L� de Vidro (verde)

a = 1 - (abs(r1)).^2;

%% Gr�ficos dos Coeficientes ----------------------------------------------

figure(1)
plot(f,a,'linewidth',2); grid on
xlabel('Frequ�ncia (Hz)')
ylabel('Coeficiente de Absor��o \alpha')
xlim([0 10000]); ylim([0 1])

figure(2)
plot(f,abs(r),'--b',f,a,'-r','linewidth',2)
xlabel('Frequ�ncia (Hz)')
ylabel('Amplitude')
xlim([721 6491]); ylim([0 1]); grid
legend('r - Coeficiente de Reflex�o','\alpha - Coeficiente de Absor��o')
a=abs(H_12);
figure(3)
semilogy(f,a)


% figure(2)
% plot(f,H_12_I,'linewidth',2)



