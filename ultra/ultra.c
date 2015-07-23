sbit trigger at rb0_bit;
sbit echo at rb1_bit;
void main() {
int t=0;
char m[7];
trisb=0b00000010;
uart1_init(9600);
while(1)
{
trigger=0;
trigger=1;
delay_us(5);
trigger=0;
while(echo==1)
{
t++;
delay_us(23);
}
if(t>0)
{
t=t/2;
inttostr(t,m);
uart1_write_text("distance=");
uart1_write_text(m);
if(t<20)
{
rb3_bit=1;
rb4_bit=0;
}
else if(t>20&&t<40)
{
rb3_bit=0;
rb4_bit=1;
}
else
{
rb3_bit=0;
rb4_bit=0;
}
delay_ms(1000);
t=0;
}
}
}