/*
 * Unit_SARImgGen.h
 *
 *  Created on: Oct 3, 2024
 *      Author: martin
 */

#ifndef UNIT_SARIMGGEN_H_
#define UNIT_SARIMGGEN_H_


#include <stdint.h>


/************************** Constant Definitions *****************************/


/**************************** Type Definitions *******************************/
typedef struct
{
    uint8_t addr;
    uint16_t data;

} LMX2594_msg_t;

/************************** Variable Definitions *****************************/


/***************** Macros (Inline Functions) Definitions *********************/


/************************** Function Prototypes ******************************/


//==============================================================================================================
// Update FSM Constant Definition
//==============================================================================================================
#define SIG_FSM_PERIODE 100  //Period of execution of Finit State Machine



//Protoco Commands
//*********************************
#define CMD_SIG_SAVE             0x00
#define CMD_SIG_STATUS           0x01



//LMX2594 Orders
#define CMD_SIG_CHIRP              0x20
#define CMD_SIG_MSG                0x21
#define CMD_SIG_MSG_PRB            0x22




#define CMD_SIG_GRAL              0x70


//LMX2594 Data Request
#define DRQ_SIG_REG            0x80



//LMX2594 Data Send
#define DAT_SIG_REG           0xA0



//LTC2145 Orders



//LTC2145 Data Request
#define DRQ_SIG_LTC_AD1            0x81
#define DRQ_SIG_LTC_AD2            0x82


//LTC2145 Data Send


//GPS_NMEA Orders



//GPS_NMEA Data Request
#define DRQ_SIG_GPS_POS            0x83



//GPS_NMEA Data Send


//Public Functions
int SARImgGen_Init(void);
void SARImgGen_Update(void);


#endif /* UNIT_SARIMGGEN_H_ */
