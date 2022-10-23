АВС ИДЗ №1 

Создал програму на Си, затем на ассемблере.  (Прикрепил 2 файла с ассемблером до и после всех сокращений кода и оптимизаций)
Проверил, что обе программы выдают правильный результат:  
![image](/static/asm.jpg)  
За счет флагов и ручного редактирования сократил код на ассемблере.  
Прокомментировал весь полученый код.  
Запустил тесты, убедился, что все работает корректно:  
![image](/static/tests.jpg)

Использовал функции с передачей данных через параметры и локальные перемнные, все функции подробно прокомментировал)

Произвел следующие оптимизации кода:  
	lea		rdi, -32[rbp]  
	mov		rdi, rax  
заменил сразу на:   
	lea	rdi, -32[rbp]  
	
Использовал регистр r12d, вмсето стека DWORD PTR -4[rbp]  
Убрал ненужый код после ret  
Убрал endr64  
(Сократил код с 274 до 197 строк)  
Добавил комментарии, поясняющие использование регистров, эвивалентных коду на С

Прогнал опять тесты, все работает коректно.
Вроде выполнил все пункты на 6)
