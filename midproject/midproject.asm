	#include<p18f4550.inc>

loop1 		set 0x00
loop2 		set 0x01

			org 0x00
			goto start
			org 0x08
			retfie
			org 0x18
			retfie

nothing 	macro n
			variable i
i=0
			while i < n
			nop
i+=1
			endw
			endm







;****************************************************************
;           main program
;****************************************************************
start		call	lcd
			movlw	B'00000110'
			movwf	TRISC,A
check1		BTFSS	PORTC,1,A
			bra		check2
			call	zulaikha
check2		BTFSS	PORTC,2,A
			bra		check1
			call	studentID
next		call	keypad
			bra		check1










;****************************************************************
;           keypad configuration sub
;****************************************************************
conA		bsf		PORTB,4,A
			bcf		PORTB,5,A
			bcf		PORTB,6,A
			bcf		PORTB,7,A
			return
conB		bcf		PORTB,4,A
			bsf		PORTB,5,A
			bcf		PORTB,6,A
			bcf		PORTB,7,A
			return
conC		bcf		PORTB,4,A
			bcf		PORTB,5,A
			bsf		PORTB,6,A
			bcf		PORTB,7,A
			return
conD		bcf		PORTB,4,A
			bcf		PORTB,5,A
			bcf		PORTB,6,A
			bsf		PORTB,7,A
			return

;****************************************************************
;           keypad testing bit sub
;****************************************************************
keypad		movlw	B'00001110'
			movwf	TRISB,A
one1		call	conA
			btfss	PORTB,1,A
			bra		two2
			call	show1	
two2		call	conA
			btfss	PORTB,2,A
			bra		three3
			call	show2
three3		call	conA
			btfss	PORTB,3,A
			bra		four4
			call	show3
four4		call	conB
			btfss	PORTB,1,A
			bra		five5
			call	show4	
five5		call	conB
			btfss	PORTB,2,A
			bra		six6
			call	show5
six6		call	conB
			btfss	PORTB,3,A
			bra		seven7
			call	show6
seven7		call	conC
			btfss	PORTB,1,A
			bra		eight8
			call	show7	
eight8		call	conC
			btfss	PORTB,2,A
			bra		nine9
			call	show8
nine9		call	conC
			btfss	PORTB,3,A
			bra		star
			call	show9
star		call	conD
			btfss	PORTB,1,A
			bra		zero0
			call	showstar	
zero0		call	conD
			btfss	PORTB,2,A
			bra		hashtag#
			call	show0
hashtag#	call	conD
			btfss	PORTB,3,A
			bra		one1
			call	show#
			return
			
;****************************************************************
;           LCD command sub
;****************************************************************
commlcd		bcf		PORTC,4,A
			bcf		PORTC,5,A
			bsf		PORTC,6,A
			call	delay
			bcf		PORTC,6,A
			return

;****************************************************************
;           send data command sub
;****************************************************************
sendata		bsf		PORTC,4,A
			bcf		PORTC,5,A
			bsf		PORTC,6,A
			call	delay
			bcf		PORTC,6,A
			return

;****************************************************************
;           configure LCD 
;****************************************************************
lcd			movlw	B'00000110'
			movwf	TRISC,A
			clrf	TRISD,A
matrix		movlw	0x38
			movwf	PORTD,A
			call	commlcd
cursor		movlw	0x0E
			movwf	PORTD,A
			call	commlcd
cleardisp	movlw	0x01
			movwf	PORTD,A
			call	commlcd
			return

;****************************************************************
;           configure LCD 2nd line 
;****************************************************************
force1st	call	lcd
			movlw	0x80
			movwf	PORTD,A
			call	commlcd
			return

force2nd	call	lcd
			movlw	0xC0
			movwf	PORTD,A
			call	commlcd
			return

;****************************************************************
;           display zulaikha sub
;****************************************************************
zulaikha	call	force1st
			movlw	D'122'	;z
			movwf	PORTD,A
			call	sendata
			movlw	D'117'	;u
			movwf	PORTD,A
			call	sendata
			movlw	D'108'	;l
			movwf	PORTD,A
			call	sendata
			movlw	D'97'	;a
			movwf	PORTD,A
			call	sendata
			movlw	D'105'	;i
			movwf	PORTD,A
			call	sendata
			movlw	D'107'	;k
			movwf	PORTD,A
			call	sendata
			movlw	D'104'	;h
			movwf	PORTD,A
			call	sendata
			movlw	D'97'	;a
			movwf	PORTD,A
			call	sendata
			return

;****************************************************************
;           display studentID sub
;****************************************************************
studentID	call	force1st
			movlw	D'68'	;D
			movwf	PORTD,A
			call	sendata
			movlw	D'69'	;E
			movwf	PORTD,A
			call	sendata
			movlw	D'57'	;9
			movwf	PORTD,A
			call	sendata
			movlw	D'54'	;6
			movwf	PORTD,A
			call	sendata
			movlw	D'54'	;6
			movwf	PORTD,A
			call	sendata
			movlw	D'50'	;2
			movwf	PORTD,A
			call	sendata
			movlw	D'57'	;9
			movwf	PORTD,A
			call	sendata
			return

;****************************************************************
;           display keypad sub
;****************************************************************
show1		call	force2nd
			movlw	D'49'	
			movwf	PORTD,A
			call	sendata
			return	
show2		call	force2nd
			movlw	D'50'	
			movwf	PORTD,A
			call	sendata
			return
show3	   	call	force2nd
			movlw	D'51'	
			movwf	PORTD,A
			call	sendata
			return	
show4		call	force2nd
			movlw	D'52'	
			movwf	PORTD,A
			call	sendata
			return
show5		call	force2nd
			movlw	D'53'	
			movwf	PORTD,A
			call	sendata
			return	
show6		call	force2nd
			movlw	D'54'	
			movwf	PORTD,A
			call	sendata
			return
show7		call	force2nd
			movlw	D'55'	
			movwf	PORTD,A
			call	sendata
			return	
show8		call	force2nd
			movlw	D'56'	
			movwf	PORTD,A
			call	sendata
			return
show9		call	force2nd
			movlw	D'57'	
			movwf	PORTD,A
			call	sendata
			return	
show0		call	force2nd
			movlw	D'48'	
			movwf	PORTD,A
			call	sendata
			return
showstar	call	force2nd
			movlw	D'42'	
			movwf	PORTD,A
			call	sendata
			return	
show#		call	force2nd
			movlw	D'35'	
			movwf	PORTD,A
			call	sendata
			return

;****************************************************************
;           delay 5-10ms frequency 20MHz sub
;****************************************************************
delay 		MOVLW 	D'20' 	
			MOVWF 	loop2,A 
again 		MOVLW 	D'250'
			MOVWF 	loop1,A
again2		nothing D'17'
			DECFSZ 	loop1,F,A
			BRA 	again2
			DECFSZ 	loop2,F,A
			BRA 	again
			NOP
			RETURN
			END