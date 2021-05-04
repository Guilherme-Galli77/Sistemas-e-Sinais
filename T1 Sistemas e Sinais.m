%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1 - Preparação do código 
%% 
%% Boas práticas: limpeza de variáveis; variáveis globais
%% Constantes; carregar bibliotecas;...
%%
%%% Limpeza


clc;          % limpa o visual da tela de comandos
close all;    % limpa as figuras
clear all;    % limpa as variáveis

display('1 - preparando o codigo...')

%%% Carregar bibliotecas

pkg load symbolic;  % biblioteca simbólica

%%%omite mensagens de warning

warning('off');     %nao exibe os eventos de warnings



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 2 - Problema
%%
%% aproximar uma exponencial por uma série exponencial de Fourier
%%
%% Definir a função g(t) = exp(-t)

display('2 - definindo o sinal g(t)...')

%%% do problema a ser analisado

To = 1;   % período da onda quadrada
to = 0;   % instante inicial de g(t)

%%% Parâmetros calculados

fo = 1/To;    % frequência da onda quadrada
wo = 2*pi*fo; % frequência angular de g(t)

%%% função g(t) teórica

gtTeo = @(t) exp(-t);    % função g(t) - handle

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  3 - calcular o valor de Dn - Fourier 
%% 
%%  Ambiente de cálculo integral e simbólico
%%  
%%  Symbolic pkg v2.9.0: 
%%  Python communication link active, SymPy v1.5.1.
%%
%%
%% Dn = 1/To int_0^To g(t) exp(-j n wo t) dt
%%
%% g(t) = exp(-t) - função  a ser decomposta
%%

display('3 - Série de Fourier simbólica ...')

syms n t  % t - tempo variável simbólica

%%% numerador de Dn - integral de Fourier

Inum  = int(exp(-(1+j*wo*n)*t),t,to,To+to);

%%% Determinando Dn

Dn = Inum/To;     % análise teórica


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 4 - Analisando as projeções e criando uma base de sinais ortogonais

n = [-1 +1];          % valores de n para análise da primeira harmônica 

DnNum = eval(Dn);     % substitui os valores de 'n' em 'Dn'

%%% sintetizando a primeira harmônica - p1(t)

M = 1000;                             % resolução do sinal
tempo = linspace(-To,To,M);          % intervalo de análise de M pontos 

p1 = DnNum(1)*exp(j*n(1)*wo*tempo) + DnNum(2)*exp(j*n(2)*wo*tempo);

%%% realizacao da comparacao da primeira harmônica com o sinal teórico

tempo1 = linspace(0,To,M/2);                     % vetor de tempo para o sinal teórico

gtNum = [gtTeo(tempo1) gtTeo(tempo1)];           % o valor numérico teórico

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  5 - Visualizando a aproximação

figure(1)
plot(tempo,gtNum,'b..','linewidth',3);  % sinal teórico
hold;
plot(tempo, p1,'k-','linewidth',3);     % sinal aproximado
xlabel('Tempo em segundos');            %
ylabel('Amplitude');                    %
title('Função aproximada - comparacao') %
grid

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 6 - Analisando as projeções

n = [-2 +2];          % valores de n para análise da primeira harmônica 

DnNum = eval(Dn);     % substitui os valores de 'n' em 'Dn'

%%% sintetizando a primeira harmônica - p2(t)

M = 1000;                             % resolução do sinal
tempo = linspace(-To,To,M);          % intervalo de análise de M pontos 

p2 = p1 + DnNum(1)*exp(j*n(1)*wo*tempo) + DnNum(2)*exp(j*n(2)*wo*tempo);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 7 - Visualizando a aproximação

figure(2)
plot(tempo,gtNum,'b..','linewidth',3);  % sinal teórico
hold;
plot(tempo, p2,'k-','linewidth',3);     % sinal aproximado
xlabel('Tempo em segundos');            %
ylabel('Amplitude');                    %
title('Função aproximada - comparacao') %
grid


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 8 - determinando a posicao pn(t) e o rn(t)
  N = 100;
n = [-N/2:N/2]; %valores do n para análise da segunda harmônica

DnNum = eval(Dn); % realiza a substituicao dos valores do 'n' em 'Dn'

pn = 0 %Declara o pn
tempo = linspace(0, To, M); %dominio

for k = 1 : N 
  pn = pn + DnNum(k)*exp(j*wo*tempo*n(k)); 
end
  
  rn = gtNum - pn
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 9 - Plotando os graficos comparativos de pn e rn


figure(3)
plot(tempo,gtNum,'b..','linewidth',3);  % sinal teórico
hold;
plot(tempo, pn,'k-','linewidth',3);     % sinal aproximado
xlabel('Tempo em segundos');            %
ylabel('Amplitude');                    %
title('Sinal pn comparado ao sinal original') %
grid


figure(4)
plot(tempo,gtNum,'b..','linewidth',3);  % sinal teórico
hold;
plot(tempo, rn,'k-','linewidth',3);     % sinal aproximado
xlabel('Tempo em segundos');            %
ylabel('Amplitude');                    %
title('Sinal rn(residuo) comparado ao sinal original') %
grid

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 10 - Plotando os graficos comparativos de p1,p2,pn e r1,r2,rn

r1 = gtNum - p1    %%Calculo residuo r1 --> p1
r2 = gtNum - p2    %%Calculo residuo r2 --> p2

%%GRAFICO 1 p1 e r1%%
figure(5)

subplot(2,1,1);                         %% realiza a divisao da figura em duas linhas
plot(tempo,gtNum, 'b..', 'linewidth',3);
hold;
plot(tempo,p1, 'g-.', 'linewidth',3);
xlabel('Tempo (em segundos)');
ylabel('Amplitude (em volts)');
title('Sinal sintetizado e original(p1)')
grid

subplot(2,1,2);                         %% realiza a divisao da figura em duas linhas
plot(tempo,r1, 'k-', 'linewidth',3);
xlabel('Tempo (em segundos)');
ylabel('Amplitude (em volts)');
title('Sinal do residuo(r1)')

%%GRAFICO 2 p2 e r2%%

figure(6)

subplot(2,1,1);                         %% realiza a divisao da figura em duas linhas
plot(tempo,gtNum, 'b..', 'linewidth',3);
hold;
plot(tempo,p2, 'g-.', 'linewidth',3);
xlabel('Tempo (em segundos)');
ylabel('Amplitude (em volts)');
title('Sinal sintetizado e original(p2)')
grid

subplot(2,1,2);                         %% realiza a divisao da figura em duas linhas
plot(tempo,r2, 'k-', 'linewidth',3);
xlabel('Tempo (em segundos)');
ylabel('Amplitude (em volts)');
title('Sinal do residuo (r2)')
grid

%%GRAFICO 3 pn e rn%%

figure(7)

subplot(2,1,1);                          %% realiza a divisao da figura em duas linhas
plot(tempo,gtNum, 'b..', 'linewidth',3);
hold;
plot(tempo,pn, 'g-.', 'linewidth',3);
xlabel('Tempo (em segundos)');
ylabel('Amplitude (em volts)');
title('Sinal sintetizado e original(pn)')
grid

subplot(2,1,2);                          %% realiza a divisao da figura em duas linhas
plot(tempo,rn, 'k-', 'linewidth',3);
xlabel('Tempo (em segundos)');
ylabel('Amplitude (em volts)');
title('Sinal do residuo (rn)')
grid