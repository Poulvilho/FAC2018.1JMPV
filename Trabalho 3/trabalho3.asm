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
	floatZero: .float 0.0            # f1 = 0: primeiro extremo inferior
	floatUm: .float 1.0              # f2 = 1: primeiro extremo superior
	floatDois: .float 2.0            # f3 = 2: para dividir extremos ao meio
	floatErro: .float 0.000000000001 # f4    : erro permitido
					 # f5    : interseccao dos extremos
					 # f6    : interseccao dos extremos ao cubo
					 # f7    : verificar erro encontrado
	
.text

	# Definição das Constantes e Primeiros Extremos
	l.s $f1, floatZero
	l.s $f2, floatUm
	l.s $f3, floatDois
	l.s $f4, floatErro

le_float:
	# Lê o valor da variável que será tirado a raiz
	li $v0, 4
	la $a0, pedirNumero
	syscall

	li $v0, 6
	syscall

	# Confere se o valor esta entre 0 e 1
	c.lt.s $f0, $f1
	bc1t valorErrado
	c.lt.s $f2, $f0
	bc1t valorErrado
	# Se está entre 0 e 1, entra no loop para calcular a raíz
	jal calc_raiz

valorErrado:
	# Mensagem de erro e retorna pra ler um novo valor
	li $v0, 4
	la $a0, numeroForaParametro
	syscall
	jal le_float

calc_raiz:
	# Pega a interseccao dos extremos possíveis
	add.s $f5, $f1, $f2
	div.s $f5, $f5, $f3

	# Eleva ao cubo para comparar com o valor desejado
	mul.s $f6, $f5, $f5
	mul.s $f6, $f6, $f5
	# Verifica se o valor encontrado está dentro do erro estipulado
	jal calc_erro

calc_erro:
	# Compara para ver se encontrou o resultado
	sub.s $f7, $f0, $f6
	c.lt.s $f4, $f7
	# Se a diferença entre o que eu quero e o encontrado for maior que o erro,
	# então devo manter o loop atualizando o extremo inferior para pegar um valor
	# maior que o anterior
	bc1t novo_valor_inferior
	sub.s $f7, $f6, $f0
	c.lt.s $f4, $f7
	# Se a diferença entre o que eu encontrei e o desejado for maior que o erro,
	# então devo manter o loop atualizando o extremo superior para pegar um valor
	# menor que o anterior
	bc1t novo_valor_superior
	# Se as duas condições acima foram negadas, entao o valor está aproximado o
	# suficiente diante o erro dado
	jal imprime_saida

novo_valor_inferior:
	# Define um novo valor inferiore volta ao loop
	mov.s $f1, $f5
	jal calc_raiz

novo_valor_superior:
	# Define um novo valor superior e volta ao loop
	mov.s $f2, $f5
	jal calc_raiz

imprime_saida:
	# Imprime o resultado da raíz cúbica
	li $v0, 4
	la $a0, resultado
	syscall
	
	li $v0, 2
	mov.s $f12, $f5
	syscall
	
	# Imprime o resultado do erro
	li $v0, 4
	la $a0, erro
	syscall

	li $v0, 2
	mov.s $f12, $f7
	syscall
	
	# Pula uma linha
	li $v0, 4
	la $a0, final
	syscall