# Código de combinações do Menu do primeiro Problema do Módulo Integratório de Sistemas Digitais 2019.1
# Alunos: Ramon Silva, Alan Bruno, Pedro Mota, Laercio Rios

# Declaração de variáveis globais
.data
.equ buttons, 0x00002050 #Endereços dos botões, disponibilizados pelo processador NiosII
.equ leds, 0x00002040 	 #Endereços da matriz de led, disponibilizados pelo processador NiosII	

#Macro usado para instrucoes do lcd, facilita a chamada
.macro instr databits
	movi r1, 0 # Adiciona 0 ao registrador r1 para o Modulo LCD (Custom Instruction) reconhecer que será dados para instruções 
	custom 0, r0, r1, \databits  # custom index, result, dataA, dataB   custom index, data result, data instr or write, databyte chain 
.endm
#Macro usado para dados no lcd, facilita a chamada
.macro data databits
	movi r1, 1 # Adiciona 1 ao registrador r1 para o Modulo LCD (Custom Instruction) reconhecer que será dados para escrita 
	custom 0, r0, r1, \databits
.endm

.equ button1, 0x1
.equ button2, 0x2
.equ button3, 0x4
.equ led1, 0x1e
.equ led2, 0x1d
.equ led3, 0x1b
.equ led4, 0x17
.equ led5, 0xf
.equ ledst, 0x1f

.text
.global _start

#Rótulo principal para guardar os valores das variáveis globais em registradores
_start:
call initialize

# Rótulo inicial para o Menu, representando a cidade de Honolulu. Esse rótulo espera o usúario acionar os botões para realizar 
# as devidas funções relecionada ao botão.
honolulu:
stbio r16, 0(r13)
ldbio r1, 0(r12)
mov r10, r1
mov r11, r0
bne r1, r0, verificaHonolulu
bne r14, r0, honolulu
addi r14, r0, 0x1
call honoluluLcd
br honolulu

moscou:
stbio r16, 0(r13)
ldbio r1, 0(r12)
mov r10, r1
mov r11, r0
bne r1, r0, verificaMoscou
bne r14, r0, moscou
addi r14, r0, 0x1
call moscouLcd
br moscou

feira:
stbio r16, 0(r13)
ldbio r1, 0(r12)
mov r10, r1
mov r11, r0
bne r1, r0, verificaFeira
bne r14, r0, feira
addi r14, r0, 0x1
call feiraLcd
br feira

lima:
stbio r16, 0(r13)
ldbio r1, 0(r12)
mov r10, r1
mov r11, r0
bne r1, r0, verificaLima
bne r14, r0, lima
addi r14, r0, 0x1
call limaLcd
br lima

cairo:
stbio r16, 0(r13)
ldbio r1, 0(r12)
mov r10, r1
mov r11, r0
bne r1, r0, verificaCairo
bne r14, r0, cairo
addi r14, r0, 0x1
call cairoLcd
br cairo

# Neste rótulo ele espera o usúario soltar o botão para poder acionar a função desejada, assim melhorando a  otimização do códi-
# digo e tratando pulos continuos de rótulos.
verificaHonolulu:
ldbio r1, 0(r12)
bne r1, r0, verificaHonolulu
mov r14, r0
beq r10, r11, honolulu
beq r2, r10, cairo
beq r3, r10, moscou
beq r4, r10, honoluluMensage

verificaMoscou:
ldbio r1, 0(r12)
bne r1, r0, verificaMoscou
mov r14, r0
beq r10, r11, moscou
beq r2, r10, honolulu
beq r3, r10, feira
beq r4, r10, moscouMensage

verificaFeira:
ldbio r1, 0(r12)
bne r1, r0, verificaFeira
mov r14, r0
beq r10, r11, feira
beq r2, r10, moscou
beq r3, r10, lima
beq r4, r10, feiraMensage

verificaLima:
ldbio r1, 0(r12)
bne r1, r0, verificaLima
mov r14, r0
beq r10, r11, lima
beq r2, r10, feira
beq r3, r10, cairo
beq r4, r10, limaMensage

