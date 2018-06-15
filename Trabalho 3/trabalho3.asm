# Trabalho 3
#
# Alunos:	160031982 - João Pedro Mota Jardim
#		160016428 - Paulo Victor de Menezes Lopes

.data

	pedirNumero: .asciiz "Coloque um numero entre 0 e 1: "
	numeroForaParametro: .asciiz "\nERRO! COLOQUE um valor entre 0 e 1!!\n\n"
	resultado: .asciiz "A raiz cubica eh "
	erro: .asciiz ". O erro estimado eh de "
	final: .asciiz ".\n" 
	                                   # f0    : valor dado para encontrar a raíz
	doubleZero: .double 0.0            # f2 = 0: primeiro extremo inferior
	doubleUm: .double 1.0              # f4 = 1: primeiro extremo superior
	doubleDois: .double 2.0            # f6 = 2: para dividir extremos ao meio
	doubleErro: .double 0.000000000001 # f8    : erro permitido
					   # f10   : interseccao dos extremos
					   # f14   : interseccao dos extremos ao cubo
					   # f16   : verificar erro encontrado
	
.text

	# Definição das Constantes e Primeiros Extremos
	l.d $f2, doubleZero
	l.d $f4, doubleUm
	l.d $f6, doubleDois
	l.d $f8, doubleErro

le_double:
	# Lê o valor da variável que será tirado a raiz
	li $v0, 4
	la $a0, pedirNumero
	syscall

	li $v0, 7
	syscall

	# Confere se o valor é 0 ou 1
	c.eq.d $f0, $f2
	bc1t raiz_zero
	c.eq.d $f4, $f0
	bc1t raiz_um
	
	# Confere se o valor esta entre 0 e 1
	c.lt.d $f0, $f2
	bc1t valorErrado
	c.lt.d $f4, $f0
	bc1t valorErrado
	# Se está entre 0 e 1, entra no loop para calcular a raíz
	jal calc_raiz

valorErrado:
	# Mensagem de erro e retorna pra ler um novo valor
	li $v0, 4
	la $a0, numeroForaParametro
	syscall
	jal le_double

calc_raiz:
	# Pega a interseccao dos extremos possíveis
	add.d $f10, $f2, $f4
	div.d $f10, $f10, $f6

	# Eleva ao cubo para comparar com o valor desejado
	mul.d $f14, $f10, $f10
	mul.d $f14, $f14, $f10
	# Verifica se o valor encontrado está dentro do erro estipulado
	jal calc_erro

calc_erro:
	# Compara para ver se encontrou o resultado
	sub.d $f16, $f0, $f14
	c.lt.d $f8, $f16
	# Se a diferença entre o que eu quero e o encontrado for maior que o erro,
	# então devo manter o loop atualizando o extremo inferior para pegar um valor
	# maior que o anterior
	bc1t novo_valor_inferior
	sub.d $f16, $f14, $f0
	c.lt.d $f8, $f16
	# Se a diferença entre o que eu encontrei e o desejado for maior que o erro,
	# então devo manter o loop atualizando o extremo superior para pegar um valor
	# menor que o anterior
	bc1t novo_valor_superior
	# Se as duas condições acima foram negadas, entao o valor está aproximado o
	# suficiente diante o erro dado
	jal imprime_saida

novo_valor_inferior:
	# Define um novo valor inferior e volta ao loop
	mov.d $f2, $f10
	jal calc_raiz

novo_valor_superior:
	# Define um novo valor superior e volta ao loop
	mov.d $f4, $f10
	jal calc_raiz

raiz_zero:
	l.d $f10, doubleZero
	l.d $f16, doubleZero
	jal imprime_saida

raiz_um:
	l.d $f10, doubleUm
	l.d $f16, doubleZero
	jal imprime_saida

imprime_saida:
	# Imprime o resultado da raíz cúbica
	li $v0, 4
	la $a0, resultado
	syscall
	
	li $v0, 3
	mov.d $f12, $f10
	syscall
	
	# Imprime o resultado do erro
	li $v0, 4
	la $a0, erro
	syscall

	li $v0, 3
	mov.d $f12, $f16
	syscall
	
	# Pula uma linha
	li $v0, 4
	la $a0, final
	syscall
