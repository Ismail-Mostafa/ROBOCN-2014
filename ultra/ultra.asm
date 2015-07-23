
_main:

;ultra.c,3 :: 		void main() {
;ultra.c,4 :: 		int t=0;
	CLRF       main_t_L0+0
	CLRF       main_t_L0+1
;ultra.c,6 :: 		trisb=0b00000010;
	MOVLW      2
	MOVWF      TRISB+0
;ultra.c,7 :: 		uart1_init(9600);
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;ultra.c,8 :: 		while(1)
L_main0:
;ultra.c,11 :: 		trigger=0;
	BCF        RB0_bit+0, 0
;ultra.c,12 :: 		delay_us(2);
	NOP
	NOP
	NOP
	NOP
;ultra.c,13 :: 		trigger=1;
	BSF        RB0_bit+0, 0
;ultra.c,14 :: 		delay_us(5);
	MOVLW      3
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
;ultra.c,15 :: 		trigger=0;
	BCF        RB0_bit+0, 0
;ultra.c,16 :: 		while(echo==1)
L_main3:
	BTFSS      RB1_bit+0, 1
	GOTO       L_main4
;ultra.c,18 :: 		t++;
	INCF       main_t_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_t_L0+1, 1
;ultra.c,19 :: 		delay_us(23);
	MOVLW      15
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
;ultra.c,20 :: 		}
	GOTO       L_main3
L_main4:
;ultra.c,21 :: 		if(t>0)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_t_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main16
	MOVF       main_t_L0+0, 0
	SUBLW      0
L__main16:
	BTFSC      STATUS+0, 0
	GOTO       L_main6
;ultra.c,23 :: 		t=t/2;
	MOVF       main_t_L0+0, 0
	MOVWF      R0+0
	MOVF       main_t_L0+1, 0
	MOVWF      R0+1
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	BTFSC      R0+1, 6
	BSF        R0+1, 7
	MOVF       R0+0, 0
	MOVWF      main_t_L0+0
	MOVF       R0+1, 0
	MOVWF      main_t_L0+1
;ultra.c,24 :: 		inttostr(t,m);
	MOVF       R0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      main_m_L0+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;ultra.c,25 :: 		uart1_write_text("distance=");
	MOVLW      ?lstr1_ultra+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;ultra.c,26 :: 		uart1_write_text(m);
	MOVLW      main_m_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;ultra.c,27 :: 		if(t<20)
	MOVLW      128
	XORWF      main_t_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main17
	MOVLW      20
	SUBWF      main_t_L0+0, 0
L__main17:
	BTFSC      STATUS+0, 0
	GOTO       L_main7
;ultra.c,29 :: 		rb3_bit=1;
	BSF        RB3_bit+0, 3
;ultra.c,30 :: 		rb4_bit=0;
	BCF        RB4_bit+0, 4
;ultra.c,31 :: 		}
	GOTO       L_main8
L_main7:
;ultra.c,32 :: 		else if(t>20&&t<40)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_t_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main18
	MOVF       main_t_L0+0, 0
	SUBLW      20
L__main18:
	BTFSC      STATUS+0, 0
	GOTO       L_main11
	MOVLW      128
	XORWF      main_t_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main19
	MOVLW      40
	SUBWF      main_t_L0+0, 0
L__main19:
	BTFSC      STATUS+0, 0
	GOTO       L_main11
L__main14:
;ultra.c,34 :: 		rb3_bit=0;
	BCF        RB3_bit+0, 3
;ultra.c,35 :: 		rb4_bit=1;
	BSF        RB4_bit+0, 4
;ultra.c,36 :: 		}
	GOTO       L_main12
L_main11:
;ultra.c,39 :: 		rb3_bit=0;
	BCF        RB3_bit+0, 3
;ultra.c,40 :: 		rb4_bit=0;
	BCF        RB4_bit+0, 4
;ultra.c,41 :: 		}
L_main12:
L_main8:
;ultra.c,42 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main13:
	DECFSZ     R13+0, 1
	GOTO       L_main13
	DECFSZ     R12+0, 1
	GOTO       L_main13
	DECFSZ     R11+0, 1
	GOTO       L_main13
	NOP
	NOP
;ultra.c,43 :: 		t=0;
	CLRF       main_t_L0+0
	CLRF       main_t_L0+1
;ultra.c,44 :: 		}
L_main6:
;ultra.c,45 :: 		}
	GOTO       L_main0
;ultra.c,46 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
