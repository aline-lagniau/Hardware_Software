#define soc_cv_av

#define DEBUG

#include <stdio.h>
#include <unistd.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <sys/mman.h>
#include "hwlib.h"
#include "soc_cv_av/socal/socal.h"
#include "soc_cv_av/socal/hps.h"
#include "soc_cv_av/socal/alt_gpio.h"
#include "hps_0.h"


#define HW_REGS_BASE ( ALT_STM_OFST )
#define HW_REGS_SPAN ( 0x04000000 ) //64 MB with 32 bit adress space this is 256 MB
#define HW_REGS_MASK ( HW_REGS_SPAN - 1 )


//setting for the HPS2FPGA AXI Bridge
#define ALT_AXI_FPGASLVS_OFST (0xC0000000) // axi_master
#define HW_FPGA_AXI_SPAN (0x40000000) // Bridge span 1GB
#define HW_FPGA_AXI_MASK ( HW_FPGA_AXI_SPAN - 1 )



   //pointer to the different address spaces

   void *virtual_base;
   //void *axi_virtual_base;
   int fd;

 
   void *h2p_lw_reg3_addr;
   void *h2p_lw_reg4_addr; 
   
/*  
 //Génération boucle for pour faire tourner le programme un nbre x de fois
 int main (int argc, char *argv[]) {
 int i=0;
 printf("\ncmdline args count=%d", argc);

 /* First argument is executable name only
 printf("\nexe name=%s", argv[0]);

 for (i=1; i< argc; i++) {
     printf("\narg%d=%s", i, argv[i]);
 }
 int iter = atoi(argv[1]);


   //void *h2p_led_addr; //led via AXI master
   
   // map the address space for the LED registers into user space so we can interact with them.
   // we'll actually map in the entire CSR span of the HPS since we want to access various registers within that span

   if( ( fd = open( "/dev/mem", ( O_RDWR | O_SYNC ) ) ) == -1 ) {
      printf( "ERROR: could not open \"/dev/mem\"...\n" );
      return( 1 );
   }

   //lightweight HPS-to-FPGA bridge
   virtual_base = mmap( NULL, HW_REGS_SPAN, ( PROT_READ | PROT_WRITE ), MAP_SHARED, fd, HW_REGS_BASE );

   if( virtual_base == MAP_FAILED ) {
      printf( "ERROR: mmap() failed...\n" );
      close( fd );
      return( 1 );
   }
/*
   //HPS-to-FPGA bridge
   axi_virtual_base = mmap( NULL, HW_FPGA_AXI_SPAN, ( PROT_READ | PROT_WRITE ), MAP_SHARED, fd,ALT_AXI_FPGASLVS_OFST );

   if( axi_virtual_base == MAP_FAILED ) {
      printf( "ERROR: axi mmap() failed...\n" );
      close( fd );
      return( 1 );
   }
*/

   printf( "\n\n\n-----------Démarrage-------------\n\n" );
   
/*
   //LED connected to the HPS-to-FPGA bridge
   h2p_led_addr=axi_virtual_base + ( ( unsigned long  )( 0x0 + PIO_LED_BASE ) & ( unsigned long)( HW_FPGA_AXI_MASK ) );

   *(uint32_t *)h2p_led_addr = 0b10111100;

//-----------------------------------------------------------
   //Adder test: Two registers are connected to a adder and place the result in the third register
   printf( "\n\n\n-----------Add two numbers in the FPGA-------------\n\n" );

*/

   //Adresses des deux registres d'entrée (reg3 and reg4) 
   h2p_lw_reg3_addr=virtual_base + ( ( unsigned long  )( ALT_LWFPGASLVS_OFST + PIO_REG3_BASE ) & ( unsigned long)( HW_REGS_MASK ) );
   h2p_lw_reg4_addr=virtual_base + ( ( unsigned long  )( ALT_LWFPGASLVS_OFST + PIO_REG4_BASE ) & ( unsigned long)( HW_REGS_MASK ) );
 
 
	int x = 0;
	for (;x<iter;x++) {
	 
	   //Lire les résultats des deux registres
	   printf( "Valeur reçue servo   :%d\n", *((uint32_t *)h2p_lw_reg3_addr) );
	   printf( "Freq reçue (Hz) :%d\n", *((uint32_t *)h2p_lw_reg4_addr) );
	   sleep(1);
	}
	
	printf("\n\n\n-----------Fin de la lecture-------------\n\n");

   if( munmap( virtual_base, HW_REGS_SPAN ) != 0 ) {
      printf( "ERROR: munmap() failed...\n" );
      close( fd );
      return( 1 );
   }
/*
   if( munmap( axi_virtual_base, HW_FPGA_AXI_SPAN ) != 0 ) {
      printf( "ERROR: axi munmap() failed...\n" );
      close( fd );
      return( 1 );
   }
*/
   close( fd );
   return( 0 );
}
