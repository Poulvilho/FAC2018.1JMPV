# Alunos: 16/0031982	Joao Pedro Jardim Mota
#	  16/0016428	Paulo Victor de Menezes Lopes

# Trabalho 1 Exercicio 2:

# Letra A)
lui $s1, 0x0000 # Carrega os primeiros 16 bit com 0000
ori $s1, $s1, 0xFACE # Carrega os 16 ultimos bits com face

# Letra B)
lui $s3, 0x0000 # Palavra para guardar o 2 byte menos significativo
ori $s3, 0x0000

andi $s3, $s1, 0x00f0 # Guarda o 2 byte

sll $s3, $s3, 8 # Move ele para a 4 posicao menos significativa

lui $s4, 0x0000 # Palavra para guardar o 4 byte
ori $s4, 0x0000

andi $s4, $s1, 0xf000 # Guarda o 4 byte

srl $s4, $s4, 8 # Move ele para a 2 posicao menos significativa

andi $s2, $s1, 0x0f0f # Guarda o 1 e 3 bytes menos sifnificativos na resposta

or $s2, $s2, $s3 # Guarda a 4 posicao menos significativa na resposta
or $s2, $s2, $s4 # Guarda a 2 posicao menos significativa na resposta