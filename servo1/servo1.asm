
_vdelay_init:

;servo1.c,1 :: 		void vdelay_init()
;servo1.c,3 :: 		OPTION_REG = 0b00010000; //page 105  timer 0 count every 1 u sec
	MOVLW      16
	MOVWF      OPTION_REG+0
;servo1.c,4 :: 		}
L_end_vdelay_init:
	RETURN
; end of _vdelay_init

_vdelay_us:

;servo1.c,5 :: 		void vdelay_us(int x)
;servo1.c,7 :: 		x=x/2;
	RRF        FARG_vdelay_us_x+1, 1
	RRF        FARG_vdelay_us_x+0, 1
	BCF        FARG_vdelay_us_x+1, 7
	BTFSC      FARG_vdelay_us_x+1, 6
	BSF        FARG_vdelay_us_x+1, 7
;servo1.c,8 :: 		TMR0=0;
	CLRF       TMR0+0
;servo1.c,9 :: 		while(x>255)
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
;servo1.c,11 :: 		while(TMR0<250);
L_vdelay_us2:
	MOVLW      250
	SUBWF      TMR0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_vdelay_us3
	GOTO       L_vdelay_us2
L_vdelay_us3:
;servo1.c,12 :: 		x=x-250;
	MOVLW      250
	SUBWF      FARG_vdelay_us_x+0, 1
	BTFSS      STATUS+0, 0
	DECF       FARG_vdelay_us_x+1, 1
;servo1.c,13 :: 		TMR0=0;
	CLRF       TMR0+0
;servo1.c,14 :: 		}
	GOTO       L_vdelay_us0
L_vdelay_us1:
;servo1.c,15 :: 		while(x>TMR0);
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
;servo1.c,16 :: 		}
L_end_vdelay_us:
	RETURN
; end of _vdelay_us

_main:

;servo1.c,17 :: 		void main()
;servo1.c,20 :: 		trisb=0;
	CLRF       TRISB+0
;servo1.c,21 :: 		vdelay_init();
	CALL       _vdelay_init+0
;servo1.c,22 :: 		while(1)
L_main6:
;servo1.c,24 :: 		time=adc_read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      main_time_L0+0
	MOVF       R0+1, 0
	MOVWF      main_time_L0+1
;servo1.c,25 :: 		rb7_bit=1;
	BSF        RB7_bit+0, 7
;servo1.c,26 :: 		rb6_bit=1;
	BSF        RB6_bit+0, 6
;servo1.c,27 :: 		vdelay_us(1000+time);
	MOVF       R0+0, 0
	ADDLW      232
	MOVWF      FARG_vdelay_us_x+0
	MOVLW      3
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      FARG_vdelay_us_x+1
	CALL       _vdelay_us+0
;servo1.c,28 :: 		rb7_bit=0;
	BCF        RB7_bit+0, 7
;servo1.c,29 :: 		rb6_bit=0;
	BCF        RB6_bit+0, 6
;servo1.c,30 :: 		vdelay_us(20000-(1000+time));
	MOVF       main_time_L0+0, 0
	ADDLW      232
	MOVWF      R0+0
	MOVLW      3
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      main_time_L0+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	SUBLW      32
	MOVWF      FARG_vdelay_us_x+0
	MOVF       R0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBLW      78
	MOVWF      FARG_vdelay_us_x+1
	CALL       _vdelay_us+0
;servo1.c,33 :: 		}
	GOTO       L_main6
;servo1.c,35 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
