.data	# area para dados na memoria
	
	vetor: .asciiz "\nVetor: "
	
	saida: .asciiz "\n\nSoma: "
	
	zerado: .asciiz "\n\nVetor Zerado: "
	
	ordenado: .asciiz "\n\nVetor Ordenado: "
	
	
	#definindo valor 20 a size
	size: .word 20  
	
.text	# area instrucoes do programa
main:


		addi $sp, $sp, -80
		#variavel soma (li)
		move $s0, $sp

		
	# inicializaVetor(vet, SIZE, 71);
		#salva
		addi $sp, $sp, -8
		sw $s0, 0($sp)
		sw $s1,	4($sp)
		
		
		move $a0, $s0		#move vet para a0
		li $a1, 20
		li $a2, 71
		
		jal inicializaVetor
		
		#libera
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		addi $sp, $sp, 8
		
		move $s1, $v0		# soma = funcao
		
		#printf
		li $v0, 4
    		la $a0, vetor
    	  	syscall
		
	# imprimeVetor(vet, SIZE);
	
		move $a0, $s0
		li $a1, 20
		
		#salva
		addi $sp, $sp, -8
		sw $s0, 0($sp)
		sw $s1, 4($sp)
		
		jal imprimeVetor

		#libera
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		addi $sp, $sp, 8
		
	#ordenaVetor(vet, SIZE);	
		
		#salva
		addi $sp, $sp, -8
		sw $s0, 0($sp)
		sw $s1, 4($sp)
		
		
		move $a0, $s0
		li $a1, 20
		
		jal ordenaVetor
		
		#salva
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		addi $sp, $sp, 8
		
		#printf
		li $v0, 4
    		la $a0, ordenado
    	  	syscall
    	  	
	#imprimeVetor(vet, SIZE);
	
		move $a0, $s0
		li $a1, 20
		
		#salva
		addi $sp, $sp, -8
		sw $s0, 0($sp)
		sw $s1, 4($sp)
		
		jal imprimeVetor

		#libera
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		addi $sp, $sp, 8
		
	#zeraVetor(&vet[0], &vet[SIZE]);
		
		addi $sp, $sp, -8
		sw $s0, 0($sp)
		sw $s1, 4($sp)
		
		#prepara parametro
		la $t8, size   
		lw $t9, 0($t8)   #t9= 20
		mul $t9, $t9, 4  #t9 = vet[80] 
		
		add $a1, $s0, $t9
		move $a0, $s0
		jal zeraVetor
		
		#libera
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		addi $sp, $sp, 8
		
		#printf
		li $v0, 4
    		la $a0, zerado
    	  	syscall
		
	# imprimeVetor(vet, SIZE);
	
		move $a0, $s0
		li $a1, 20
		
		#salva
		addi $sp, $sp, -8
		sw $s0, 0($sp)
		sw $s1, 4($sp)
		
		jal imprimeVetor

		#libera
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		addi $sp, $sp, 8
		
		
	#saida
		
		#soma:
    		li $v0, 4
    		la $a0, saida
    	  	syscall
		
		#valor da soma		
		li $v0, 1
		move $a0, $s1
		syscall
		
		addi $sp, $sp, 80
	
		
imprimeVetor:		
		move $t7, $a0	#vet esta em t7
		move $t6, $a1	#tam esta em t6
		
		addi $sp, $sp, -4
		
		sw $ra, 0($sp)
		
		li $s0, 0	#i =0
		li $s1, 0
		
	#for( int i =0; i< $a1; i ++)
		loop: 
			beq $s0, $t6 fim
		
			add $t1, $t7, $s1	#t1 = &v[s0(i)]
			li $v0, 1	#imprime inteiro
			lw $a0, 0($t1)
			syscall 
	
			li $v0, 11	#imprime espaço
			li $a0, 32
			syscall 
	
			addi $s0, $s0, 1	#i++
			addi $s1, $s1, 4
		j loop
	    	
	    	fim:
	    	
	    		lw $ra, 0($sp)
	    		addi $sp, $sp, 4
			jr $ra

