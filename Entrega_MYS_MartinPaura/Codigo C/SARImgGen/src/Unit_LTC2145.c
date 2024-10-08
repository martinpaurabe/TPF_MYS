/*
 * UnitLTC2145.c
 *
 *  Created on: Dec 5, 2023
 *      Author: martin
 */


//My Libraries
#include "Unit_LTC2145.h"
#include "LTC2145_IP.h"
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
* LTC2145_Init Function:
* 
*********************************************************************/
int LTC2145_Init(void)
{
    int Status = 0;    
    return  Status;
}



/**********************************************************************
* LTC2145_ReadAD1 Function:
* 
*********************************************************************/
u32 LTC2145_ReadAD1(void){

    LTC2145_IP_mWriteReg(XPAR_LTC2145_IP_0_BASEADDR, LTC2145_IP_S_AXI_SLV_REG0_OFFSET,LTC2145_IP_mReadReg(XPAR_LTC2145_IP_0_BASEADDR, LTC2145_IP_S_AXI_SLV_REG0_OFFSET) | 0x00000001);
    
    for(int i=0;i<100000;i++);
    
    LTC2145_IP_mWriteReg(XPAR_LTC2145_IP_0_BASEADDR, LTC2145_IP_S_AXI_SLV_REG0_OFFSET,LTC2145_IP_mReadReg(XPAR_LTC2145_IP_0_BASEADDR, LTC2145_IP_S_AXI_SLV_REG0_OFFSET) & ~0x00000001);

    return LTC2145_IP_mReadReg(XPAR_LTC2145_IP_0_BASEADDR, LTC2145_IP_S_AXI_SLV_REG1_OFFSET);

}

/**********************************************************************
* LTC2145_ReadAD2 Function:
* 
*********************************************************************/
u32 LTC2145_ReadAD2(void){

    LTC2145_IP_mWriteReg(XPAR_LTC2145_IP_0_BASEADDR, LTC2145_IP_S_AXI_SLV_REG0_OFFSET,LTC2145_IP_mReadReg(XPAR_LTC2145_IP_0_BASEADDR, LTC2145_IP_S_AXI_SLV_REG0_OFFSET) | 0x00000001);
    
    for(int i=0;i<100000;i++);
    
    LTC2145_IP_mWriteReg(XPAR_LTC2145_IP_0_BASEADDR, LTC2145_IP_S_AXI_SLV_REG0_OFFSET,LTC2145_IP_mReadReg(XPAR_LTC2145_IP_0_BASEADDR, LTC2145_IP_S_AXI_SLV_REG0_OFFSET) & ~0x00000001);

    return LTC2145_IP_mReadReg(XPAR_LTC2145_IP_0_BASEADDR, LTC2145_IP_S_AXI_SLV_REG2_OFFSET);
}

