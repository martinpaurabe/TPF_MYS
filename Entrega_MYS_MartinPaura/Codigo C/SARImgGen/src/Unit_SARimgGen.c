//#include "main.h" //Include just to toggle the LED

#include <stdio.h>
#include <string.h>

#include "xparameters.h"
#include "xil_printf.h"
#include "sleep.h"
#include <stdint.h>
#include <xgpio_l.h>
#include <xil_types.h>


#include "Unit_GPIO.h"
#include "Unit_LMX2594.h"
#include "Unit_LTC2145.h"
#include "Unit_GPS_NMEA.h"
#include "Unit_ThreadComPort.h"
#include "Unit_SARImgGen.h"

//==============================================================================================================
// Private Definitions
//==============================================================================================================




//==============================================================================================================
// Private Functions
//==============================================================================================================




//==============================================================================================================
// Private Variable Types Definitions
//==============================================================================================================

typedef struct
{
//    GPS_POS_t   GPS_POS; /* data */
//    GPIO_t      GPIO; /* data */
//    LTC2145_t   LTC2145; /* data */
//    LMX2594_t   LMX2594; /* data */
    uint32_t Stt;
}SARImgGen_t;


//==============================================================================================================
// Private Variable
//==============================================================================================================

static const SARImgGen_t SARImgGenFlash;
static SARImgGen_t SARImgGen;
//static delay_t DataUpdate;



//==============================================================================================================
// SARImgGen_Init
//==============================================================================================================

int SARImgGen_Init(void)
{
    int Status;
    
    xil_printf("\r\n\r\n");
    xil_printf("Initializing GPIO Led and Button\r\n");

    Status = GPIO_Init();


	if (Status != XST_SUCCESS) {
		xil_printf("GPIO Led and Button Initialization Failed\r\n");
		return XST_FAILURE;
	}

   
    xil_printf("Initializing Thread Communication Port\r\n");

    ThreadComPort_Init();

    xil_printf("Initializing Sintetizer Module\r\n");

    Status =  LMX2594_Init();

    xil_printf("Initializing AD converter\r\n");

    Status =  LTC2145_Init();

    xil_printf("Initializing GPS module\r\n");

    Status =  GPS_NMEA_Init();
 
	xil_printf("\r\n\r\n");


}


//==============================================================================================================
// SARImgGen_Update
//==============================================================================================================

void SARImgGen_Update(void)
{
        if(ThreadComPort_IsRxCplt()){
            Unit_ThreadComPort_RxCpltCallback();
        }

//        static int i=0;

//        if(i++>100000){
//            u32 reg =  LMX2594_ReadReg();
//            xil_printf("Buttons State: %d  %d\r\n",GPIO_BtnsReadStt(GPIO_BTNS_MASK),reg);
//            i=0;
//
//        }

}

//==============================================================================================================
// ThreadComPort_RxMsg
//==============================================================================================================

void ThreadComPort_RxMsg(uint8_t Comand, uint8_t *Data, uint8_t DataLen)
{
  TDato32 *dato;
  uint8_t dataLen32=0;
  int i;

    switch(Comand)
    {
        //Serial Command
        case CMD_SIG_SAVE:

        break;        
        case CMD_SIG_STATUS:

        break;        
        case CMD_SIG_GRAL:

        break;        
        case CMD_SIG_CHIRP:
            LMX2594_SendChirp();
        break;        
        case CMD_SIG_MSG:
            LMX2594_msg_t msg1 = *(LMX2594_msg_t *)Data;
            LMX2594_SendReg(msg1.addr, msg1.data);
        break;       
        case CMD_SIG_MSG_PRB:
            LMX2594_msg_t msg2 = *(LMX2594_msg_t *)Data;
            LMX2594_SendReg(msg2.addr, 0x0055);
        break;       

        //Serial Data Request
        case DRQ_SIG_REG:

            ThreadComPort_SendMsg(DAT_SIG_REG, &SARImgGen, sizeof(SARImgGen));
        break;
        case DRQ_SIG_LTC_AD1:
            uint32_t dataAD1 = LTC2145_ReadAD1();
            ThreadComPort_SendMsg(DAT_SIG_REG, &dataAD1, sizeof(dataAD1));
        break;
        case DRQ_SIG_LTC_AD2:
            uint32_t dataAD2 = LTC2145_ReadAD2();
            ThreadComPort_SendMsg(DAT_SIG_REG, &dataAD2, sizeof(dataAD2));
        break;
        case DRQ_SIG_GPS_POS:
            GPS_NMEA_PosRQS(Data[0]);
//            ThreadComPort_SendMsg(DAT_SIG_REG, &dataAD2, sizeof(dataAD2));
        break;

        //Serial Data Recieve
        case DAT_SIG_REG:
            dato = (TDato32 *)&SARImgGen;
            dataLen32 = sizeof(SARImgGen)/4;
        break;
        
        default:
        return;
    }

//If it have received new data, it have to reverse the bytes order
    for(i = 0; i < dataLen32; i++)
    {
        dato[i].byt[0] = Data[4*i+0];
        dato[i].byt[1] = Data[4*i+1];
        dato[i].byt[2] = Data[4*i+2];
        dato[i].byt[3] = Data[4*i+3];
    }
}


