#include <xc.inc>

; CONFIG1L
  CONFIG  PLLDIV = 1            ; PLL Prescaler Selection bits (No prescale (4 MHz oscillator input drives PLL directly))
  CONFIG  CPUDIV = OSC1_PLL2    ; System Clock Postscaler Selection bits ([Primary Oscillator Src: /1][96 MHz PLL Src: /2])
  CONFIG  USBDIV = 1            ; USB Clock Selection bit (used in Full-Speed USB mode only; UCFG:FSEN = 1) (USB clock source comes directly from the primary oscillator block with no postscale)

; CONFIG1H
  CONFIG  FOSC = XT_XT          ; Oscillator Selection bits (XT oscillator (XT))
  CONFIG  FCMEN = OFF           ; Fail-Safe Clock Monitor Enable bit (Fail-Safe Clock Monitor disabled)
  CONFIG  IESO = OFF            ; Internal/External Oscillator Switchover bit (Oscillator Switchover mode disabled)

; CONFIG2L
  CONFIG  PWRT = ON             ; Power-up Timer Enable bit (PWRT enabled)
  ;CONFIG  BOR = ON              ; Brown-out Reset Enable bits (Brown-out Reset enabled in hardware only (SBOREN is disabled))
  CONFIG  BORV = 3              ; Brown-out Reset Voltage bits (Minimum setting 2.05V)
  CONFIG  VREGEN = OFF          ; USB Voltage Regulator Enable bit (USB voltage regulator disabled)

; CONFIG2H
  CONFIG  WDT = OFF             ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
  CONFIG  WDTPS = 1             ; Watchdog Timer Postscale Select bits (1:1)

; CONFIG3H
  CONFIG  CCP2MX = OFF          ; CCP2 MUX bit (CCP2 input/output is multiplexed with RB3)
  CONFIG  PBADEN = OFF          ; PORTB A/D Enable bit (PORTB<4:0> pins are configured as digital I/O on Reset)
  CONFIG  LPT1OSC = OFF         ; Low-Power Timer 1 Oscillator Enable bit (Timer1 configured for higher power operation)
  CONFIG  MCLRE = ON            ; MCLR Pin Enable bit (MCLR pin enabled; RE3 input pin disabled)

; CONFIG4L
  CONFIG  STVREN = OFF          ; Stack Full/Underflow Reset Enable bit (Stack full/underflow will not cause Reset)
  CONFIG  LVP = OFF             ; Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)
  CONFIG  ICPRT = OFF           ; Dedicated In-Circuit Debug/Programming Port (ICPORT) Enable bit (ICPORT disabled)
  CONFIG  XINST = OFF           ; Extended Instruction Set Enable bit (Instruction set extension and Indexed Addressing mode disabled (Legacy mode))

; CONFIG5L
  CONFIG  CP0 = OFF             ; Code Protection bit (Block 0 (000800-001FFFh) is not code-protected)
  CONFIG  CP1 = OFF             ; Code Protection bit (Block 1 (002000-003FFFh) is not code-protected)
  CONFIG  CP2 = OFF             ; Code Protection bit (Block 2 (004000-005FFFh) is not code-protected)
  CONFIG  CP3 = OFF             ; Code Protection bit (Block 3 (006000-007FFFh) is not code-protected)

; CONFIG5H
  CONFIG  CPB = OFF             ; Boot Block Code Protection bit (Boot block (000000-0007FFh) is not code-protected)
  CONFIG  CPD = OFF             ; Data EEPROM Code Protection bit (Data EEPROM is not code-protected)

; CONFIG6L
  CONFIG  WRT0 = OFF            ; Write Protection bit (Block 0 (000800-001FFFh) is not write-protected)
  CONFIG  WRT1 = OFF            ; Write Protection bit (Block 1 (002000-003FFFh) is not write-protected)
  CONFIG  WRT2 = OFF            ; Write Protection bit (Block 2 (004000-005FFFh) is not write-protected)
  CONFIG  WRT3 = OFF            ; Write Protection bit (Block 3 (006000-007FFFh) is not write-protected)

; CONFIG6H
  CONFIG  WRTC = OFF            ; Configuration Register Write Protection bit (Configuration registers (300000-3000FFh) are not write-protected)
  CONFIG  WRTB = OFF            ; Boot Block Write Protection bit (Boot block (000000-0007FFh) is not write-protected)
  CONFIG  WRTD = OFF            ; Data EEPROM Write Protection bit (Data EEPROM is not write-protected)

; CONFIG7L
  CONFIG  EBTR0 = OFF           ; Table Read Protection bit (Block 0 (000800-001FFFh) is not protected from table reads executed in other blocks)
  CONFIG  EBTR1 = OFF           ; Table Read Protection bit (Block 1 (002000-003FFFh) is not protected from table reads executed in other blocks)
  CONFIG  EBTR2 = OFF           ; Table Read Protection bit (Block 2 (004000-005FFFh) is not protected from table reads executed in other blocks)
  CONFIG  EBTR3 = OFF           ; Table Read Protection bit (Block 3 (006000-007FFFh) is not protected from table reads executed in other blocks)

; CONFIG7H
  CONFIG  EBTRB = OFF           ; Boot Block Table Read Protection bit (Boot block (000000-0007FFh) is not protected from table reads executed in other blocks)

;****************Definicion de variables********************************
PSECT udata
 INPUT:
	DS 1
 INPUT2:
	DS 1
RESULTADO:
	DS 1

;CONSTANT		MASK	= 0b00001111

;****************Programa principal **************************************************
	PSECT   code;barfunc,local,class=CODE,delta=2 ; PIC10/12/16
	
			ORG     0x000             	;reset vector
  			GOTO    MAIN              	;go to the main routine

