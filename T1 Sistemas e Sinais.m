%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1 - Prepara��o do c�digo 
%% 
%% Boas pr�ticas: limpeza de vari�veis; vari�veis globais
%% Constantes; carregar bibliotecas;...
%%
%%% Limpeza


clc;          % limpa o visual da tela de comandos
close all;    % limpa as figuras
clear all;    % limpa as vari�veis

display('1 - preparando o codigo...')

%%% Carregar bibliotecas

pkg load symbolic;  % biblioteca simb�lica

%%%omite mensagens de warning

warning('off');     %nao exibe os eventos de warnings



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 2 - Problema
%%
%% aproximar uma exponencial por uma s�rie exponencial de Fourier
%%
%% Definir a fun��o g(t) = exp(-t)

display('2 - definindo o sinal g(t)...')

%%% do problema a ser analisado

To = 1;   % per�odo da onda quadrada
to = 0;   % instante inicial de g(t)

%%% Par�metros calculados

fo = 1/To;    % frequ�ncia da onda quadrada
wo = 2*pi*fo; % frequ�ncia angular de g(t)

%%% fun��o g(t) te�rica

gtTeo = @(t) exp(-t);    % fun��o g(t) - handle

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  3 - calcular o valor de Dn - Fourier 
%% 
%%  Ambiente de c�lculo integral e simb�lico
%%  
%%  Symbolic pkg v2.9.0: 
%%  Python communication link active, SymPy v1.5.1.
%%
%%
%% Dn = 1/To int_0^To g(t) exp(-j n wo t) dt
%%
%% g(t) = exp(-t) - fun��o  a ser decomposta
%%

display('3 - S�rie de Fourier simb�lica ...')

syms n t  % t - tempo vari�vel simb�lica

%%% numerador de Dn - integral de Fourier

Inum  = int(exp(-(1+j*wo*n)*t),t,to,To+to);

%%% Determinando Dn

Dn = Inum/To;     % an�lise te�rica


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 4 - Analisando as proje��es e criando uma base de sinais ortogonais

n = [-1 +1];          % valores de n para an�lise da primeira harm�nica 

DnNum = eval(Dn);     % substitui os valores de 'n' em 'Dn'

%%% sintetizando a primeira harm�nica - p1(t)

M = 1000;                             % resolu��o do sinal
tempo = linspace(-To,To,M);          % intervalo de an�lise de M pontos 

p1 = DnNum(1)*exp(j*n(1)*wo*tempo) + DnNum(2)*exp(j*n(2)*wo*tempo);

%%% realizacao da comparacao da primeira harm�nica com o sinal te�rico

tempo1 = linspace(0,To,M/2);                     % vetor de tempo para o sinal te�rico

gtNum = [gtTeo(tempo1) gtTeo(tempo1)];           % o valor num�rico te�rico

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  5 - Visualizando a aproxima��o

figure(1)
plot(tempo,gtNum,'b..','linewidth',3);  % sinal te�rico
hold;
plot(tempo, p1,'k-','linewidth',3);     % sinal aproximado
xlabel('Tempo em segundos');            %
ylabel('Amplitude');                    %
title('Fun��o aproximada - comparacao') %
grid

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 6 - Analisando as proje��es

n = [-2 +2];          % valores de n para an�lise da primeira harm�nica 

DnNum = eval(Dn);     % substitui os valores de 'n' em 'Dn'

%%% sintetizando a primeira harm�nica - p2(t)

M = 1000;                             % resolu��o do sinal
tempo = linspace(-To,To,M);          % intervalo de an�lise de M pontos 

p2 = p1 + DnNum(1)*exp(j*n(1)*wo*tempo) + DnNum(2)*exp(j*n(2)*wo*tempo);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 7 - Visualizando a aproxima��o

figure(2)
plot(tempo,gtNum,'b..','linewidth',3);  % sinal te�rico
hold;
plot(tempo, p2,'k-','linewidth',3);     % sinal aproximado
xlabel('Tempo em segundos');            %
ylabel('Amplitude');                    %
title('Fun��o aproximada - comparacao') %
grid


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 8 - determinando a posicao pn(t) e o rn(t)
  N = 100;
n = [-N/2:N/2]; %valores do n para an�lise da segunda harm�nica

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
plot(tempo,gtNum,'b..','linewidth',3);  % sinal te�rico
hold;
plot(tempo, pn,'k-','linewidth',3);     % sinal aproximado
xlabel('Tempo em segundos');            %
ylabel('Amplitude');                    %
title('Sinal pn comparado ao sinal original') %
grid


figure(4)
plot(tempo,gtNum,'b..','linewidth',3);  % sinal te�rico
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