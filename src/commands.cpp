#include <Arduino.h>
#include "config.h"

Projector::Projector(ProjectorType projectoryType)
{
    switch (projectoryType)
    {
    case nec:
        turnOnCodes = Command(turnOnNecCodes, 6);
        turnOffCodes = Command(turnOffNecCodes, 6);
        sourceCodes = Command(sourceNecCode, 8);
        break;

    case acer:
        turnOnCodes = Command(turnOnAcerCodes, 11);
        turnOffCodes = Command(turnOffAcerCodes, 11);
        sourceCodes = Command(sourceAcerCodes, 11);
        break;
    
    case benq:
        turnOnCodes = Command(turnOnBenqCodes, 10);
        turnOffCodes = Command(turnOffBenqCodes, 11);
        sourceCodes = Command(sourceBenqCodes, 13);
        source2Codes = Command(source2BenqCodes, 14);
        break;
    
    default:
        break;
    }
}

void Projector::printHexToSerial(Command com)
{
    for (int i = 0; i < com.length; i++)
    {
        Serial.print(com.command[i]);
    }
}
// NEC
/*
The checksum is calculated as follows.
① Add all preceding bytes of data.
② Use the value of the low-order one byte (eight bits) of the addition
result obtained in ① as the checksum.
*/
// INFO: Ezeket lehet hogy 0x0D vel kell kezdeni hogy működjön, le kell tesztelni
