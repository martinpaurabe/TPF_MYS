/******************************************************************************
* Copyright (C) 2023 Advanced Micro Devices, Inc. All Rights Reserved.
* SPDX-License-Identifier: MIT
******************************************************************************/
/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include <stdbool.h>

#include "Unit_SARImgGen.h"



/************************** Constant Definitions *****************************/

/**************************** Type Definitions *******************************/


/************************** Variable Definitions *****************************/

/*
 * The following are declared globally so they are zeroed and so they are
 * easily accessible from a debugger
 */






/***************** Macros (Inline Functions) Definitions *********************/




/************************** Function Prototypes ******************************/

int main()
{
    init_platform();

    print("Hello World\n\r");
    print("Successfully ran Hello World application");
    cleanup_platform();

	int Status;


	xil_printf("\r\n\r\n");

	Status = SARImgGen_Init();


    xil_printf("Starting Loop...\r\n");    
    

	while (1) {

        SARImgGen_Update();

	}

	/* never reached */
	cleanup_platform();

	return 0;
}




