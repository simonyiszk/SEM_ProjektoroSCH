#include <Arduino.h>
#include "config.h"

//#define DEBUG

enum FunctionTypes
{
    powerOn = PC3,
    powerOff = PC4,
    source = PC2,
    some = PC5
};

// Ide kell írni a bemeneti pineket, ahova a gombok vannak bekötve
int functionPins[] = {PIN_PC3, PIN_PC4, PIN_PC2}; //+ a 4. gomb

FunctionTypes readInput()
{
    for (int i = 0; i < 4; i++)
    {
        if (!digitalRead(functionPins[i])) //0-ban aktívak a bemenetek!
            return FunctionTypes(functionPins[i]);
    }
    return FunctionTypes(0);
}

void setupFunctionPins()
{
    for (int i = 0; i < 3; i++)//Ezt majd 4-re kell állítani ha megvan a 4. gomb
    {
        pinMode(functionPins[i], INPUT);
    }
}

void setup()
{

    Serial.begin(baudrate);
    delay(50);

    #ifdef DEBUG
    pinMode(PIN_PD5, OUTPUT);
    digitalWrite(PIN_PD5, HIGH);
    #endif

   setupFunctionPins();
}

Projector p1(benq);

void loop()
{

    #ifdef DEBUG

    if (!digitalRead(PIN_PC3))
    {
        p1.turnOnCommand();
        delay(2000);
    }

    if (!digitalRead(PIN_PC3))
    {
        digitalWrite(PIN_PD5, LOW);
    }

    return;

    #endif

    switch (readInput())
    {
    case powerOn:
        p1.turnOnCommand();
        break;

    case powerOff:
        p1.turnOffCommand();
        break;

    case source:
        p1.sourceCommand();
        break;
        /* EZT CSAK A BENQ-nál!
    case some:
        p1.someFunction();
        break;
        */
    default:
        break;
    }
}
