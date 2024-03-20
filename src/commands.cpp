#include <Arduino.h>
#include "config.h"

Projector::Projector(ProjectorType projectoryType)
{
    switch (projectoryType)
    {
    case nec:
        turnOnCommand = turnOnNec;
        turnOffCommand = turnOffNec;
        sourceCommand = sourceNec;
        break;

    case acer:
        turnOnCommand = turnOnAcer;
        turnOffCommand = turnOffAcer;
        sourceCommand = sourceAcer;
        break;

    case benq:
        turnOnCommand = turnOnBenq;
        turnOffCommand = turnOffBenq;
        sourceCommand = hdmiBenQ;
        someFunction = hdmi2BenQ;
        break;
    }
}

void Projector::printHexToSerial(int data[], int dataLength)
{
    for (int i = 0; i < dataLength; i++)
    {
        Serial.write(data[i]);
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
void Projector::turnOnNec()
{
    int turnOnCodes[] = {0x02, 0x0, 0x0, 0x0, 0x0, 0x02};
    printHexToSerial(turnOnCodes, 6);
}

void Projector::turnOffNec()
{
    int turnOffCodes[] = {2, 1, 0, 0, 0, 3};
    printHexToSerial(turnOffCodes, 6);
}

void Projector::sourceNec() {
    int sourceCode[] = {0x02, 0x03, 0x00, 0x00, 0x02, 0x01, 0x1, 0x9}; //Az utolsó hex szám a checksum. Az előtte lévő az hogy melyik bemenetet válassza elvileg (ami 0 vagy 1 lehet?)
    printHexToSerial(sourceCode, 8);
}

// ACER

void Projector::turnOnAcer()
{
    int turnOnCodes[] = {0x2A, 0x20, 0x30, 0x20, 0x49, 0x52, 0x20, 0x30, 0x30, 0x31, 0x0D};
    // 0x4F, 0x4B, 0x4F, 0x4B, 0x4F, 0x4B, 0x4F, 0x4B, 0x4F, 0x4B, 0x0D
    printHexToSerial(turnOnCodes, 11);
}

void Projector::turnOffAcer()
{
    int turnOffCodes[] = {0x2A, 0x20, 0x30, 0x20, 0x49, 0x52, 0x20, 0x30, 0x30, 0x32, 0x0D};
    printHexToSerial(turnOffCodes, 11);
}

void Projector::sourceAcer()
{
    int sourceCommand[] = {0x2A, 0x20, 0x30, 0x20, 0x49, 0x52, 0x20, 0x30, 0x33, 0x31, 0x0D};
    printHexToSerial(sourceCommand, 11);
}

// BENQ

void Projector::turnOnBenq() {
    int turnOnCodes[] = {0x0D, 0x2A, 0x70, 0x6F, 0x77, 0x3D, 0x6F, 0x6E, 0x23, 0x0D};
    printHexToSerial(turnOnCodes, 10);
}

void Projector::turnOffBenq() {
    int turnOnCodes[] = {0x0D, 0x2A, 0x70, 0x6F, 0x77, 0x3D, 0x6F, 0x66, 0x66, 0x23, 0x0D};
    printHexToSerial(turnOnCodes, 11);
}

void Projector::hdmiBenQ() {
    int sourceCodes[] = {0x0D, 0x2A, 0x73, 0x6F, 0x75, 0x72, 0x3D, 0x68, 0x64, 0x6D, 0x69, 0x23, 0x0D};
    printHexToSerial(sourceCodes, 13);
}

void Projector::hdmi2BenQ() {
    int hdmi2Codes[] = {0x0D, 0x2A, 0x73, 0x6F, 0x75, 0x72, 0x3D, 0x68, 0x64, 0x6D, 0x69, 0x32, 0x23, 0x0D};
    printHexToSerial(hdmi2Codes,14);
}