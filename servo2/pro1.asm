
_vdelay_init:

;pro1.c,4 :: 		void vdelay_init()
;pro1.c,6 :: 		OPTION_REG = 0b00000000; //page 105  timer 0 count every 1 u sec
	CLRF       OPTION_REG+0
;pro1.c,7 :: 		}
	RETURN
; end of _vdelay_init

_vdelay_us:

;pro1.c,8 :: 		void vdelay_us(int x)
;pro1.c,10 :: 		x=x/2;
	RRF        FARG_vdelay_us_x+1, 1
	RRF        FARG_vdelay_us_x+0, 1
	BCF        FARG_vdelay_us_x+1, 7
	BTFSC      FARG_vdelay_us_x+1, 6
	BSF        FARG_vdelay_us_x+1, 7
;pro1.c,11 :: 		TMR0=0;
	CLRF       TMR0+0
;pro1.c,12 :: 		while(x>255)
L_vdelay_us0:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_vdelay_us_x+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__vdelay_us10
	MOVF       FARG_vdelay_us_x+0, 0
	SUBLW      255
L__vdelay_us10:
	BTFSC      STATUS+0, 0
	GOTO       L_vdelay_us1
;pro1.c,14 :: 		while(TMR0<250);
L_vdelay_us2:
	MOVLW      250
	SUBWF      TMR0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_vdelay_us3
	GOTO       L_vdelay_us2
L_vdelay_us3:
;pro1.c,15 :: 		x=x-250;
	MOVLW      250
	SUBWF      FARG_vdelay_us_x+0, 1
	BTFSS      STATUS+0, 0
	DECF       FARG_vdelay_us_x+1, 1
;pro1.c,16 :: 		TMR0=0;
	CLRF       TMR0+0
;pro1.c,17 :: 		}
	GOTO       L_vdelay_us0
L_vdelay_us1:
;pro1.c,18 :: 		while(x>TMR0);
L_vdelay_us4:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_vdelay_us_x+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__vdelay_us11
	MOVF       FARG_vdelay_us_x+0, 0
	SUBWF      TMR0+0, 0
L__vdelay_us11:
	BTFSC      STATUS+0, 0
	GOTO       L_vdelay_us5
	GOTO       L_vdelay_us4
L_vdelay_us5:
;pro1.c,19 :: 		}
	RETURN
; end of _vdelay_us

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;pro1.c,20 :: 		void interrupt()
;pro1.c,22 :: 		tmr1l=0xDF;
	MOVLW      223
	MOVWF      TMR1L+0
;pro1.c,23 :: 		tmr1h=0xB1;
	MOVLW      177
	MOVWF      TMR1H+0
;pro1.c,24 :: 		if(pir1.tmr1if==1){
	BTFSS      PIR1+0, 0
	GOTO       L_interrupt6
;pro1.c,25 :: 		rd3_bit=1;
	BSF        RD3_bit+0, 3
;pro1.c,26 :: 		vdelay_us(1000+time);
	MOVF       _time+0, 0
	ADDLW      232
	MOVWF      FARG_vdelay_us_x+0
	MOVLW      3
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _time+1, 0
	MOVWF      FARG_vdelay_us_x+1
	CALL       _vdelay_us+0
;pro1.c,27 :: 		rd3_bit=0;
	BCF        RD3_bit+0, 3
;pro1.c,28 :: 		}
L_interrupt6:
;pro1.c,29 :: 		pir1.tmr1if=0;
	BCF        PIR1+0, 0
;pro1.c,30 :: 		}
L__interrupt12:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;pro1.c,31 :: 		void main() {
;pro1.c,32 :: 		trisd=0;
	CLRF       TRISD+0
;pro1.c,33 :: 		pie1=0b00000001;
	MOVLW      1
	MOVWF      PIE1+0
;pro1.c,34 :: 		intcon=0b11000000;
	MOVLW      192
	MOVWF      INTCON+0
;pro1.c,35 :: 		t1con=0b00000101;
	MOVLW      5
	MOVWF      T1CON+0
;pro1.c,36 :: 		vdelay_init();
	CALL       _vdelay_init+0
;pro1.c,37 :: 		tmr1l=0xDF;
	MOVLW      223
	MOVWF      TMR1L+0
;pro1.c,38 :: 		tmr1h=0xB1;
	MOVLW      177
	MOVWF      TMR1H+0
;pro1.c,39 :: 		time=0;
	CLRF       _time+0
	CLRF       _time+1
;pro1.c,40 :: 		delay_ms(5000);
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_main7:
	DECFSZ     R13+0, 1
	GOTO       L_main7
	DECFSZ     R12+0, 1
	GOTO       L_main7
	DECFSZ     R11+0, 1
	GOTO       L_main7
	NOP
;pro1.c,41 :: 		while(1)
L_main8:
;pro1.c,43 :: 		time=138;
	MOVLW      138
	MOVWF      _time+0
	CLRF       _time+1
;pro1.c,44 :: 		}
	GOTO       L_main8
;pro1.c,45 :: 		}
	GOTO       $+0
; end of _main
