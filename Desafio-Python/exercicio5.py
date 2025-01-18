def analisar_desempenho_funcionarios():
    # Entrada de dados
    registros = input()
    desempenho = []

    # Processamento dos dados
    for registro in registros.split(', '):
        nome, pontuacao = registro.split(': ')
        pontuacao = int(pontuacao)

        # TODO: Implemente a solução para a classificação de desempenho:
        if(pontuacao)> 90:
            categoria = 'Excelente'
        elif(pontuacao) > 75:
            categoria = 'Bom'
        else:
            categoria = 'Regular'

        desempenho.append(f"{nome}: {categoria}")


    # TODO: Agora, exiba a saída:
    for resultado in desempenho:
        print(resultado)

analisar_desempenho_funcionarios()