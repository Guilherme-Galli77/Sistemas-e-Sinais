%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  0 -  Proposta de trabalho%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  a.- Analisar as cinco vogais: Xa, Xe, Xi, Xo, e Xu.%%%%  Questao foi respondida no codigo%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  b.- Os tempos de execucao de cada vogal.%%%% APOS ALGUMAS TENTATIVAS FOI POSSIVEL EXECUTAR O CODIGO NO OCTAVE%% DESKTOP, NO ENTANTO O TEMPO TOTAL DE EXECUCAO FOI MUITO ALTO:%%%% Para a vogal A o tempo obtido foi:%% Elapsed time is 241.788 seconds.%%%% Para a vogal E o tempo obtido foi:%% Elapsed time is 331.955 seconds.%%%% Para a vogal I o tempo obtido foi:%% Elapsed time is 161.654 seconds.%%%% Para a vogal O o tempo obtido foi:%% Elapsed time is 200.256 seconds.%%%% Para a vogal U o tempo obtido foi:%% Elapsed time is 487.837 seconds.%%%% Para o sinal de referencia F o tempo obtido foi:%% Elapsed time is 0.109294 seconds.%%%%PARA UMA VISUALIZACAO MAIS RAPIDA DOS GRAFICOS EU ANEXEI UM PDF JUNTO%%AO CODIGO .M NO MOODLE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  c.- O que voce observa de diferente em cada serie de Fourier.%%%% Apos a analise das vogais e do sinal de refencia foi possivel concluir%% que a vogal 'U' possui o maior tempo de execucao de todos,ja o sinal%% de refencia tende a ser mais rapido devido ao fato de nao se trabalhar%% com um arquivo .wav. Analisando os graficos foi possivel observar o%% comportamento de cada vogal e suas peculiaridades,bem como a visivel%% diferenca do sinal de referencia para as vogais,alem da alta amplitude%% proximo ao 0 Hz no sinal da letra I,caracteristica que a difere das%% outras vogais.%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  d.- Voce conseguiria analisar no tempo?%%%% Sim,pois ocorre que o Octave nos fornece pontos que variam com um periodo fixo%% e com o conhecimento de qual � esse periodo,acaba sendo possivel realizar a%% analise no tempo.%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  e.- Como voce transformaria o "for" em produto matricial como foi feito na teoria?%%%%  O CALCULO A SEGUIR PODE SER APLICADO A QUALQUER UMA DAS VOGAIS (UTILIZEI O 'X' %%  COMO VARIAVEL GENERICA E TAMBEM SUBSTITUINDO O N COMO CONTADOR)%%  AO UTILIZAR O PRODUTO MATRICIAL O CODIGO TENDE A SER EXECUTADO%%  COM UMA VELOCIDADE MAIOR.%%%%  WX = exp(-j*2*pi/X);%%  MatrizJ = WX * ones(X,X);%%  MatrizxK = [0:1:X-1]'* [0:1:X-1]%%  MatrizFourrier = MatrizJ.^MatrizxK;%%  XnMF = MatrizFourrier*gkX;%%  XnMF = fftshift(XnMF/X);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1 - Prepara��o do c�digo %% %% Boas pr�ticas: limpeza de vari�veis; vari�veis globais%% Constantes; carregar bibliotecas;...%%%%% Limpezaclc;          % limpa visual da tela de comandosclose all;    % limpa as figurasclear all;    % limpa as vari�veis%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 2 - Problema%%%% %% sinal g(k) - sinal amostrado%%%% criacao de dois sinais amostrados,sendo:%%%%%% sinal de refer�ncia - artificial%% com senoides%% OBS: VARIAVEIS NOMEADAS COM F no final para evitar conflitosfsF = 10;                           % frequ�ncia de amostragemfoF = 1 ;                           % frequ�ncia da senoide - m�ximo de 5HzToF = 1/foF;                         % per�odo da senoidewoF = 2*pi*foF;                      % frequ�ncia angularNpF = 10;                           % n�mero de per�odostF  = linspace(0,NpF*ToF,NpF*fsF);      % tempo de sintesegkF = 1 + cos(2*pi*tF);              % criei uma senoide artificial%%% Visualiza��ofigure(1)stem(tF,gkF,'k-','linewidth',3)         % configura plot(x,y, cor azul e linha cheia)xlabel('Tempo em segundos')           % tempo em segundosylabel('Amplitude')                   % amplitude em voltstitle('Sinal g(k) sintetizado')       % t�tulogrid%%%% sinal a ser trabalhado - gk --> Analise utilizando todas as vogais%% OBS: caso necessario utilize %% para comentar as vogais que nao quer exibir[gkA,fsA] = audioread('a.wav');     % leitura de um sinal real - vogal /a/.[gkE,fsE] = audioread('e.wav');     % leitura de um sinal real - vogal /e/.[gkI,fsI] = audioread('i.wav');     % leitura de um sinal real - vogal /i/.[gkO,fsO] = audioread('o.wav');     % leitura de um sinal real - vogal /o/.[gkU,fsU] = audioread('u.wav');     % leitura de um sinal real - vogal /u/.%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3- Pre processamento do sinal para as vogais%%%%  Ambiente de c�lculo integral e simb�lico%%%%%%  considerando que as variaveis alteram conforme a vogal%%  Ex: NA,gkE,wsU,etc...%%%%  X[n] = 1/N somatoria_{k=0}^{N-1} g(k) exp(-j*n*k*2*pi/N)%%%%%%%%                       PARA A VOGAL ANA         = length(gkA);               % n�mero de pontos de g(k)TsA        = 1/fsA;                     % Taxa de amostragemDuracaoA   = NA*TsA;                    % dura��o do sinal g(k)wsA        = 2*pi*fsA;                  % frequencia angulartempoA     = linspace(0,DuracaoA,NA);   % vetor tempo computacionalfmaxA       = fsA/2;                        % frequ�ncia m�ximafrequenciaA = linspace(-fmaxA,fmaxA,NA);    % frequ�ncias de interesse    %%                       PARA A VOGAL ENE         = length(gkE);               % n�mero de pontos de g(k)TsE        = 1/fsE;                     % Taxa de amostragemDuracaoE   = NE*TsE;                    % dura��o do sinal g(k)wsE        = 2*pi*fsE;                  % frequencia angulartempoE     = linspace(0,DuracaoE,NE);   % vetor tempo computacionalfmaxE       = fsE/2;                        % frequ�ncia m�ximafrequenciaE = linspace(-fmaxE,fmaxE,NE);    % frequ�ncias de interesse%%                       PARA A VOGAL INI         = length(gkI);               % n�mero de pontos de g(k)TsI        = 1/fsI;                     % Taxa de amostragemDuracaoI   = NI*TsI;                    % dura��o do sinal g(k)wsI        = 2*pi*fsI;                  % frequencia angulartempoI     = linspace(0,DuracaoI,NI);   % vetor tempo computacionalfmaxI       = fsI/2;                        % frequ�ncia m�ximafrequenciaI = linspace(-fmaxI,fmaxI,NI);    % frequ�ncias de interesse%%                       PARA A VOGAL ONO         = length(gkO);               % n�mero de pontos de g(k)TsO        = 1/fsO;                     % Taxa de amostragemDuracaoO   = NO*TsO;                    % dura��o do sinal g(k)wsO        = 2*pi*fsO;                  % frequencia angulartempoO     = linspace(0,DuracaoO,NO);   % vetor tempo computacionalfmaxO       = fsO/2;                        % frequ�ncia m�ximafrequenciaO = linspace(-fmaxO,fmaxO,NO);    % frequ�ncias de interesse%%                       PARA A VOGAL UNU         = length(gkU);               % n�mero de pontos de g(k)TsU        = 1/fsU;                     % Taxa de amostragemDuracaoU   = NU*TsU;                    % dura��o do sinal g(k)wsU        = 2*pi*fsU;                  % frequencia angulartempoU     = linspace(0,DuracaoU,NU);   % vetor tempo computacionalfmaxU       = fsU/2;                        % frequ�ncia m�ximafrequenciaU = linspace(-fmaxU,fmaxU,NU);    % frequ�ncias de interesse%%                      PARA O SINAL DE REFERENCIA FNF         = length(gkF);               % n�mero de pontos de g(k)TsF        = 1/fsF;                     % Taxa de amostragemDuracaoF   = NF*TsF;                    % dura��o do sinal g(k)wsF        = 2*pi*fsF;                  % frequencia angulartempoF     = linspace(0,DuracaoF,NF);   % vetor tempo computacionalfmaxF       = fsF/2;                        % frequ�ncia m�ximafrequenciaF = linspace(-fmaxF,fmaxF,NF);    % frequ�ncias de interesse%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 4 -  C�clculo de X(n) para diferentes vogais%%  %%  X[n] = 1/N somatoria_{k=0}^{N-1} g(k) exp(-j*n*k*2*pi/N)%%%%                       PARA A VOGAL A%%% primeira forma: utilizando estrutura fortic;                                    % inicia um contator de tempofor nA = 0 : NA-1                          % N pontos     aux_kA = 0;                           % valor inicial de aux_k       for kA = 0 : NA-1                     % lendo N pontos                                        % 1 : N --> octave                                        % +1 transformo a vari�vel matem�tica em �ndice                                        % determina a se'rie discreta de Fourier        aux_kA = aux_kA + gkA(kA+1)*exp(-j*nA*kA*2*pi/NA);        end        XnA(nA+1) = aux_kA/NA;    end    toc;                                    % determina o tempo decorrido%%                       PARA A VOGAL E%%% primeira forma: utilizando estrutura fortic;                                    % inicia um contator de tempofor nE = 0 : NE-1                          % N pontos     aux_kE = 0;                           % valor inicial de aux_k       for kE = 0 : NE-1                     % lendo N pontos                                        % 1 : N --> octave                                        % +1 transformo a vari�vel matem�tica em �ndice                                        % determina a se'rie discreta de Fourier        aux_kE = aux_kE + gkE(kE+1)*exp(-j*nE*kE*2*pi/NE);        end        XnE(nE+1) = aux_kE/NE;    end    toc;                                    % determina o tempo decorrido%%                       PARA A VOGAL I%%% primeira forma: utilizando estrutura fortic;                                    % inicia um contator de tempofor nI = 0 : NI-1                          % N pontos     aux_kI = 0;                           % valor inicial de aux_k       for kI = 0 : NI-1                     % lendo N pontos                                        % 1 : N --> octave                                        % +1 transformo a vari�vel matem�tica em �ndice                                        % determina a se'rie discreta de Fourier        aux_kI = aux_kI + gkI(kI+1)*exp(-j*nI*kI*2*pi/NI);        end        XnI(nI+1) = aux_kI/NI;    end    toc;                                    % determina o tempo decorrido%%                       PARA A VOGAL O%%% primeira forma: utilizando estrutura fortic;                                    % inicia um contator de tempofor nO = 0 : NO-1                          % N pontos     aux_kO = 0;                           % valor inicial de aux_k       for kO = 0 : NO-1                     % lendo N pontos                                        % 1 : N --> octave                                        % +1 transformo a vari�vel matem�tica em �ndice                                        % determina a se'rie discreta de Fourier        aux_kO = aux_kO + gkO(kO+1)*exp(-j*nO*kO*2*pi/NO);        end        XnO(nO+1) = aux_kO/NO;    end    toc;                                    % determina o tempo decorrido%%                       PARA A VOGAL U%%% primeira forma: utilizando estrutura fortic;                                    % inicia um contator de tempofor nU = 0 : NU-1                          % N pontos     aux_kU = 0;                           % valor inicial de aux_k       for kU = 0 : NU-1                     % lendo N pontos                                        % 1 : N --> octave                                        % +1 transformo a vari�vel matem�tica em �ndice                                        % determina a se'rie discreta de Fourier        aux_kU = aux_kU + gkU(kU+1)*exp(-j*nU*kU*2*pi/NU);        end        XnU(nU+1) = aux_kU/NU;    end    toc;                                    % determina o tempo decorrido%%                       PARA SINAL DE REFERENCIA F%%% primeira forma: utilizando estrutura fortic;                                    % inicia um contator de tempofor nF = 0 : NF-1                          % N pontos     aux_kF = 0;                           % valor inicial de aux_k       for kF = 0 : NF-1                     % lendo N pontos                                        % 1 : N --> octave                                        % +1 transformo a vari�vel matem�tica em �ndice                                        % determina a se'rie discreta de Fourier        aux_kF = aux_kF + gkF(kF+1)*exp(-j*nF*kF*2*pi/NF);        end        XnF(nF+1) = aux_kF/NF;    end    toc;                                    % determina o tempo decorrido%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  6 -  Visualiza��o%%%%%%                       PARA A VOGAL Afigure(2)plot(tempoA,gkA,'k-','linewidth',3)     % configura plot(x,y, cor azul e linha cheia)xlabel('Tempo em segundos')           % tempo em segundosylabel('Amplitude')                   % amplitude em voltstitle('Sinal g(k)')         % t�tulogridfigure(3)%%% fftshift rotaciona o vetor 0 --> 2*pi ; -pi --> +pistem(frequenciaA,fftshift(abs(XnA)),'k-','linewidth',3)     % configura plot(x,y, cor azul e linha cheia)xlabel('Frequ�ncia em Hz')                      % tempo em segundosylabel('Amplitude')                             % amplitude em voltstitle('Espectro de amplitude')                  % t�tulogrid%%                       PARA A VOGAL Efigure(4)plot(tempoE,gkE,'k-','linewidth',3)     % configura plot(x,y, cor azul e linha cheia)xlabel('Tempo em segundos')           % tempo em segundosylabel('Amplitude')                   % amplitude em voltstitle('Sinal g(k)')         % t�tulogridfigure(5)%%% fftshift rotaciona o vetor 0 --> 2*pi ; -pi --> +pistem(frequenciaE,fftshift(abs(XnE)),'k-','linewidth',3)     % configura plot(x,y, cor azul e linha cheia)xlabel('Frequ�ncia em Hz')                      % tempo em segundosylabel('Amplitude')                             % amplitude em voltstitle('Espectro de amplitude')                  % t�tulogrid%%                       PARA A VOGAL Ifigure(6)plot(tempoI,gkI,'k-','linewidth',3)     % configura plot(x,y, cor azul e linha cheia)xlabel('Tempo em segundos')           % tempo em segundosylabel('Amplitude')                   % amplitude em voltstitle('Sinal g(k)')         % t�tulogridfigure(7)%%% fftshift rotaciona o vetor 0 --> 2*pi ; -pi --> +pistem(frequenciaI,fftshift(abs(XnI)),'k-','linewidth',3)     % configura plot(x,y, cor azul e linha cheia)xlabel('Frequ�ncia em Hz')                      % tempo em segundosylabel('Amplitude')                             % amplitude em voltstitle('Espectro de amplitude')                  % t�tulogrid%%                       PARA A VOGAL Ofigure(8)plot(tempoO,gkO,'k-','linewidth',3)   % configura plot(x,y, cor azul e linha cheia)xlabel('Tempo em segundos')           % tempo em segundosylabel('Amplitude')                   % amplitude em voltstitle('Sinal g(k)')         % t�tulogridfigure(9)%%% fftshift rotaciona o vetor 0 --> 2*pi ; -pi --> +pistem(frequenciaO,fftshift(abs(XnO)),'k-','linewidth',3)     % configura plot(x,y, cor azul e linha cheia)xlabel('Frequ�ncia em Hz')                      % tempo em segundosylabel('Amplitude')                             % amplitude em voltstitle('Espectro de amplitude')                  % t�tulogrid%%                       PARA A VOGAL Ufigure(10)plot(tempoU,gkU,'k-','linewidth',3)     % configura plot(x,y, cor azul e linha cheia)xlabel('Tempo em segundos')           % tempo em segundosylabel('Amplitude')                   % amplitude em voltstitle('Sinal g(k)')         % t�tulogridfigure(11)%%% fftshift rotaciona o vetor 0 --> 2*pi ; -pi --> +pistem(frequenciaU,fftshift(abs(XnU)),'k-','linewidth',3)     % configura plot(x,y, cor azul e linha cheia)xlabel('Frequ�ncia em Hz')                      % tempo em segundosylabel('Amplitude')                             % amplitude em voltstitle('Espectro de amplitude')                  % t�tulogrid%%                       PARA O SINAL DE REFERENCIA Ffigure(12)plot(tempoF,gkF,'k-','linewidth',3)     % configura plot(x,y, cor azul e linha cheia)xlabel('Tempo em segundos')           % tempo em segundosylabel('Amplitude')                   % amplitude em voltstitle('Sinal g(k)')         % t�tulogridfigure(13)%%% fftshift rotaciona o vetor 0 --> 2*pi ; -pi --> +pistem(frequenciaF,fftshift(abs(XnF)),'k-','linewidth',3)     % configura plot(x,y, cor azul e linha cheia)xlabel('Frequ�ncia em Hz')                      % tempo em segundosylabel('Amplitude')                             % amplitude em voltstitle('Espectro de amplitude')                  % t�tulogrid%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%