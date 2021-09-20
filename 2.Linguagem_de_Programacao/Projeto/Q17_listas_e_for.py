#Listas de multiplicação
lista=[10,9,8,7,6,5,4,3,2]
lista2=[11,10,9,8,7,6,5,4,3,2]
#Pede para o usuário inserir o cpf e verifica se tem 11 digitos
cpf=(input('Digite seu CPF:'))
while len(list(cpf))!=11:
    cpf=input('Digite novamente o CPF: ')
#Cria uma lista com cada número do cpf
cpf_lista=[int(i) for i in list(cpf)]
cpf_lista_2=[int(i) for i in list(cpf)]
#Pega os dígitos finais do cpf
d1=cpf_lista[-2]
d2=cpf_lista[-1]
#Retira os digitos finais 
cpf_lista.pop(-1)
cpf_lista.pop(-1)
cpf_lista
#Retira o digito final da lista 2
cpf_lista_2.pop(-1)
cpf_lista_2
#faz os calculos
calc=[elemA*elemB for elemA, elemB in zip(lista, cpf_lista)]
x=sum(calc)

calc2=[elemA*elemB for elemA, elemB in zip(lista2, cpf_lista_2)]
y=sum(calc2)
#Faz as condições pra checar a validade do CPF
if (x*10)%11==d1:
    if (y*10)%11==d2:
        print('CPF Válido')
    else:
        print('CPF Inválido')
else:
    print('CPF Inválido')

