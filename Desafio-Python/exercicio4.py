def valor_acumulado_vendas(vendas_mensais):
    acumulado = 0
    vendas_acumuladas = []
    
    # TODO: Calcule o valor acumulado mês a mês:
    for venda in vendas_mensais:
        acumulado += venda["valor_venda"]
        vendas_acumuladas.append(f"{venda['mes']}: {acumulado:.1f}")

    # TODO: Retorne vendas_acumuladas:
    return vendas_acumuladas

vendas_mensais = []
n = int(input())

for i in range(n):
    mes = input()
    valor_venda = float(input())
    vendas_mensais.append({"mes": mes, "valor_venda": valor_venda})

# TODO: Chame a função e imprima o resultado:
resultado = valor_acumulado_vendas(vendas_mensais)

for linha in resultado:
    print(linha)