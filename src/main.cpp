#include <Arduino.h>
#include "config.h"

enum FunctionTypes
{
    powerOn = PIN_PC3,
    powerOff = PIN_PC4,
    source = PIN_PC2,
    source2 = PIN_PC5
};

int functionPins[] = {PIN_PC3, PIN_PC4, PIN_PC2, PIN_PC5}; // gombok
int ledPins[] = {PIN_PB1, PIN_PD6, PIN_PB2, PIN_PD5};      // ledek

FunctionTypes readInput(bool& lastStatus)
{
    for (int i = 0; i < 4; i++)
    {
        if (!digitalRead(functionPins[i])) // 0-ban aktívak a bemenetek!
        {
            delay(50); //Pergésmentesítés
            if(!digitalRead(functionPins[i])) {
                if (!lastStatus)
                {
                    lastStatus = true;
                    return FunctionTypes(functionPins[i]); // Első gomnyomás
                }
                else
                    return FunctionTypes(0); // Ha volt gombnyomás de már a sokadik
            }
        }
    }
    lastStatus = false;
    return FunctionTypes(0); // Nincs gombnyomás
}

void setupFunctionPins()
{
    for (int i = 0; i < 4; i++)
    {
        pinMode(functionPins[i], INPUT);
    }
}

void setupLedPins()
{
    for (int i = 0; i < 4; i++)
    {
        pinMode(ledPins[i], OUTPUT);
        digitalWrite(ledPins[i], LOW); // Minden led lekapcsolása
    }
}

void setup()
{
    Serial.begin(BAUDRATE);
    delay(50);
    setupFunctionPins();
    setupLedPins();
}

Projector p1(acer);

bool lastStatus = false;
void loop()
{
    switch (readInput(lastStatus))
    {
    case powerOn:
        //digitalWrite(PIN_PD5, HIGH); ide lehet írni led vezérléseket, ki kell találni, hogy mi legyen
        p1.printHexToSerial(p1.turnOnCodes);
        break;

    case powerOff:
        p1.printHexToSerial(p1.turnOffCodes);
        //digitalWrite(PIN_PD5, LOW);
        break;

    case source:
        p1.printHexToSerial(p1.sourceCodes);
        break;

    case source2:
        p1.printHexToSerial(p1.source2Codes);
        break;

    default:
        break;
    }
}
