# jogo da forca em assembly - by Antonio Sergio
.data
    linhaPalavras: .asciiz "-"
    vitoriaTexto: .asciiz "VOCE VENCEU"
    acertouTexto: .asciiz "ACERTOU"
    derrotaTexto: .asciiz "VOCE PERDEU"
    palavra: .asciiz "palavra"
    caracter: .space 2
    insiraLetra: .asciiz "INSERIR UMA LETRA \n"
    spaces: .asciiz "\n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n"
    n: .asciiz "\n"
    numeroLetrasPalavra: .word 0
.text
imprime_palavra:
    la $t0, palavra # carrega a palavra 
    li $s0, 0 # inicializa o contador
    li $s2, 0 # inicializa o contador
    j for_quantidade_letra_palavra # chama a funcao que calcula a quantidade de letras da palavra
for_quantidade_letra_palavra:
    lb $s0, ($t0)
    blt $s0,0, imprime_palavra # chama a funcao que imprime a palavra pois nao tem letra
    add $t0, $t0,1 # incrementa o ponteiro para a proxima letra da palavra
    add $s2, $s2,1 # incrementa o contador de letras da palavra
    j fim_for # chama a funcao novamente
fim_for:
    sw $s2, numeroLetrasPalavra # salva o numero de letras da palavra
# funcao que imprime o padrao -----
imprime_padrao:
    la $t1, palavra # carrega a string de caracteres
    li $s1, 0 # inicializa o contador
    j for_imprime_padrao # chama a funcao que imprime o padrao
for_imprime_padrao:
    lb $s1, ($t1)
    beq $s1, 0, fim_imprime_padrao # verifica se o caracter eh 0
    add $t1, $t1,1 # incrementa o ponteiro da string
    add $s2, $s2,1 # incrementa o contador
    sw $s2, numeroLetrasPalavra  # salva o caracter na posicao do vetor
    li $v0, 4 # carrega o valor 4 
    la $a0 , linhaPalavras # carrega o endereco da string
    la $a1 , 1 # carrega o endereco do contador
    syscall # chama a funcao printf
    j for_imprime_padrao # chama a funcao novamente
fim_imprime_padrao:
    li $v0, 4 # carrega o valor 4
    la $a0, n # carrega o endereco da string
    la $a1, 1 # carrega o endereco do contador
    syscall # chama a funcao printf
# funcao que le uma letra
ler_letra:
    li $v0, 4 # indica que quer imprimir string
    la $a0, insiraLetra # indica que a string é a palavra
    syscall # indica para o programa executar a funcao 
    li $v0, 8 # indica que quer ler um caracter do teclado
    la $a0, caracter # indica que o caracter é o caracter
    la $a1, 2 # indica que o caracter é um byte
    syscall # indica para o programa executar a funcao

verifica_letra_palavra:
    la $t3, palavra # carrega a string de caracteres
    li $s3, 0 # inicializa o contador
    li $v0, 4 # carrega o valor 4
    la $t4,caracter # carrega o caracter
    lb $t4, 0($t4)
    lw $s1, numeroLetrasPalavra # carrega o numero de letras da palavra
    j for_verifica_letra_palavra # chama a funcao que verifica a letra
for_verifica_letra_palavra:
    lb $s4, ($t3)
    beq $t4,$s4, fim_verifica_true_letra_palavra # verifica se o caracter pertence a palavra
    add $t3, $t3,1 # incrementa o ponteiro da string
    add $s3, $s3,1 # incrementa o contador
    beq $s3, $s1, fim_verifica_letra_palavra # verifica se o contador eh igual ao tamanho da string
    j for_verifica_letra_palavra # chama a funcao novamente
fim_verifica_true_letra_palavra:
    li $v0, 4 # carrega o valor 4
    la $a0, n # carrega o endereco da string
    la $a1, 1 # carrega o endereco do contador
    syscall # chama a funcao printf
    li $v0, 4 # carrega o valor 4
    la $a0, acertouTexto  # carrega o endereco da string
    syscall # chama a funcao printf
    j for_verifica_letra_palavra # chama a funcao novamente
fim_verifica_letra_palavra:
