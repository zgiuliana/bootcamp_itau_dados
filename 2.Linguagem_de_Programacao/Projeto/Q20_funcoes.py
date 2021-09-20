from random import choice
from operator import itemgetter
#    Cria uma lista com todas as cartas do baralho
#cria um dicionário com as cartas e seus respectivos valores
def cria_baralho():
    cartas=4*['A','2','3','4','5','6','7','8','9','10','J','Q','K']
    return cartas
def pontuacao_baralho(cartas):
    baralho={}
    for elemento in cartas:
        if (elemento).isdigit():
            baralho[elemento]=int(elemento)
        elif elemento=='A':
            baralho[elemento]=1
        elif elemento in ('J','Q','K'):
            baralho[elemento]=10
    return baralho

    
def sorteia_carta(cartas):
    carta=choice(cartas)
    return carta

def verifica(jogadores):
    lista=(sorted(jogadores.items(), key=itemgetter(1)))
    if len(lista)>1 and lista[-2][1]==lista[-1][1]:
        return print('Empate')
    else:
        vencedor=lista[-1]
        return print(f'O vencedor da partida é {vencedor[0]} com {vencedor[1]} pontos!') 
    
#Checa se o jogador está ativo
def checa_jogador(jogadores,jogadores_ativos,cartas,baralho):
    if (jogadores_ativos)=={} or len(jogadores)==1:
        verifica(jogadores)
    else:
        lista_ativ=[chave for chave, valor in jogadores_ativos.items()]
        i=0
        while i<len(lista_ativ) and jogadores_ativos!={}:
            jog=lista_ativ[i]
            escolha=input(f'{jog} sua pontuação é {jogadores_ativos[jog]}. Você gostaria de comprar uma carta? (S/N) ')
            if escolha!='S' and escolha!='N':
                print ('Opção inválida')
            elif escolha=='S':
                carta=sorteia_carta(cartas)
                pontos=baralho[carta]
                jogadores_ativos[jog]+=pontos
                cartas.remove(carta)
                print(f'Você tirou a carta {carta}, essa carta vale {pontos}. Sua nova pontuação é {jogadores_ativos[jog]}')
                jogadores[jog]=jogadores_ativos[jog]
                if jogadores_ativos[jog]>21:
                    jogadores_ativos.pop(jog)
                    jogadores.pop(jog)
                i=i+1
            elif escolha=='N':
                jogadores_ativos.pop(jog)
                i=i+1
        checa_jogador(jogadores,jogadores_ativos,cartas,baralho)
        
def principal():
    n=int(input('Qual o número de jogadores: '))
    i=1
    jogadores={}
    jogadores_ativos={}
    while i<=n:
        jogador=input(f'Qual o nome do jogador {i}: ')
        jogadores[jogador]=0
        jogadores_ativos[jogador]=0
        i=i+1

        
    cartas=cria_baralho()
    baralho=pontuacao_baralho(cartas)
    checa_jogador(jogadores,jogadores_ativos,cartas,baralho)


principal()
