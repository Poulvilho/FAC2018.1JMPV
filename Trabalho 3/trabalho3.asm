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
	floatZero: .float 0.0
	floatUm: .float 1.0
	
.text

le_float:
	# Lê o valor da variável que será tirado a raiz
	li $v0, 4
	la $a0, pedirNumero
	syscall

	li $v0, 6
	syscall

	# Confere se o valor esta entre 0 e 1
	l.s $f1, floatZero
	c.lt.s $f0, $f1
	bc1f valorErrado
	l.s $f1, floatUm
	c.lt.s $f1, $f0
	bc1f valorErrado
	jal calc_raiz

valorErrado:
	# Mensagem de erro e retorna pra main
	li $v0, 4
	la $a0, numeroForaParametro
	syscall
	jal le_float
	
calc_raiz:
	
calc_erro:
	
imprime_saida:
