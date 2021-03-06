# Trabalho 2
#
# Alunos:	160031982 - Jo�o Pedro Mota Jardim
#		160016428 - Paulo Victor de Menezes Lopes
.data

	pedirValorA: .asciiz "Coloque o valor de A: "
	pedirValorB: .asciiz "Coloque o valor de B: "
	pedirValorP: .asciiz "Coloque o valor de P: "
	mensagemErro: .asciiz "\nO modulo nao eh primo\n"
	mensagemErroExpoente: .asciiz "\nExpoente eh negativo\n"
	mensagemErroIndeterminacao: .asciiz "\n0 elevado a 0"
	mensagemResultado1: .asciiz "\nA exponencial modular  "
	mensagemResultado2: .asciiz " elevado a "
	mensagemResultado3: .asciiz " (mod "
	mensagemResultado4: .asciiz ") eh: "
	
.text

main:

le_inteiro:
	# L� o valor da vari�vel que ser� elevada
	li $v0, 4
	la $a0, pedirValorA
	syscall

	li $v0, 5
	syscall
	move $s0, $v0

	# L� o valor da vari�vel que ser� o expoente
	li $v0, 4
	la $a0, pedirValorB
	syscall

	li $v0, 5
	syscall
	move $s1, $v0

	# L� o valor da vari�vel que vai modularizar
	li $v0, 4
	la $a0, pedirValorP
	syscall

	li $v0, 5
	syscall
	move $s2, $v0

eh_primo:
	# Verifica se o valor � menor que 2
	slti $t1, $s2, 2
	beq $t1, 1, imprime_erro_primo
	# Se o valor for 2 ou 3, � primo
	beq $s2, 2, calc_exp
	beq $s2, 3, calc_exp
	# Verifica se � divis�vel por 2
	li $t0, 2
	div $s2, $t0
	mfhi $t1
	beq $t1, 0, imprime_erro_primo
	# carrega o comparador para ver se � divis�vel por 3
	li $t0, 3

incrementa:
	# Verifica se o pr�ximo valor � maior que a refer�ncia
	slt $t1, $s2, $t0
	# Se for maior ou igual, � primo, pois nenhum anterior consegue dividir
	beq $t1, 1, calc_exp
	beq $t0, $s2, calc_exp
	# Dividi pelo pr�ximo �mpar
	div $s2, $t0
	# Verifica se o resto � nulo, se for nulo nao � prima, caso contrario, continua
	mfhi $t1
	beq $t1, 0, imprime_erro_primo
	# Pula para pr�ximo �mpar e continua o la�o
	addi $t0, $t0, 2
	jal incrementa

calc_exp:
	# Calcula o exponencial, verificando se expoente � negativo ou igual a 0
	slti $t1, $s1, 0
	beq $s1, 0, expoente_nulo
	beq $t1, 1, imprime_erro_expoente
	# Inicia as vari�veis para o loop da exponencia��o
	move $t2, $s1
	move $s3, $s0
	#se o numero for maior q o primo, j� realiza a divis�o modular
	slt  $t1,$s2,$s0
	beq $t1, 1, divisao_modular
	
loop_mult:
	#beq $t2, 1, divisao_modular
	# Multiplica��o
	mult $s3, $s0
	mflo $s3
	#diminui o expoente
	subi $t2, $t2, 1
	j divisao_modular

expoente_nulo:
	beq $s0, 0, imprime_erro_indeterminacao
	li $s3, 1
	jal divisao_modular
	
divisao_modular:
	#realiza a divisao modular
	div $s3, $s2
	mfhi $s3
	#se o expoente for igual ou maior que 2(ou seja, >1), pula pra multiplica�ao, caso contrario, imprime a saida
	slti $t1,$t2,2
	beq $t1,0,loop_mult
	jal imprime_saida

imprime_saida:
	li $v0, 4
	la $a0, mensagemResultado1
	syscall
	
	li $v0, 1
	move $a0, $s0
	syscall
	
	li $v0, 4
	la $a0, mensagemResultado2
	syscall
	
	li $v0, 1
	move $a0, $s1
	syscall
	
	li $v0, 4
	la $a0, mensagemResultado3
	syscall
	
	li $v0, 1
	move $a0, $s2
	syscall
	
	li $v0, 4
	la $a0, mensagemResultado4
	syscall
	
	li $v0, 1
	move $a0, $s3
	syscall
	jal fim

imprime_erro_primo:
	li $v0, 4
	la $a0, mensagemErro
	syscall
	jal fim

imprime_erro_expoente:
	li $v0, 4
	la $a0, mensagemErroExpoente
	syscall
	jal fim

imprime_erro_indeterminacao:
	li $v0, 4
	la $a0, mensagemErroIndeterminacao
	syscall
	jal fim

fim:
