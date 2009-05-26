/*******************************************
 * C program to test the Network Interface
 * Francesc Vila
 *******************************************/

#include <stdio.h> 

volatile int *base = (int *)0x60000000;

main ()
{
    int data = 0xdeadbeef;
    int addr = 0;

    printf ("Sending packet:\n");
    printf ("Data: 0x%8x\n", data);
    printf ("Addr: 0x%8x\n (Resulting: 0x%8x)\n", addr, base+addr);

    base[addr] = data;

    printf ("Packet sent!\n");

    return;
}
