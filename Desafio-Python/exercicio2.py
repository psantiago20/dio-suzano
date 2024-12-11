def calcular_salarios(funcionarios):
    # TODO: Calcule os salários com base nas horas trabalhadas e no valor por hora:
    salarios = []
    for funcionario in funcionarios:
        salario = funcionario['horas_trabalhadas'] * funcionario['valor_hora']
        salarios.append('{}: {}'.format(funcionario['nome'], salario))
    #TODO: Retorne 'salarios':
    return salarios
    

# Função para entrada do usuário
def main_salario():
    n = int(input())
    funcionarios = []

    for _ in range(n):
        nome = input()
        horas_trabalhadas = int(input())
        valor_hora = float(input())
        
        # TODO: Adicione um dicionário com as informações do funcionário à lista 'funcionarios'.
        funcionarios.append({"nome": nome, "horas_trabalhadas": horas_trabalhadas, "valor_hora": valor_hora})

    resultado = calcular_salarios(funcionarios)
    
    for salario in resultado:
        print(salario)

# Executando a função
main_salario()