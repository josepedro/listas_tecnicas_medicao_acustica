% codigo experimento relatorio 6
clear all; clc; close all;

% plotar funcao resposta em frequencia da viga e da placa
resultado_rfr = plotar_rfrs(viga, placa);

% amortecimento via decaimento de energia e banda de meia potencia
resultado_amortecimento = plotar_amortecimentos(placa);