verificaCairo:
ldbio r1, 0(r12)
bne r1, r0, verificaCairo
mov r14, r0
beq r10, r11, cairo
beq r2, r10, lima
beq r3, r10, honolulu
beq r4, r10, cairoMensage

#Liga a cadeia de leds indicado e espera o usúario acionar o botão de retorno voltando para o rótulo de verificação.
honoluluMensage:
ldbio r1, 0(r12)
stbio r5, 0(r13)
mov r11, r10
bne r1, r0, verificaHonolulu
bne r14, r0, honoluluMensage
addi r14, r0, 0x1
call honoluluTicket
br honoluluMensage

moscouMensage:
ldbio r1, 0(r12)
stbio r6, 0(r13)
mov r11, r10
bne r1, r0, verificaMoscou
bne r14, r0, moscouMensage
addi r14, r0, 0x1
call moscouTicket
br moscouMensage

feiraMensage:
ldbio r1, 0(r12)
stbio r7, 0(r13)
mov r11, r10
bne r1, r0, verificaFeira
bne r14, r0, feiraMensage
addi r14, r0, 0x1
call feiraTicket
br feiraMensage

limaMensage:
ldbio r1, 0(r12)
stbio r8, 0(r13)
mov r11, r10
bne r1, r0, verificaLima
bne r14, r0, limaMensage
addi r14, r0, 0x1
call limaTicket
br limaMensage

cairoMensage:
ldbio r1, 0(r12)
stbio r9, 0(r13)
mov r11, r10
bne r1, r0, verificaCairo
bne r14, r0, cairoMensage
addi r14, r0, 0x1
call cairoTicket
br cairoMensage

#Mensagens iniciais de cada opção do menu no LCD
honoluluLcd:
movi r15, 0x1 #Limpa buffer do LCD
instr r15
movi r15, 0x31 #1
data r15
movi r15, 0x2e #.
data r15
movi r15, 0x20 #espaço
data r15
movi r15, 0x48 #H
data r15
movi r15, 0x6f #o
data r15
movi r15, 0x6e #n
data r15
movi r15, 0x6f #o
data r15
movi r15, 0x7c #l
data r15
movi r15, 0x75 #u
data r15
movi r15, 0x7c #l
data r15
movi r15, 0x75 #u
data r15
movi r15, 0x8c # começa a digitar no 13º cursor
instr r15
movi r15, 0x8 #seta para esquerda
data r15
movi r15, 0xc0 # move para 2 linha
instr r15
movi r15, 0x32 #2
data r15
movi r15, 0x2e #.
data r15
movi r15, 0x20 #espaço
data r15
movi r15, 0x4d #M
data r15
movi r15, 0x6f #o
data r15
movi r15, 0x73 #s
data r15
movi r15, 0x63 #c
data r15
movi r15, 0x6f #o
data r15
movi r15, 0x75 #u
data r15
ret

moscouLcd:
movi r15, 0x1
instr r15
movi r15, 0x32 #2
data r15
movi r15, 0x2e #.
data r15
movi r15, 0x20 #espaço
data r15
movi r15, 0x4d #M
data r15
movi r15, 0x6f #o
data r15
movi r15, 0x73 #s
data r15
movi r15, 0x63 #c
data r15
movi r15, 0x6f #o
data r15
movi r15, 0x75 #u
data r15
movi r15, 0x8c # começa a digitar no 13º cursor
instr r15
movi r15, 0x8 #seta para esquerda
data r15
movi r15, 0xc0 # move para 2 linha
instr r15
movi r15, 0x33 #3
data r15
movi r15, 0x2e #.
data r15
movi r15, 0x20 #espaço
data r15
movi r15, 0x46 #F
data r15
movi r15, 0x65 #e
data r15
movi r15, 0x69 #i
data r15
movi r15, 0x72 #r
data r15
movi r15, 0x61 #a
data r15
ret

