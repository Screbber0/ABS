# -4[rbp] => r12d

	.intel_syntax noprefix		# пишем в синаксисе intel
	.text				# начинаем секцию
	.section	.rodata	# .rodata
.lc0:
	.string	"%d"		# кладем строчку в бинарник, ставим метку (.lc0 "%d")
	.text				# секция с кодом
	.globl	inputarr
	.type	inputarr, @function
	
inputarr:				# функция ввода массива
	push	rbp			# сохранение rbp на стек
	mov	rbp, rsp		# rbp := rsp
	sub	rsp, 32		# # rsp -= 32 (выделяем память для фрейма)
	mov	qword ptr -24[rbp], rdi 		# указатель на массив
	mov	r12d, 0   		# i = 0
	jmp	.l2			# go to l2
.l3:
	mov	eax, r12d 		# eax := i
	cdqe				# преобразование в sign-extend
	lea	rdx, 0[0+rax*4]	# rdx := rax * 4
	mov	rax, qword ptr -24[rbp]	# rax := rbp - 24
	add	rax, rdx		# rax += rdx 
	mov	rsi, rax		# rsi := rax
	lea	rdi, .lc0[rip]		
	mov	eax, 0			# eax := 0
	call	__isoc99_scanf@plt	# scanf("%d")
	add	r12d, 1		# ++i
.l2:
	cmp	r12d, 4		# сравнить int i и 4 (всего 5 эллементов)
	jle	.l3			# jump less => .l3
	nop				# не выполняет никакой операции, занимает место в потоме команд
	nop				# не выполняет никакой операции, занимает место в потоме команд
	leave				# / выход из функции
	ret				# \
	
createnewarr:				# функция создание нового массива 
	push	rbp			# сохраняем rbp на стек
	mov	rbp, rsp		# rbp := rsp
	mov	qword ptr -24[rbp], rdi 	# указатель на a
	mov	qword ptr -32[rbp], rsi	# указатель на b
	mov	byte ptr -1[rbp], 1	# isFirstPositive  = true
	mov	dword ptr -8[rbp], 4	# i = 4
	jmp	.l5			# go to .l5
.l9:
	cmp	byte ptr -1[rbp], 0	# проверка на isFirstPositive  == true
	je	.l6			# go to .l6
	mov	eax, dword ptr -8[rbp]	# eax := rbp - 8
	cdqe				# преобразование в sign-extend
	lea	rdx, 0[0+rax*4]	# rdx := rax * 4
	mov	rax, qword ptr -24[rbp]	# rax := rbp - 24
	add	rax, rdx		# rax += rdx 	
	mov	eax, dword ptr [rax]   # eax := rax
	test	eax, eax		# Проверка условий
	jle	.l6			# jump less => .l6
	mov	byte ptr -1[rbp], 0	# isFirstPositive  = false
	jmp	.l7			# go to .l7
.l6:
	movzx	eax, byte ptr -1[rbp]	# / !isFirstPositive
	xor	eax, 1			# \
	test	al, al			# Проверка условий
	je	.l8			# 
	mov	eax, dword ptr -8[rbp]	# eax := rbp - 8
	cdqe				# преобразование в sign-extend
	lea	rdx, 0[0+rax*4]	# rdx := rax * 4
	mov	rax, qword ptr -24[rbp]	
	add	rax, rdx		# rax += rdx
	mov	edx, 3			# /
	sub	edx, dword ptr -8[rbp]	# | вычитаем из 3
	movsx	rdx, edx		# \ 
	lea	rcx, 0[0+rdx*4]		# /
	mov	rdx, qword ptr -32[rbp]	# |	получаем i
	add	rdx, rcx			# \ 
	mov	eax, dword ptr [rax]	# eax  := rax
	mov	dword ptr [rdx], eax	
	jmp	.l7			# go to .l7
.l8:
	mov	eax, dword ptr -8[rbp]	# eax = rbp - 8
	cdqe				# преобразование в sign-extend
	lea	rdx, 0[0+rax*4]	# rdx := rax * 4
	mov	rax, qword ptr -24[rbp]		
	add	rax, rdx		# rax += rdx
	mov	edx, 4			# /
	sub	edx, dword ptr -8[rbp]	# | вычитаем из 4
	movsx	rdx, edx		# \
	lea	rcx, 0[0+rdx*4]		# /
	mov	rdx, qword ptr -32[rbp]	# |	получаем i
	add	rdx, rcx			# \
	mov	eax, dword ptr [rax]	# eax = rax
	mov	dword ptr [rdx], eax	
.l7:
	sub	dword ptr -8[rbp], 1	# --i
