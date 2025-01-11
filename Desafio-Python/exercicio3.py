def crescimento_percentual(vendas_mensais):
    # TODO: Extraia os valores de venda de dois meses:
    vendas_1 = vendas_mensais[0]["valor_venda"]
    vendas_2 = vendas_mensais[1]["valor_venda"]
    
    # TODO: Calcule o crescimento percentual
    crescimento = ((vendas_2 - vendas_1) / vendas_1) * 100
    return crescimento

vendas_mensais = []

for i in range(2):
    mes = input()
    valor_venda = float(input())
    vendas_mensais.append({"mes": mes, "valor_venda": valor_venda})

# TODO: Chame a função e imprime o resultado:
resultado = crescimento_percentual(vendas_mensais)
print(f"Crescimento percentual de vendas: {resultado:.2f}%")