inicializaVetor:
		addi $sp, $sp, -20
		#salvando os valores
		sw $s0, 0($sp)
		sw $s1, 4($sp) 
		sw $s2, 8($sp)
		sw $s3, 12($sp)
		sw $ra, 16($sp)
		
		
		move $s0, $a0 #s0 vet
		move $s1, $a1 #s1 tam
		move $s2, $a2 #s2 ultimo
	
		#caso base	
		slt $t0, $zero, $s1	 
		bne $t0, $zero, else	 	
	
		#return 0 
		li $v0, 0
		move $s3, $v0
		jr $ra
	    else:
	    
		#recursividade
		add $a0, $zero, $s2	#a0 = ultimo valor
		addi $a1, $zero, 47	#a1 = 47
		addi $a2, $zero, 97	#a2 = 97
		addi $a3, $zero, 337	#a3 = 337	
		addi $sp, $sp, -4	#"a4" = 3
		addi $t4, $zero, 3	
		sw $t4, 0($sp)
	     	jal valorAleatorio
		addi $sp, $sp, 4
		
		move $s3, $v0
		
	#vetor[tamanho - 1] = novoValor;
		addi $s1, $s1, -1	#tam = tamanho -1(ir para ultima posicao)
		mul $t5, $s1, 4
		add $t5, $s0, $t5
		
		sw  $s3, 0($t5)  	#vet[tam-1] = 0
		
	# return novoValor + inicializaVetor(vetor, tamanho - 1, novoValor);
		
		#ajusta tamanho
		move $a0, $s0		#a0 recebe vet
		move $a1, $s1		#a1 tam
		move $a2, $s3		#a2 novoValor
		jal inicializaVetor	#passando:a0= vet; a1= tam; a2= novoValor
		
		add $v0, $v0, $s3
		
		lw $s0, 0($sp)
		lw $s1, 4($sp) 
		lw $s2, 8($sp)
		lw $s3, 12($sp)
		lw $ra, 16($sp)
		addi $sp, $sp, 20
		
		jr $ra
		
valorAleatorio:
		#return (a * b + c) % d - e;
		mult $a0, $a1
		mflo $v0
		add $v0, $v0, $a2	#(a * b + c)
		div $v0, $a3  		# % d
		mfhi $v0
		
		lw $t2, 0($sp)
		sub $v0, $v0, $t2	#valor retornado em $v1
		jr $ra
		
zeraVetor:

	add $t0, $zero, $a0        # $t0 = inicio
    	add $t1, $zero, $a1        # $t1 = fim
    
	loop2:
		slt $t2, $t0, $t1          # $t2 = (inicio < fim)
    		beqz $t2, end_loop         # Se (inicio >= fim), encerra o loop
    
    		sw $zero, 0($t0)           # *inicio = 0
    
    		addi $t0, $t0, 4           # incrementa o ponteiro inicio em 4 bytes (tamanho de um inteiro)
    		j loop2                   # Salta para o início do loop

	end_loop:
		jr $ra
		
		
		
ordenaVetor:		
		addi $sp, $sp, -24
		sw $s0, 0($sp)	#vet
		sw $s1, 4($sp)	#tam
		sw $s2, 8($sp)	#i
		sw $s3, 12($sp) #j
		sw $s4, 16($sp) #min_idx
		sw $ra, 20($sp)
		
		li $t1, 0
		li $t2, 0
		li $t3, 0
		li $t4, 0
		
		move $s0, $a0 #vet
		move $s1, $a1 #tam
		
		# for (i = 0; i < n - 1; i++) {     
		addi $t0, $s1, -1 #n-1
		li $s2, 0	#i
	    
	        for: 
			bge $s2, $t0, fimFor	#i >= n-1 vai ->label
			
			move $s4, $s2
			
			addi $s3, $s2, 1
			
			forInterno:
				bge $s3, $s1, fimForInterno
			
				mul $t1, $s3, 4
				mul $t2, $s4, 4
			
				add $t3, $s0, $t1 
				add $t4, $s0, $t2
				
				lw $t3, 0($t3)
				lw $t4, 0($t4)
				
				bge $t3, $t4, ifInterno
				
					move $s4, $s3
				
				ifInterno:
			
			addi $s3, $s3, 1
			j forInterno
			fimForInterno:
			
			beq $s2, $s4, ifExterno
			
				mul $t1, $s2, 4
				mul $t2, $s4, 4
			
				add $t3, $s0, $t1 #vet[i]
				add $t4, $s0, $t2 #vet[min]

				move $a0, $t3
				move $a1, $t4
				
				jal troca
			
			ifExterno:

		addi $s2, $s2, 1
		j for
		fimFor:
		lw $s0, 0($sp)	#vet
		lw $s1, 4($sp)	#tam
		lw $s2, 8($sp)	#i
		lw $s3, 12($sp) #j
		lw $s3, 16($sp) #min_idx
		lw $ra, 20($sp)
		addi $sp, $sp, 24
		jr $ra
		
		
		
troca:

	# void troca(int *a, int *b)
	#		 a0,     a1
		
    	beq $a0, $a1, final       # Se a = b, pula para o fim da função

    	# Troca os valores de a e b
    	lw $t0, 0($a0)
    	lw $t1, 0($a1)
    	sw $t0, 0($a1)
    	sw $t1, 0($a0)
	
	final:
    	jr $ra                  # retorna ao endereço de retorno		
			
			