INITIALIZE:
		    
			MOVLW 0x0F			;todas entradas digitales
			MOVWF ADCON1,c
			
			SETF	LATB,c			;PORTB como entrada
			CLRF	LATD,c			;PORTD como salida
			SETF	TRISB,c			;PORTB como entrada
			CLRF	TRISD,c			;PORTD como salida

			RETURN			

MAIN:
		CALL 	INITIALIZE
LOOP:
			MOVF	PORTB, W            ;mover portb al registro input
			ANDLW	0x0F	            ;aplicar and (mascara)
			MOVWF   INPUT

			
			MOVF	PORTB, W            ;mover portb al acumulador
			ANDLW	0xF0	            ;aplicar and (mascara)
			MOVWF   INPUT2
			
			
			MOVLW	0x00		    ;mover cero al acumulador
			SUBWF	INPUT,	0,1	    ;restar 0 a la entrada
			BZ	CERO		    ;caso 0
			
			MOVLW	0x01		    ;mover cero al acumulador
			SUBWF	INPUT,	W	    ;restar 0 a la entrada
			BZ	UNO		    ;caso 0 
			
			MOVLW	0x02		    ;mover cero al acumulador
			SUBWF	INPUT,	W	    ;restar 0 a la entrada
			BZ	DOS		    ;caso 0 
			
			MOVLW	0x03		    ;mover cero al acumulador
			SUBWF	INPUT,	W	    ;restar 0 a la entrada
			BZ	TRES		    ;caso 0 
			
			MOVLW	0x04		    ;mover cero al acumulador
			SUBWF	INPUT,	W	    ;restar 0 a la entrada
			BZ	CUATRO		    ;caso 0 
			
			MOVLW	0x05		    ;mover cero al acumulador
			SUBWF	INPUT,	W	    ;restar 0 a la entrada
			BZ	CINCO		    ;caso 0 
			
			MOVLW	0x06		    ;mover cero al acumulador
			SUBWF	INPUT,	W	    ;restar 0 a la entrada
			BZ	SEIS		    ;caso 0
			
			MOVLW	0x07		    ;mover cero al acumulador
			SUBWF	INPUT,	W	    ;restar 0 a la entrada
			BZ	SIETE		    ;caso 0 
			
			MOVLW	0x08		    ;mover cero al acumulador
			SUBWF	INPUT,	W	    ;restar 0 a la entrada
			BZ	OCHO		    ;caso 0 
			
			MOVLW	0x09		    ;mover cero al acumulador
			SUBWF	INPUT,	W	    ;restar 0 a la entrada
			BZ	NUEVE		    ;caso 0 
			
			MOVLW	0x0A		    
			SUBWF	INPUT,	W	    
			BZ	DIEZ		     
			
			MOVLW	0x0B		    
			SUBWF	INPUT,	W	    
			BZ	ONCE		    
			
			MOVLW	0x0C		    
			SUBWF	INPUT,	W	    
			BZ	DOCE		   
			
			MOVLW	0x0D		  
			SUBWF	INPUT,	W	   
			BZ	TRECE		   
			
			MOVLW	0x0E		    
			SUBWF	INPUT,	W	   
			BZ	CATORCE		   
			
			MOVLW	0x0F		    
			SUBWF	INPUT,	W	    
			BZ	QUINCE		    
			
			
			BRA	DEFAULT
			
CERO:
						    ;salida 0 en display
		    MOVLW 00111111B
		    MOVWF PORTD
		    GOTO LOOP
		    
UNO:
		    MOVLW 00000110B		    ;salida 1 en display
		    MOVWF PORTD
		    GOTO LOOP	    
		    
DOS:
		    MOVLW 01011011B		    ;salida 2 en display
		    MOVWF PORTD
		    GOTO LOOP	    
		    
TRES:
		    MOVLW 01001111B		   ;salida 3 en display
		    MOVWF PORTD
		    GOTO LOOP
		    
CUATRO:						  
		    MOVLW 01100110B		    ;salida 4 en display
		    MOVWF PORTD
		    GOTO LOOP

CINCO:						  
		    MOVLW 01101101B		    ;salida 5 en display
		    MOVWF PORTD
		    GOTO LOOP
		    
SEIS:						  
		    MOVLW 01111101B		    ;salida 6 en display
		    MOVWF PORTD
		    GOTO LOOP
		    
SIETE:						  
		    MOVLW 00000111B		    ;salida 7 en display
		    MOVWF PORTD
		    GOTO LOOP
OCHO:						  
		    MOVLW 01111111B		    ;salida 8 en display
		    MOVWF PORTD
		    GOTO LOOP
NUEVE:						  
		    MOVLW 01101111B		    ;salida 9 en display
		    MOVWF PORTD
		    GOTO LOOP
		    
DIEZ:						  
		    MOVLW 01110111B		    ;salida A en display
		    MOVWF PORTD
		    GOTO LOOP
		    
ONCE:						  
		    MOVLW 00011111B		    ;salida B en display
		    MOVWF PORTD
		    GOTO LOOP
		    
DOCE:						  
		    MOVLW 01001110B		    ;salida C en display
		    MOVWF PORTD
		    GOTO LOOP		    
		    
TRECE:						  
		    MOVLW 00111101B		    ;salida D en display
		    MOVWF PORTD
		    GOTO LOOP
		    
CATORCE:						  
		    MOVLW 0101111B		    ;salida E en display
		    MOVWF PORTD
		    GOTO LOOP	
		    
QUINCE:						  
		    MOVLW 01000111B		    ;salida F en display
		    MOVWF PORTD
		    GOTO LOOP
		    
		    
DEFAULT:	
		    MOVLW 00110111B		    ;salida N en display
		    MOVWF PORTD
		    GOTO LOOP
		    
		    
			
   
    			
			END                       	;fin del programa