feiraLcd:
movi r15, 0x1
instr r15
movi r15, 0x33 #3
data r15
movi r15, 0x2e #.
data r15
movi r15, 0x20 #espaço
data r15
movi r15, 0x46 #F
data r15
movi r15, 0x65 #e
data r15
movi r15, 0x69 #i
data r15
movi r15, 0x72 #r
data r15
movi r15, 0x61 #a
data r15
movi r15, 0x8c # começa a digitar no 13º cursor
instr r15
movi r15, 0x8 #seta para esquerda
data r15
movi r15, 0xc0 # move para 2 linha
instr r15
movi r15, 0x34 #4
data r15
movi r15, 0x2e #.
data r15
movi r15, 0x20 #espaço
data r15
movi r15, 0x4c #L
data r15
movi r15, 0x69 #i
data r15
movi r15, 0x6d #m
data r15
movi r15, 0x61 #a
data r15
ret

limaLcd:
movi r15, 0x1
instr r15
movi r15, 0x34 #4
data r15
movi r15, 0x2e #.
data r15
movi r15, 0x20 #espaço
data r15
movi r15, 0x4c #L
data r15
movi r15, 0x69 #i
data r15
movi r15, 0x6d #m
data r15
movi r15, 0x61 #a
data r15
movi r15, 0x8c # começa a digitar no 13º cursor
instr r15
movi r15, 0x8 #seta para esquerda
data r15
movi r15, 0xc0 # move para 2 linha
instr r15
movi r15, 0x35 #5
data r15
movi r15, 0x2e #.
data r15
movi r15, 0x20 #espaço
data r15
movi r15, 0x43 #C
data r15
movi r15, 0x61 #a
data r15
movi r15, 0x69 #i
data r15
movi r15, 0x72 #r
data r15
movi r15, 0x6f #o
data r15
ret

cairoLcd:
movi r15, 0x1
instr r15
movi r15, 0x35 #5
data r15
movi r15, 0x2e #.
data r15
movi r15, 0x20 #espaço
data r15
movi r15, 0x43 #C
data r15
movi r15, 0x61 #a
data r15
movi r15, 0x69 #i
data r15
movi r15, 0x72 #r
data r15
movi r15, 0x6f #o
data r15
movi r15, 0x8c # começa a digitar no 13º cursor
instr r15
movi r15, 0x8 #seta para esquerda
data r15
movi r15, 0xc0 # move para 2 linha
instr r15
movi r15, 0x31 #1
data r15
movi r15, 0x2e #.
data r15
movi r15, 0x20 #espaço
data r15
movi r15, 0x48 #H
data r15
movi r15, 0x6f #o
data r15
movi r15, 0x6e #n
data r15
movi r15, 0x6f #o
data r15
movi r15, 0x7c #l
data r15
movi r15, 0x75 #u
data r15
movi r15, 0x7c #l
data r15
movi r15, 0x75 #u
data r15
ret

#Caracteres do LCD para quando alguma opção for selecionada
honoluluTicket:
movi r15, 0x1 #Limpa o buffer do LCD
instr r15
movi r15, 0x54 #T 
data r15
movi r15, 0x69 #i
data r15
movi r15, 0x63 #c
data r15
movi r15, 0x6b #k
data r15
movi r15, 0x65 #e 
data r15
movi r15, 0x74 #t
data r15
movi r15, 0x20 #espaço
data r15
movi r15, 0x70 #p
data r15
movi r15, 0x61 #a
data r15
movi r15, 0x72 #r
data r15
movi r15, 0x61 #a 
data r15
movi r15, 0xc0 #move para a segunda linha
instr r15 
movi r15, 0x48 #H
data r15
movi r15, 0x6f #o
data r15
movi r15, 0x6e #n
data r15
movi r15, 0x6f #o
data r15
movi r15, 0x7c #l
data r15
movi r15, 0x75 #u
data r15
movi r15, 0x7c #l
data r15
movi r15, 0x75 #u
data r15
movi r15, 0x21 #! 
data r15
ret

