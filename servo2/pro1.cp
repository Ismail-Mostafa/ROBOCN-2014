#line 1 "D:/ArtrOnix/ARABTECHII/ROBOCN 2014/servo2/pro1.c"
int time;
int time1;

void vdelay_init()
{
OPTION_REG = 0b00000000;
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
void interrupt()
{
tmr1l=0xDF;
tmr1h=0xB1;
if(pir1.tmr1if==1){
rd3_bit=1;
vdelay_us(1000+time);
rd3_bit=0;
}
pir1.tmr1if=0;
}
void main() {
trisd=0;
pie1=0b00000001;
intcon=0b11000000;
t1con=0b00000101;
vdelay_init();
tmr1l=0xDF;
tmr1h=0xB1;
time=0;
delay_ms(5000);
while(1)
{
time=138;
}
}
