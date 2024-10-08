/*
 * Unit_ThreadComPort.c
 *
 *  Created on: Dec 5, 2023
 *      Author: martin
 */
#include "Unit_ThreadComPort.h"

#include "xuartps_hw.h"

//My Libraries
#include "Unit_GPIO.h"

// C library headers
#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>


/************************** Constant Definitions *****************************/


enum {PARSER_PRINC, PARSER_LENGTH, PARSER_DATA, PARSER_EOF};
/**************************** Type Definitions *******************************/


/************************** Variable Definitions *****************************/

/*
 * The following are declared globally so they are zeroed and so they are
 * easily accessible from a debugger
 */

//UART_HandleTypeDef huart2;

static uint8_t rxBuffer[DIM_ADQ];
static uint8_t rxbfrcant=0;
static uint8_t rxStt =PARSER_PRINC;
static uint8_t NxtRxCant = 1;


static uint8_t txBuf[DIM_ADQ];
static volatile uint8_t txBufIdx;
static uint8_t txCantBytes; //Cantidad de datos a transmitir en buffer

static void MX_USART2_UART_Init(void);
static int32_t WriteBytes(void *Buffer, int32_t n);





/***************** Macros (Inline Functions) Definitions *********************/



/**********************************************************************
* BytesDisponibles Function:
* Return the amount of
*********************************************************************/
void ThreadComPort_Init(void)
{
	u32 UART_InterruptStt;
    UART_InterruptStt = XUartPs_ReadReg(STDIN_BASEADDRESS, XUARTPS_IER_OFFSET);
    XUartPs_WriteReg(STDIN_BASEADDRESS, XUARTPS_IER_OFFSET, 0x01 & UART_InterruptStt);
    UART_InterruptStt = XUartPs_ReadReg(STDIN_BASEADDRESS, XUARTPS_IDR_OFFSET);
    XUartPs_WriteReg(STDIN_BASEADDRESS, XUARTPS_IDR_OFFSET, 0x01 & UART_InterruptStt);
    XUartPs_WriteReg(STDIN_BASEADDRESS, XUARTPS_RXWM_OFFSET, 0x01);
;
}


/**********************************************************************
* BytesDisponibles Function:
* Return the amount of
*********************************************************************/
bool ThreadComPort_IsRxCplt(void)
{
    if(0x00000001 & XUartPs_ReadReg(STDIN_BASEADDRESS, XUARTPS_SR_OFFSET))
        return true;
    else
        return false;

}



/**********************************************************************
* BytesDisponibles Function:
* Return the amount of
*********************************************************************/

bool ThreadComPort_SendMsg(uint8_t Comand, void *Data, uint8_t DataLen)
{
/*
	if((Data == NULL) && DataLen)
      return (false);

    uint8_t *buf = ((uint8_t *)txBuf);


    buf[0] = SFD;
    buf[1] = DataLen+1;
    buf[2] = Comand;
    (void)memcpy(&buf[3], Data, DataLen);
    buf[3+DataLen] = EOFCOM;

    txCantBytes = 4 + DataLen;
    txBufIdx = 0;

    if(0 == WriteBytes(buf,txCantBytes))
//    	Error_Handler();
*/

    return (true);

}



void Unit_ThreadComPort_RxCpltCallback(void)
{


    rxBuffer[rxbfrcant]=XUartPs_ReadReg(STDIN_BASEADDRESS, XUARTPS_FIFO_OFFSET);

	switch(rxStt)
    {
    case PARSER_PRINC:						//Verifico el estado de la FSM de recepción
        if(rxBuffer[rxbfrcant] == SFD)		//Los paquetes de informacion deben tener la
        {									// ! SFD ! CANTIDAD DE DATOS ! DATOS ! EOFM !
            rxbfrcant++;					//Si el formato es correcto envio los datos al
            rxStt = PARSER_LENGTH;			//Layer superior del protocolo, si no descarto
            NxtRxCant = 1;					//e inicio nuevamente
            XUartPs_WriteReg(STDIN_BASEADDRESS, XUARTPS_RXWM_OFFSET, NxtRxCant);
            GPIO_LedsClearStt(GPIO_LEDS_MASK);
            GPIO_LedsSetStt(GPIO_LED0_MASK);
        }
    break;
    case PARSER_LENGTH:
        if(rxBuffer[rxbfrcant] < MAX_MSG_LEGTH)
        {
            NxtRxCant = rxBuffer[rxbfrcant];
            rxbfrcant++;
            rxStt = PARSER_DATA;
            XUartPs_WriteReg(STDIN_BASEADDRESS, XUARTPS_RXWM_OFFSET, NxtRxCant);
            GPIO_LedsClearStt(GPIO_LEDS_MASK);
            GPIO_LedsSetStt(GPIO_LED1_MASK);
        }
   break;
    case PARSER_DATA:
    	while(rxbfrcant < NxtRxCant +2)
            rxBuffer[++rxbfrcant]=XUartPs_ReadReg(STDIN_BASEADDRESS, XUARTPS_FIFO_OFFSET);
        //rxbfrcant+=NxtRxCant; //se actualiza solo en le loop
    	rxStt = PARSER_EOF;
    	NxtRxCant = 1;
        XUartPs_WriteReg(STDIN_BASEADDRESS, XUARTPS_RXWM_OFFSET, NxtRxCant);
        GPIO_LedsClearStt(GPIO_LEDS_MASK);
        GPIO_LedsSetStt(GPIO_LED2_MASK);
    break;
    case PARSER_EOF:
        if(rxBuffer[rxbfrcant] == EOFCOM)
        {
       	    ThreadComPort_RxMsg(rxBuffer[2],rxBuffer+3,rxBuffer[1]);
        }
        rxStt = PARSER_PRINC;
	    NxtRxCant = 1;
	    rxbfrcant =0;
        XUartPs_WriteReg(STDIN_BASEADDRESS, XUARTPS_RXWM_OFFSET, NxtRxCant);
    break;
    default:
        rxStt = PARSER_PRINC;
        NxtRxCant = 1;
        rxbfrcant =0;
        XUartPs_WriteReg(STDIN_BASEADDRESS, XUARTPS_RXWM_OFFSET, NxtRxCant);
    break;
    }


}

/**********************************************************************
*WriteBytes Function: send the amount of bytes especified by @param n
*********************************************************************/
static int32_t WriteBytes(void *Buffer, int32_t n) //Escritura de n en el buffer de entrada
{
//	if(HAL_OK == HAL_UART_Transmit_IT(&huart2, (const uint8_t *)Buffer,n))
//			return (1);
	return (0);
}

