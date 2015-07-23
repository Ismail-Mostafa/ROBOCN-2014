#line 1 "F:/ROBOCN 2014/servo1/servo1.c"
void vdelay_init()
{
OPTION_REG = 0b00010000;
}
void vdelay_us(int x)
{
x=x/2;
TMR0=0;
while(x>255)
{
while(TMR0<250);
x=x-250;
TMR0=0;
}
while(x>TMR0);
}
void main()
{
int time;
trisb=0;
vdelay_init();
while(1)
{
time=adc_read(0);
rb7_bit=1;
rb6_bit=1;
vdelay_us(1000+time);
rb7_bit=0;
rb6_bit=0;
vdelay_us(20000-(1000+time));


}

}
