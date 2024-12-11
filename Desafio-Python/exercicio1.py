def filtrar_funcionarios(funcionarios, cargo):
    # TODO: Filtre os funcionários pelo cargo especificado
    funcionarios_filtrados = []
    for f in funcionarios:
        if f['cargo'] == cargo:
            funcionarios_filtrados.append(f['nome'])
    return funcionarios_filtrados

# Função para entrada do usuário
def main_filtro():
    n = int(input())
    funcionarios = []

    for _ in range(n):
        id_funcionario = int(input())
        nome = input()
        cargo = input()
        funcionarios.append({"id": id_funcionario, "nome": nome, "cargo": cargo})

    cargo_filtro = input()
    resultado = filtrar_funcionarios(funcionarios, cargo_filtro)
    
    print(resultado)
    """for f in resultado:
        print(f['nome'])"""

# Executando a função
main_filtro()