.l5:
	cmp	dword ptr -8[rbp], 0	# сравнить 0 и i на выход из цикла
	jns	.l9			
	nop				# не выполняет никакой операции, занимает место в потоме команд
	nop				# не выполняет никакой операции, занимает место в потоме команд
	pop	rbp			# / завершение функции
	ret				# \ 
	
havepositive: 				# функция проверки на хотя бы одно положительное число
	push	rbp			# сохранение rbp на стек
	mov	rbp, rsp		# rbp := rsp
	mov	qword ptr -24[rbp], rdi 	# указатель на а 
	mov	r12d, 0		# r12d := 0
	jmp	.l11			# go to .l11
.l14:
	mov	eax, r12d		# eax := r12d
	cdqe				# преобразование в sign-extend
	lea	rdx, 0[0+rax*4]	# rdx := rax * 4
	mov	rax, qword ptr -24[rbp]	
	add	rax, rdx		# rax += rdx
	mov	eax, dword ptr [rax] 
	test	eax, eax		# проверка условия
	jle	.l12			# jump less => .l12
	mov	eax, 1			# return true
	jmp	.l13			# go to l.13
.l12:
	add	r12d, 1		# r12d += 1
.l11:
	cmp	r12d, 4		# сранения нашего i
	jle	.l14			# jump less => .l14
	mov	eax, 0			# return false
.l13:
	pop	rbp			# / завершение метода
	ret				# \
.lc1:
	.string	"%d "		# .string
	
printarr:
	push	rbp			# сохранение rbp на стек
	mov	rbp, rsp		# rbp := rsp
	sub	rsp, 32		# rsp -= 32 (выделяем память для фрейма)
	mov	qword ptr -24[rbp], rdi	# указатель на массив
	mov	dword ptr -28[rbp], esi
	mov	r12d, 0		# i = 0
	jmp	.l16			# go to .l16
.l17:
	mov	eax, r12d		# eax := r12d
	cdqe				# преобразование в sign-extend
	lea	rdx, 0[0+rax*4]	# rdx := rax * 4
	mov	rax, qword ptr -24[rbp]	# rax := rbp - 24
	add	rax, rdx		# rax += rdx
	mov	eax, dword ptr [rax]	# eax := rax
	mov	esi, eax		# esi := eax
	lea	rdi, .lc1[rip]
	mov	eax, 0			# eax := 0
	call	printf@plt		# вызов функции printf
	add	r12d, 1		# ++i
.l16:
	mov	eax, r12d		# eax := r12d
	cmp	eax, dword ptr -28[rbp]	# сравнение eax с rbp-28 на выход из цикла 
	jl	.l17			# jump less => .l17
	nop				# не выполняет никакой операции, занимает место в потоме команд
	nop				# не выполняет никакой операции, занимает место в потоме команд
	leave				# / выход из функции
	ret				# \
		
	.globl	main			# / указание на main
	.type	main, @function	# \
	
main:				
	push	rbp			# сохранение rbp на стек
	mov	rbp, rsp		# rbp := rsp
	sub	rsp, 80		# rsp -= 80 (выделяем память для фрейма)
	lea	rdi, -32[rbp]		# сразу присваиваем rdi := $(-32 на стеке)
	call	inputarr		# вызов функции ввода массива
	lea	rax, -32[rbp]			
	mov	rdi, rax		# rdi := rax
	call	havepositive		# вызов функции havePositive
	test	al, al			# проверка результата функции havePositive
	je	.l19			# go to .l19
	lea	rdx, -48[rbp]		# rdx := rbp -48
	lea	rax, -32[rbp]		# rax := rbp - 32
	mov	rsi, rdx		# rsi := rdx
	mov	rdi, rax		# rdi := rax 
	call	createnewarr		# вызов функции creatNewArr
	lea	rax, -48[rbp]		# rax := rbp - 48
	mov	esi, 4			# esi := 4
	mov	rdi, rax		# rdi := rax
	call	printarr		# вызов функции printArr
	jmp	.l20			# go to .l20
.l19:
	lea	rdx, -80[rbp]		# rdx := rbp - 80
	lea	rax, -32[rbp]		# rax := rbp -32
	mov	rsi, rdx		# rsi := rdx
	mov	rdi, rax		# rdi := rax
	call	createnewarr		# вызов функции creayeNewArr
	lea	rax, -80[rbp]		# rax := rbp - 80
	mov	esi, 5			# esi := 5
	mov	rdi, rax		# rdi := rax
	call	printarr		# вызов функции printArr
.l20:
	mov	eax, 0			# возвращение в eax 0
	leave				# / выход из функции
	ret				# \
