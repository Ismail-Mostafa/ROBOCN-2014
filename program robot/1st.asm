
_vdelay_init:

;1st.c,4 :: 		void vdelay_init()
;1st.c,6 :: 		OPTION_REG = 0b00000000; //page 105  timer 0 count every 1 u sec
	CLRF       OPTION_REG+0
;1st.c,7 :: 		}
L_end_vdelay_init:
	RETURN
; end of _vdelay_init

_vdelay_us:

;1st.c,8 :: 		void vdelay_us(int x)
;1st.c,10 :: 		x=x/2;
	RRF        FARG_vdelay_us_x+1, 1
	RRF        FARG_vdelay_us_x+0, 1
	BCF        FARG_vdelay_us_x+1, 7
	BTFSC      FARG_vdelay_us_x+1, 6
	BSF        FARG_vdelay_us_x+1, 7
;1st.c,11 :: 		TMR0=0;
	CLRF       TMR0+0
;1st.c,12 :: 		while(x>255)
L_vdelay_us0:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_vdelay_us_x+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__vdelay_us18
	MOVF       FARG_vdelay_us_x+0, 0
	SUBLW      255
L__vdelay_us18:
	BTFSC      STATUS+0, 0
	GOTO       L_vdelay_us1
;1st.c,14 :: 		while(TMR0<250);
L_vdelay_us2:
	MOVLW      250
	SUBWF      TMR0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_vdelay_us3
	GOTO       L_vdelay_us2
L_vdelay_us3:
;1st.c,15 :: 		x=x-250;
	MOVLW      250
	SUBWF      FARG_vdelay_us_x+0, 1
	BTFSS      STATUS+0, 0
	DECF       FARG_vdelay_us_x+1, 1
;1st.c,16 :: 		TMR0=0;
	CLRF       TMR0+0
;1st.c,17 :: 		}
	GOTO       L_vdelay_us0
L_vdelay_us1:
;1st.c,18 :: 		while(x>TMR0);
L_vdelay_us4:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_vdelay_us_x+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__vdelay_us19
	MOVF       FARG_vdelay_us_x+0, 0
	SUBWF      TMR0+0, 0
L__vdelay_us19:
	BTFSC      STATUS+0, 0
	GOTO       L_vdelay_us5
	GOTO       L_vdelay_us4
L_vdelay_us5:
;1st.c,19 :: 		}
L_end_vdelay_us:
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

;1st.c,20 :: 		void interrupt()
;1st.c,22 :: 		tmr1l=0xDF;
	MOVLW      223
	MOVWF      TMR1L+0
;1st.c,23 :: 		tmr1h=0xB1;
	MOVLW      177
	MOVWF      TMR1H+0
;1st.c,24 :: 		if(pir1.tmr1if==1){
	BTFSS      PIR1+0, 0
	GOTO       L_interrupt6
;1st.c,25 :: 		rb7_bit=1;
	BSF        RB7_bit+0, 7
;1st.c,26 :: 		vdelay_us(1000+time);
	MOVF       _time+0, 0
	ADDLW      232
	MOVWF      FARG_vdelay_us_x+0
	MOVLW      3
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _time+1, 0
	MOVWF      FARG_vdelay_us_x+1
	CALL       _vdelay_us+0
;1st.c,27 :: 		rb7_bit=0;
	BCF        RB7_bit+0, 7
;1st.c,28 :: 		rb6_bit=1;
	BSF        RB6_bit+0, 6
;1st.c,29 :: 		vdelay_us(1000+time1);
	MOVF       _time1+0, 0
	ADDLW      232
	MOVWF      FARG_vdelay_us_x+0
	MOVLW      3
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _time1+1, 0
	MOVWF      FARG_vdelay_us_x+1
	CALL       _vdelay_us+0
;1st.c,30 :: 		rb6_bit=0;}
	BCF        RB6_bit+0, 6
L_interrupt6:
;1st.c,31 :: 		pir1.tmr1if=0;
	BCF        PIR1+0, 0
;1st.c,32 :: 		}
L_end_interrupt:
L__interrupt21:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;1st.c,33 :: 		void main() {
;1st.c,35 :: 		trisb=0;
	CLRF       TRISB+0
;1st.c,36 :: 		trisd=0;
	CLRF       TRISD+0
;1st.c,37 :: 		portd=0;
	CLRF       PORTD+0
;1st.c,38 :: 		pie1=0b00000001;
	MOVLW      1
	MOVWF      PIE1+0
;1st.c,39 :: 		intcon=0b11000000;
	MOVLW      192
	MOVWF      INTCON+0
;1st.c,40 :: 		t1con=0b00000101;
	MOVLW      5
	MOVWF      T1CON+0
;1st.c,41 :: 		vdelay_init();
	CALL       _vdelay_init+0
;1st.c,42 :: 		tmr1l=0xDF;
	MOVLW      223
	MOVWF      TMR1L+0
;1st.c,43 :: 		tmr1h=0xB1;
	MOVLW      177
	MOVWF      TMR1H+0
;1st.c,44 :: 		while(1)
L_main7:
;1st.c,46 :: 		x=adc_read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      main_x_L0+0
	MOVF       R0+1, 0
	MOVWF      main_x_L0+1
;1st.c,47 :: 		y=adc_read(1);
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      main_y_L0+0
	MOVF       R0+1, 0
	MOVWF      main_y_L0+1
;1st.c,48 :: 		if(x<100)
	MOVLW      128
	XORWF      main_x_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main23
	MOVLW      100
	SUBWF      main_x_L0+0, 0
L__main23:
	BTFSC      STATUS+0, 0
	GOTO       L_main9
;1st.c,49 :: 		portd=0b00001001;
	MOVLW      9
	MOVWF      PORTD+0
	GOTO       L_main10
L_main9:
;1st.c,50 :: 		else if(x>800)
	MOVLW      128
	XORLW      3
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_x_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main24
	MOVF       main_x_L0+0, 0
	SUBLW      32
L__main24:
	BTFSC      STATUS+0, 0
	GOTO       L_main11
;1st.c,51 :: 		portd=0b00000110;
	MOVLW      6
	MOVWF      PORTD+0
L_main11:
L_main10:
;1st.c,52 :: 		if(y<100)
	MOVLW      128
	XORWF      main_y_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main25
	MOVLW      100
	SUBWF      main_y_L0+0, 0
L__main25:
	BTFSC      STATUS+0, 0
	GOTO       L_main12
;1st.c,53 :: 		portd=0b00000101;
	MOVLW      5
	MOVWF      PORTD+0
	GOTO       L_main13
L_main12:
;1st.c,54 :: 		else if(y>800)
	MOVLW      128
	XORLW      3
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_y_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main26
	MOVF       main_y_L0+0, 0
	SUBLW      32
L__main26:
	BTFSC      STATUS+0, 0
	GOTO       L_main14
;1st.c,55 :: 		portd=0b00001010;
	MOVLW      10
	MOVWF      PORTD+0
	GOTO       L_main15
L_main14:
;1st.c,57 :: 		portd=0;
	CLRF       PORTD+0
L_main15:
L_main13:
;1st.c,58 :: 		time=adc_read(2);
	MOVLW      2
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _time+0
	MOVF       R0+1, 0
	MOVWF      _time+1
;1st.c,59 :: 		time1=adc_read(3);
	MOVLW      3
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _time1+0
	MOVF       R0+1, 0
	MOVWF      _time1+1
;1st.c,60 :: 		}
	GOTO       L_main7
;1st.c,61 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
