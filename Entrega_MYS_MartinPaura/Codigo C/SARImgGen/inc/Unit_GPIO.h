/*
 * Unit_ThredComPort.h
 *
 *  Created on: Dec 3, 2023
 *      Author: martin
 */
#ifndef Unit_GPIOH
#define Unit_GPIOH
//---------------------------------------------------------------------------


//My Libraries
#include "Def_TipoDatos.h"
#include <xil_types.h>
#include "xgpio.h"

// C library headers



/************************** Constant Definitions *****************************/
//Mask definition for LED management
#define GPIO_LED0_MASK      0x000000001<<0
#define GPIO_LED1_MASK      0x000000001<<1
#define GPIO_LED2_MASK      0x000000001<<2
#define GPIO_LED3_MASK      0x000000001<<3
#define GPIO_LEDS_MASK      GPIO_LED0_MASK | GPIO_LED1_MASK | GPIO_LED2_MASK | GPIO_LED3_MASK

//Mask definition for Button management
#define GPIO_BTN0_MASK      0x000000001<<0
#define GPIO_BTN1_MASK      0x000000001<<1
#define GPIO_BTN2_MASK      0x000000001<<2
#define GPIO_BTN3_MASK      0x000000001<<3
#define GPIO_BTNS_MASK      GPIO_BTN0_MASK | GPIO_BTN1_MASK | GPIO_BTN2_MASK | GPIO_BTN3_MASK
/**************************** Type Definitions *******************************/


/************************** Variable Definitions *****************************/



/***************** Macros (Inline Functions) Definitions *********************/


/************************** Function Prototypes ******************************/


int GPIO_Init(void);
void GPIO_LedsSetStt(u32 mask);
void GPIO_LedsClearStt(u32 mask);
bool GPIO_LedsReadStt(u32 mask);
bool GPIO_BtnsReadStt(u32 mask);

#endif /*Unit_GPIOH*/
