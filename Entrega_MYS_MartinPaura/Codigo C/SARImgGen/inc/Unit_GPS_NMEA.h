/*
 * Unit_GPS_NMEA.h
 *
 *  Created on: Dec 3, 2023
 *      Author: martin
 */
#ifndef Unit_GPS_NMEAH
#define Unit_GPS_NMEAH
//---------------------------------------------------------------------------
#include "Def_TipoDatos.h"
#include <xil_types.h>

//My Libraries


// C library headers



/************************** Constant Definitions *****************************/
#define DRQ_GPS_POS  0xAA

/**************************** Type Definitions *******************************/
typedef struct{
    u32 lon;
    u32 Lat;
} GPS_POS_t;

/************************** Variable Definitions *****************************/



/***************** Macros (Inline Functions) Definitions *********************/


/************************** Function Prototypes ******************************/
int GPS_NMEA_Init(void);
void GPS_NMEA_PosRQS(void);


#endif /*Unit_GPS_NMEAH*/
