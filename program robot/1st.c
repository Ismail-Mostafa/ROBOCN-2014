int time;
int time1;

void vdelay_init()
{
OPTION_REG = 0b00000000; //page 105  timer 0 count every 1 u sec
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
rb7_bit=1;
vdelay_us(1000+time);
rb7_bit=0;
rb6_bit=1;
vdelay_us(1000+time1);
rb6_bit=0;}
pir1.tmr1if=0;
}
void main() {
int x,y;
trisb=0;
trisd=0;
portd=0;
pie1=0b00000001;
intcon=0b11000000;
t1con=0b00000101;
vdelay_init();
tmr1l=0xDF;
tmr1h=0xB1;
while(1)
{
x=adc_read(0);
y=adc_read(1);
if(x<100)
portd=0b00001001;
else if(x>800)
portd=0b00000110;
if(y<100)
portd=0b00000101;
else if(y>800)
portd=0b00001010;
else 
portd=0;
time=adc_read(2);
time1=adc_read(3);
}
}