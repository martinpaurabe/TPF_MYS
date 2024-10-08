/*
 * Unit_LTC2145.h
 *
 *  Created on: Dec 3, 2023
 *      Author: martin
 */
#ifndef Unit_LTC2145H
#define Unit_LTC2145H
//---------------------------------------------------------------------------
#include "Def_TipoDatos.h"
#include <xil_types.h>

//My Libraries


// C library headers



/************************** Constant Definitions *****************************/

/**************************** Type Definitions *******************************/


/************************** Variable Definitions *****************************/



/***************** Macros (Inline Functions) Definitions *********************/


/************************** Function Prototypes ******************************/

int LTC2145_Init(void);
u32 LTC2145_ReadAD1(void);
u32 LTC2145_ReadAD2(void);

#endif /*Unit_LTC2145H*/
