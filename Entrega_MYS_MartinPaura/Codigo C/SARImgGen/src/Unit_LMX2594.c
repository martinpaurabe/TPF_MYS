/*
 * UnitLMX2594.c
 *
 *  Created on: Dec 5, 2023
 *      Author: martin
 */


//My Libraries
#include "Unit_LMX2594.h"
#include "LMX2594_CTRL_IP.h"
#include "Unit_GPIO.h"
#include "xparameters.h"

// C library headers
#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>





/************************** Constant Definitions *****************************/


/**************************** Type Definitions *******************************/


/************************** Variable Definitions *****************************/


/***************** Macros (Inline Functions) Definitions *********************/


/************************** Function Prototypes ******************************/


/**********************************************************************
* LMX2594_Init Function:
* Initialize synteticizer IP core
*********************************************************************/
int LMX2594_Init(void)
{
    int Status = 0;    
    return  Status;
}



/**********************************************************************
* LMX2594_ReadReg Function:
* Read data recived from synteticizer
*********************************************************************/
u32 LMX2594_ReadReg(void){

    return LMX2594_CTRL_IP_mReadReg(XPAR_LMX2594_CTRL_IP_0_BASEADDR, LMX2594_CTRL_IP_S_AXI_SLV_REG3_OFFSET);

}

/**********************************************************************
* LMX2594_SendReg Function:
* Send address and data to sintetisizer
*********************************************************************/
void LMX2594_SendReg(u8 addr, u16 data){

    LMX2594_CTRL_IP_mWriteReg(XPAR_LMX2594_CTRL_IP_0_BASEADDR, LMX2594_CTRL_IP_S_AXI_SLV_REG1_OFFSET, (u32)addr & 0x0000007F);
    LMX2594_CTRL_IP_mWriteReg(XPAR_LMX2594_CTRL_IP_0_BASEADDR, LMX2594_CTRL_IP_S_AXI_SLV_REG2_OFFSET, (u32)data & 0x0000FFFF);
    (*(u32 *)XPAR_LMX2594_CTRL_IP_0_BASEADDR) |= 0x00000002;


    (*(u32 *)XPAR_LMX2594_CTRL_IP_0_BASEADDR) |= 0x00000001;

    for(int i=0;i<10;i++);

    (*(u32 *)XPAR_LMX2594_CTRL_IP_0_BASEADDR) &= ~0x00000001;

}

/**********************************************************************
* LMX2594_SendChirp Function:
* Send cmd to init chirp
*********************************************************************/
void LMX2594_SendChirp(void){

    (*(u32 *)XPAR_LMX2594_CTRL_IP_0_BASEADDR) |= 0x00000004;

    for(int i=0;i<10;i++);

    (*(u32 *)XPAR_LMX2594_CTRL_IP_0_BASEADDR) &= ~0x00000004;
}

