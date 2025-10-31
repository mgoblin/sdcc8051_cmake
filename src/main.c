#include <STC15Fxx.h>

#define LED_PIN P10

extern void delay(void);

void main(void)
{
    while (1)
    {
        LED_PIN = !LED_PIN;
        delay();
    }
    
}
