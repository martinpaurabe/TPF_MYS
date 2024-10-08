/*
 * Unit_LMX2594.h
 *
 *  Created on: Dec 3, 2023
 *      Author: martin
 */
#ifndef Unit_LMX2594H
#define Unit_LMX2594H
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

int LMX2594_Init(void);
u32 LMX2594_ReadReg(void);
void LMX2594_SendReg(u8 addr, u16 data);
void LMX2594_SendChirp(void);

#endif /*Unit_LMX2594H*/
