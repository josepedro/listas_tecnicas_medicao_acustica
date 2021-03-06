clear all; clc; close all
%% RELAT�RIO 3 - ME (4 BIMESTRE)
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
distancia_microfones = 24/1000; %Dist�ncia entre os dois microfones
distancia_mic2_final = distancia_microfones + 39.5/1000; %Dist�ncia do microfone 2 at� o final do duto
diametro_tubo = 0.027;
f = laderocha1_pos1(:,2);
co = 343; k = 2*pi*f;
frequencia_corte = ((1.84*co)/(pi*diametro_tubo));
frequencia_maxima = 0.45*((co)/(distancia_microfones));
% CALCULO DE COEFICIENTES
for n=1:3  
  eval(['H12r_',num2str(n),'=(laderocha',num2str(n),'_pos1(:,3)./laderocha',num2str(n),'_pos2(:,3));'])  
  eval(['H12i_',num2str(n),'=(laderocha',num2str(n),'_pos1(:,4)./laderocha',num2str(n),'_pos2(:,4));']) 
  eval(['H12_',num2str(n),'= sqrt(H12r_',num2str(n),'+ 1j*H12i_',num2str(n),');'])
end

