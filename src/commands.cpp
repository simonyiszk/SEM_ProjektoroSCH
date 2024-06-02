#include <Arduino.h>
#include "config.h"

Projector::Projector(ProjectorType projectoryType)
{
    switch (projectoryType)
    {
    case nec:
        turnOnCodes = Command(turnOnNecCodes, 12);
        turnOffCodes = Command(turnOffNecCodes, 12);
        sourceCodes = Command(sourceNecCode, 12);
        //Mi legyen a 4. funkció?
        break;

    case acer:
        turnOnCodes = Command(turnOnAcerCodes, 11);
        turnOffCodes = Command(turnOffAcerCodes, 11);
        sourceCodes = Command(sourceAcerCodes, 11);
        source2Codes = Command(freezeAcerCodes, 11);
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
        Serial.write(com.command[i]);
    }
}

