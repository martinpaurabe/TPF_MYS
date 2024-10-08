/*
 * UnitGPS_NMEA.c
 *
 *  Created on: Dec 5, 2023
 *      Author: martin
 */


//My Libraries
#include "Unit_GPS_NMEA.h"
#include "xuartlite_l.h"
#include "Unit_GPIO.h"
#include "xparameters.h"

// C library headers
#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <xuartps_hw.h>





/************************** Constant Definitions *****************************/
#define BUFFER_SIZE 64

/**************************** Type Definitions *******************************/


/************************** Variable Definitions *****************************/
//static XUartLite UartGPS;
//static XUartLite_Config *UartGPS_Config_ptr;

/*
 * The following buffers are used in this example to send and receive data
 * with the UartLite.
 */
static u8 SendBuffer[BUFFER_SIZE];
static u8 ReceiveBuffer[BUFFER_SIZE];


/*
 * The following counters are used to determine when the entire buffer has
 * been sent and received.
 */
static volatile int TotalReceivedCount;
static volatile int TotalSentCount;
/***************** Macros (Inline Functions) Definitions *********************/


/************************** Function Prototypes ******************************/
void SendHandler(void *CallBackRef, unsigned int EventData);

void RecvHandler(void *CallBackRef, unsigned int EventData);

/**********************************************************************
* GPIO_init Function:
* GPS module initialize
*********************************************************************/
int GPS_NMEA_Init(void)
{
    int Status = 1;

    return Status;

}

/**********************************************************************
* GPS_NMEA_PosRQS Function:
* Position request order
*********************************************************************/
void GPS_NMEA_PosRQS(u8 data){

    //u8 DataRqsGPS = DRQ_GPS_POS;
    XUartLite_SendByte(XPAR_XUARTLITE_0_BASEADDR, data);;
}

/**********************************************************************
* GPS_NMEA_RxCpltCallBack Function:
* Return the amount of
*********************************************************************/
void GPS_NMEA_RxCpltCallBack(void){

   return; //TBD
}

/*****************************************************************************/
/**
*
* This function is the handler which performs processing to send data to the
* UartLite. It is called from an interrupt context such that the amount of
* processing performed should be minimized. It is called when the transmit
* FIFO of the UartLite is empty and more data can be sent through the UartLite.
*
* This handler provides an example of how to handle data for the UartLite,
* but is application specific.
*
* @param	CallBackRef contains a callback reference from the driver.
*		In this case it is the instance pointer for the UartLite driver.
* @param	EventData contains the number of bytes sent or received for sent
*		and receive events.
*
* @return	None.
*
* @note		None.
*
****************************************************************************/
void SendHandler(void *CallBackRef, unsigned int EventData)
{
	TotalSentCount = EventData;
}

/****************************************************************************/
/**
*
* This function is the handler which performs processing to receive data from
* the UartLite. It is called from an interrupt context such that the amount of
* processing performed should be minimized.  It is called data is present in
* the receive FIFO of the UartLite such that the data can be retrieved from
* the UartLite. The size of the data present in the FIFO is not known when
* this function is called.
*
* This handler provides an example of how to handle data for the UartLite,
* but is application specific.
*
* @param	CallBackRef contains a callback reference from the driver, in
*		this case it is the instance pointer for the UartLite driver.
* @param	EventData contains the number of bytes sent or received for sent
*		and receive events.
*
* @return	None.
*
* @note		None.
*
****************************************************************************/
void RecvHandler(void *CallBackRef, unsigned int EventData)
{
	TotalReceivedCount = EventData;
}
