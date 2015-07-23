
_main:

;MyProject.c,17 :: 		void main() {
;MyProject.c,21 :: 		lcd_init();
	CALL       _Lcd_Init+0
;MyProject.c,22 :: 		trisd=0;
	CLRF       TRISD+0
;MyProject.c,23 :: 		portd=0b11000000;
	MOVLW      192
	MOVWF      PORTD+0
;MyProject.c,24 :: 		while(1)
L_main0:
;MyProject.c,26 :: 		x=adc_read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      main_x_L0+0
	MOVF       R0+1, 0
	MOVWF      main_x_L0+1
;MyProject.c,27 :: 		y=adc_read(1);
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      main_y_L0+0
	MOVF       R0+1, 0
	MOVWF      main_y_L0+1
;MyProject.c,28 :: 		inttostr(x,txt);
	MOVF       main_x_L0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       main_x_L0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      main_txt_L0+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;MyProject.c,29 :: 		lcd_out(1,1,txt);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      main_txt_L0+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,30 :: 		inttostr(y,txt);
	MOVF       main_y_L0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       main_y_L0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      main_txt_L0+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;MyProject.c,31 :: 		lcd_out(2,1,txt);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      main_txt_L0+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,32 :: 		delay_ms(300);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	DECFSZ     R11+0, 1
	GOTO       L_main2
	NOP
	NOP
;MyProject.c,33 :: 		if(y>368&&y<378)
	MOVLW      128
	XORLW      1
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_y_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main9
	MOVF       main_y_L0+0, 0
	SUBLW      112
L__main9:
	BTFSC      STATUS+0, 0
	GOTO       L_main5
	MOVLW      128
	XORWF      main_y_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      1
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main10
	MOVLW      122
	SUBWF      main_y_L0+0, 0
L__main10:
	BTFSC      STATUS+0, 0
	GOTO       L_main5
L__main7:
;MyProject.c,35 :: 		portd=255;
	MOVLW      255
	MOVWF      PORTD+0
;MyProject.c,36 :: 		}
	GOTO       L_main6
L_main5:
;MyProject.c,39 :: 		portd=0;
	CLRF       PORTD+0
;MyProject.c,40 :: 		}
L_main6:
;MyProject.c,41 :: 		}
	GOTO       L_main0
;MyProject.c,42 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
