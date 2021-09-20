notas=[]

#Inputs
nome=input('Digite o nome do aluno: ')
idade=int(input('Digite a Idade do aluno:'))
provas=int(input('Digite quantas provas o aluno fez:'))

for i in range(provas):
    nota=float(input(f'Digite a {i+1}ª nota do aluno:'))
    while (nota<0 or nota>10):
        nota= float(input(f'Não entendi, digite a {i+1}ª nota do aluno novamente: '))
    notas.append(nota)


#Calcula a média
media=sum(notas)/provas
media>5

print([nome,idade,notas,float(f'{media:.2}'),media>5])
