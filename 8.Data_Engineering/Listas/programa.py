import boto3
import requests
def valida_peso():
    peso=float(input('Digite o Peso (kg):\n'))
    while peso<0 or peso>300:
        print('Peso inválido')
        peso=float(input('Digite o Peso (kg):\n'))
    return peso
def valida_altura():
    altura=float(input('Digite o Altura (m):\n'))
    while altura<0 or altura>2.5:
        print('Altura inválida')
        altura=float(input('Digite o Altura (m):\n'))
    return altura
def valida_idade():
    idade=int(input('Digite a Idade (m):\n'))       
    if idade<0:
        print('Idade inválida')
        idade=int(input('Digite a Idade (m):\n'))
    elif idade<20 and idade>0:
        print('Obs.: Para essa idade não é recomendado o uso do IMC')
    return idade
def imc():
    url='https://sno7vsjdyc.execute-api.us-east-1.amazonaws.com/default/imc'
    opcao='1000'
    while opcao!='2':
        opcao=(input('Você gostaria de:\n1. Consultar um IMC\n2.Sair\n'))
        if opcao=='2':
            break   
        elif opcao=='1':    
            dict_entradas = {
            'peso': valida_peso(),
            'altura': valida_altura(),
            'idade':valida_idade()
            }
            response = requests.post(url, json=dict_entradas)
            resposta = response.json()
            imc=resposta['IMC']
            classific=resposta['Classificação']
            print(f'O IMC é: {imc:.1f}\nClassificado como: {classific}')
        else:
            print('Opção Inválida')
imc()
