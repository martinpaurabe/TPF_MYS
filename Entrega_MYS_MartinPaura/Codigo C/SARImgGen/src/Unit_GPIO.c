/*
 * Unit_GPIO.c
 *
 *  Created on: Dec 5, 2023
 *      Author: martin
 */


//My Libraries
#include "Unit_GPIO.h"

//#include "platform.h"
#include "xparameters.h"

// C library headers
#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>


/************************** Constant Definitions *****************************/
#define LED    0x0F   /* Assumes bit 0 of GPIO is connected to an LED  */
#define BTN_1  0x0F   /* Assumes bit 0 of GPIO is connected to an LED  */

/*
 * The following constants map to the XPAR parameters created in the
 * xparameters.h file. They are defined here such that a user can easily
 * change all the needed parameters in one place.
 */
//#ifndef SDT
//#define GPIO_EXAMPLE_DEVICE_ID  XPAR_GPIO_0_DEVICE_ID
//#else
#define	XGPIO_AXI_BASEADDRESS	XPAR_XGPIO_0_BASEADDR
//#endif
/*
 * The following constant is used to wait after an LED is turned on to make
 * sure that it is visible to the human eye.  This constant might need to be
 * tuned for faster or slower processor speeds.
 */
#define LED_DELAY     10000000

/*
 * The following constant is used to determine which channel of the GPIO is
 * used for the LED if there are 2 channels supported.
 */
#define LED_CHANNEL 1
#define BTN_CHANNEL 2

/**************************** Type Definitions *******************************/


/************************** Variable Definitions *****************************/



XGpio Gpio_0; /* The Instance of the GPIO Driver */




/***************** Macros (Inline Functions) Definitions *********************/


/************************** Function Prototypes ******************************/


/**********************************************************************
* GPIO_init Function:
* Return the amount of
*********************************************************************/
int GPIO_Init(void)
{
    int Status;
    Status = XGpio_Initialize(&Gpio_0, XGPIO_AXI_BASEADDRESS);

    xil_printf("Setting Direction\r\n");    
	/* Set the direction for all signals as inputs except the LED output */
	XGpio_SetDataDirection(&Gpio_0, LED_CHANNEL, ~LED);
	XGpio_SetDataDirection(&Gpio_0, BTN_CHANNEL, LED);
   
    
    return  Status;
}



/**********************************************************************
* GPIO_BtnsReadStt Function:
* REad Button States
*********************************************************************/
bool GPIO_BtnsReadStt(u32 mask){

    if(XGpio_DiscreteRead(&Gpio_0, BTN_CHANNEL) & mask)
        return true;
    else
        return false;

}


/**********************************************************************
* GPIO_LedsReadStt Function:
* Read LED States
*********************************************************************/
bool GPIO_LedsReadStt(u32 mask){

    if(XGpio_DiscreteRead(&Gpio_0, LED_CHANNEL) & mask)
        return true;
    else
        return false;

}


/**********************************************************************
* GPIO_LedsSetStt Function:
* Set High LED States
*********************************************************************/
void GPIO_LedsSetStt(u32 mask){

    XGpio_DiscreteSet(&Gpio_0, LED_CHANNEL, mask);

}

/**********************************************************************
* GPIO_LedsClearStt Function:
*Set Low LED States
*********************************************************************/
void GPIO_LedsClearStt(u32 mask){

    XGpio_DiscreteClear(&Gpio_0, LED_CHANNEL, mask);

}