moscouTicket:
movi r15, 0x1 
instr r15
movi r15, 0x54 #T 
data r15
movi r15, 0x69 #i
data r15
movi r15, 0x63 #c
data r15
movi r15, 0x6b #k
data r15
movi r15, 0x65 #e 
data r15
movi r15, 0x74 #t
data r15
movi r15, 0x20 #espaço
data r15
movi r15, 0x70 #p
data r15
movi r15, 0x61 #a
data r15
movi r15, 0x72 #r
data r15
movi r15, 0x61 #a 
data r15
movi r15, 0xc0 #move para a segunda linha
instr r15 
movi r15, 0x4d #M
data r15
movi r15, 0x6f #o
data r15
movi r15, 0x73 #s
data r15
movi r15, 0x63 #c
data r15
movi r15, 0x6f #o
data r15
movi r15, 0x75 #u
data r15
movi r15, 0x21 #! 
data r15
ret

feiraTicket:
movi r15, 0x1 
instr r15
movi r15, 0x54 #T 
data r15
movi r15, 0x69 #i
data r15
movi r15, 0x63 #c
data r15
movi r15, 0x6b #k
data r15
movi r15, 0x65 #e 
data r15
movi r15, 0x74 #t
data r15
movi r15, 0x20 #espaço
data r15
movi r15, 0x70 #p
data r15
movi r15, 0x61 #a
data r15
movi r15, 0x72 #r
data r15
movi r15, 0x61 #a 
data r15
movi r15, 0xc0 #move para a segunda linha
instr r15 
movi r15, 0x46 #F
data r15
movi r15, 0x65 #e
data r15
movi r15, 0x69 #i
data r15
movi r15, 0x72 #r
data r15
movi r15, 0x61 #a
data r15
movi r15, 0x21 #! 
data r15
ret

limaTicket:
movi r15, 0x1 
instr r15
movi r15, 0x54 #T 
data r15
movi r15, 0x69 #i
data r15
movi r15, 0x63 #c
data r15
movi r15, 0x6b #k
data r15
movi r15, 0x65 #e 
data r15
movi r15, 0x74 #t
data r15
movi r15, 0x20 #espaço
data r15
movi r15, 0x70 #p
data r15
movi r15, 0x61 #a
data r15
movi r15, 0x72 #r
data r15
movi r15, 0x61 #a 
data r15
movi r15, 0xc0 #move para a segunda linha
instr r15 
movi r15, 0x4c #L
data r15
movi r15, 0x69 #i
data r15
movi r15, 0x6d #m
data r15
movi r15, 0x61 #a
data r15
movi r15, 0x21 #! 
data r15
ret

cairoTicket:
movi r15, 0x1 
instr r15
movi r15, 0x54 #T 
data r15
movi r15, 0x69 #i
data r15
movi r15, 0x63 #c
data r15
movi r15, 0x6b #k
data r15
movi r15, 0x65 #e 
data r15
movi r15, 0x74 #t
data r15  
movi r15, 0x20 #espaço
data r15
movi r15, 0x70 #p
data r15
movi r15, 0x61 #a
data r15
movi r15, 0x72 #r
data r15
movi r15, 0x61 #a 
data r15

movi r15, 0xc0 #move para a segunda linha
instr r15 
movi r15, 0x43 #c
data r15
movi r15, 0x61 #a 
data r15
movi r15, 0x69 #i
data r15
movi r15, 0x72 #r
data r15
movi r15, 0x6f #o
data r15
movi r15, 0x21 #! 
data r15
ret

# Inicializa o LCD com suas instruções de fucionamento e adiciona aos registradores os endereços dos botoes,leds
initialize:
# Inicializa o LCD
movi r15, 0x30 #Seleciona função
instr r15
movi r15, 0x39 #Seleciona função
instr r15
movi r15, 0x14 #Ajuste de clock interno
instr r15
movi r15, 0x56 #Power/ICON/Contrast
instr r15
movi r15, 0x6d #Folower control
instr r15
movi r15, 0x0c #Liga o Display
instr r15
movi r15, 0x06 #Entra em modo de cursor
instr r15
movi r15, 0x01 #Limpa o Display
instr r15

# Adicionando endereço de botoes, leds, aos registradores
movi r12, buttons
movi r13, leds
movi r2, button1
movi r3, button2
movi r4, button3
movi r5, led1
movi r6, led2
movi r7, led3
movi r8, led4
movi r9, led5
movi r16, ledst
ret

end:
br end