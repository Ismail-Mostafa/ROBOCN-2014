#line 1 "F:/ROBOCN 2014/accelerometer/MyProject.c"

sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D4 at RB0_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D7 at RB3_bit;

sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;


void main() {
int x;
int y;
char txt[7];
lcd_init();
trisd=0;
portd=0b11000000;
while(1)
{
x=adc_read(0);
y=adc_read(1);
inttostr(x,txt);
lcd_out(1,1,txt);
inttostr(y,txt);
lcd_out(2,1,txt);
delay_ms(300);
if(y>368&&y<378)
{
portd=255;
}
else
{
portd=0;
}
}
}
