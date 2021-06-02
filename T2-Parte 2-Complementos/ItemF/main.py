import time

print("TESTE A SUA VOGAL")
print("=============================================================")
print("=============================================================")
print("Caso utile valores com casas decimais,use ponto para separar as casas decimais,por exemplo 178, digite 178.0")
print("Evite utilizar valores inteiros!")
print("=============================================================")
print("=============================================================")
time.sleep(1)
f0 = float(input("Digite o valor de f0:"))
print("=============================================================")
print("=============================================================")
f1 = float(input("Digite o valor de f1:"))
print("=============================================================")
print("=============================================================")
f2 = float(input("Digite o valor de f2:"))
print("=============================================================")
print("=============================================================")

MediaAf0 = 168.58
MediaAf1 = 659.47
MediaAf2 = 1184.9

MediaEf0 = 174.48
MediaEf1 = 521.13
MediaEf2 = 1898.9

MediaIf0 = 215.70
MediaIf1 = 1778.9
MediaIf2 = 2897.7

MediaOf0 = 175.72
MediaOf1 = 536.54
MediaOf2 = 922.65

MediaUf0 = 213.16
MediaUf1 = 655.86
MediaUf2 = 1926.2

DesvioAf0 = 52.692
DesvioAf1 = 175.93
DesvioAf2 = 364.99

DesvioEf0 = 73.039
DesvioEf1 = 232.14
DesvioEf2 = 387.55

DesvioIf0 = 63.231
DesvioIf1 = 664.88
DesvioIf2 = 746.53

DesvioOf0 = 58.403
DesvioOf1 = 114.88
DesvioOf2 = 200.91

DesvioUf0 = 72.064
DesvioUf1 = 166.46
DesvioUf2 = 654.17

if (MediaAf0-DesvioAf0) <= f0 <= (MediaAf0 + DesvioAf0) and (MediaAf1-DesvioAf1) <= f1 <= (MediaAf1 + DesvioAf1) and (MediaAf2-DesvioAf2) <= f2 <= (MediaAf2 + DesvioAf2) :
    print("A sua vogal é a letra A!!")
elif (MediaEf0-DesvioEf0) <= f0 <= (MediaEf0 + DesvioEf0) and (MediaEf1-DesvioEf1) <= f1 <= (MediaEf1 + DesvioEf1) and (MediaEf2-DesvioEf2) <= f2 <= (MediaEf2 + DesvioEf2) :
    print("A sua vogal é a letra E!!")
elif (MediaIf0 - DesvioIf0) <= f0 <= (MediaIf0 + DesvioIf0) and (MediaIf1 - DesvioIf1) <= f1 <= (MediaIf1 + DesvioIf1) and (MediaIf2 - DesvioIf2) <= f2 <= (MediaIf2 + DesvioIf2):
    print("A sua vogal é a letra I!!")
elif (MediaOf0-DesvioOf0) <= f0 <= (MediaOf0 + DesvioOf0) and (MediaOf1-DesvioOf1) <= f1 <= (MediaOf1 + DesvioOf1) and (MediaOf2-DesvioOf2) <= f2 <= (MediaOf2 + DesvioOf2) :
    print("A sua vogal é a letra O!!")
elif (MediaUf0-DesvioUf0) <= f0 <= (MediaUf0 + DesvioUf0) and (MediaUf1-DesvioUf1) <= f1 <= (MediaUf1 + DesvioUf1) and (MediaUf2-DesvioUf2) <= f2 <= (MediaUf2 + DesvioUf2) :
    print("A sua vogal é a letra E!!")
else:
    print("A sua vogal não pode ser identificada!")

#VALORES DAS VOGAIS BASE APOS EXECUCAO DO CODIGO NO OCTAVE
#A- f0: 160.1     f1: 631.9         f2: 1390.2
#E- f0: 165.1     f1: 495.3         f2: 2148.2
#I- f0: 170.8     f1: 2238.2        f2: 3108.1
#O- f0: 166.1     f1: 609.2         f2: 846.8
#U- f0: 186.2     f1: 730.8         f2: 1383.5

#APÓS OS TESTES COM AS 5 VOGAIS UTILIZANDO ESSE ALGORITMO CHEGUEI AO SEGUINTE RESULTADO PARA A ANALISE:
# 0:ERROU
# 1:ACERTOU
# A E I O U
# 1 1 1 0 0

# O acerto foi de 60%, principalmente devido a conflitos entre os limites de A,O,U para o algoritmo,conclui-se que
#possivelmente com um maior numero de informacoes na base de dados, o desvio padrao provavelmente seria menor,aumentando
#assim a precisao do algoritmo.