def calcular_producao():
    # Entrada de dados do usuário
    entrada = input()

    # Separando as entradas de cada região e produção
    regioes_producao = entrada.split(',')

    # TODO: Crie as variáveis para armazenar a produção total e o número de regiões
    total_producao = 0
    numero_regioes = 0

    # TODO: Itere sobre cada entrada de região: produção
    for regiao_producao in regioes_producao:
        # Dividindo a região e a produção com base no caractere ":"
        regiao, producao = regiao_producao.split(':')
        # Convertendo a produção para float e somando ao total
        total_producao += float(producao.strip())
        # Incrementando o número de regiões
        numero_regioes += 1  

    # TODO: Calcule a média de produção por região
    media_producao = total_producao / numero_regioes

    # Exibindo a produção total e média formatada
    print(f"Produção total: {total_producao:.2f} toneladas")
    print(f"Média por região: {media_producao:.2f} toneladas")

# Executa a função
calcular_producao()