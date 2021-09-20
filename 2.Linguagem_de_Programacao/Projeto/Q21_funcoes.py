def busca_cli(lista):
    print('Busca de CLientes')
    cpf=input('Digite o CPF a ser buscado: ')
    for element in lista:
        if cpf in element:
            return (element)
    print ('CPF não encontrado')
def cad_cli():
    lista=[]
    op=1
    while op!=0:
        op=int(input('Escolha uma opção:\n 0 - Encerrar\n 1 - Cadastrar novo cliente\n 2 - Consultar Cliente\n 3 - Imprimir todos os clientes cadastrados\n'))
        if op==0:
            break
        elif op==1:
            print('Cadastro de CLientes')
            nome=input('Digite o nome a ser cadastrado: ')
            cpf=input('Digite o CPF a ser cadastrado: ')
            email=input('Digite o email a ser cadastrado: ')
            lista_cli=[nome,cpf,email]
            lista.append(lista_cli)
        elif op==2:
            cad=busca_cli(lista)
            if cad != None:
                print(cad)
        elif op==3:
            print('Clientes Cadastrados')
            print(lista)
        else:
            print('Opção não disponível')

cad_cli()
