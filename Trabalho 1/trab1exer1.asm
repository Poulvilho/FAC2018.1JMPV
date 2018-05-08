# Alunos: 16/0031982	Joao Pedro Jardim Mota
#	  16/0016428	Paulo Victor de Menezes Lopes

# Trabalho 1 Exercicio 1:

# Letra A)
lui $s1, 0x5555 # Carrega os 16 primeiros bits com 5555
ori $s1, $s1, 0x5555 # Carrega os 16 últimos bits com 5555

# Letra B)
sll $s2, $s1, 1 # Move um bit para a esquerda

# Letra C)
or $s3, $s1, $s2 # Or entre s1 e s2

# Letra D)
and $s4, $s1, $s2 # And entre s1 e s2

# Letra E)
xor $s5, $s1, $s2 # XOR entre s1 e s2

# Resultado dos resgistradores ao final:
# $s2 = 0xaaaaaaaa
# $s3 = 0xffffffff
# $s4 = 0x00000000
# $s5 = 0xffffffff
