#ifndef UNIT_TIPO_DATOS_H
#define UNIT_TIPO_DATOS_H
//==============================================================================================================
#include <stdint.h>
#include <stdbool.h>


#define ROUND(x)   ((double)((long)((x) + .5)))

#define PI 3.14159265358979323846
#define RAD_TO_DEG(x)  (((float)(x)) * (180.0/PI))
#define DEG_TO_RAD(x)  (((float)(x)) * (PI/180.0))

typedef unsigned char TByte;
typedef unsigned short TWord;
typedef unsigned long TDword;

typedef char TInt8;
typedef short TInt16;
typedef long TInt32;

typedef bool bool_t;	  // Qué biblioteca se debe incluir para que esto compile? stdbool.h


typedef union
{
  TByte byt[2];
  TWord wrd;
} TDato16;

typedef union
{
  TByte byt[4];
  TWord wrd[2];
  TDword dwrd;
} TDato32;

//==============================================================================================================
#endif
