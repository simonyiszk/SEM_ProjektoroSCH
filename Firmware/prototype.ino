// Sample code for Spakfun Pro Micro
#include "config.h"

#define DEBUG 
#define _MAX_DATA_SIZE 16

struct _SerialSettings // TODO: serial.begin(speed, config) hogy lehet a configot külső headerből kiválasztani (függvény és globál változó vagy más)
{
  int baudRate = BAUDRATE;       // bit per second
  int parity = PARITY;           // on or off
  double stopBit = STOPBIT;      // 1, 1.5 or 2 bit
  int flowControl = FLOWCONTROL; // on or off //TODO: implementálni
} SerialSettings;

struct _ProjectorData
{ // TODO: Lehet a tömb méreteket okosabban kezelni?
  uint8_t TurnOn[_MAX_DATA_SIZE] = TURNON;
  uint8_t TurnOff[_MAX_DATA_SIZE] = TURNOFF;
  uint8_t InputSelectVGA[_MAX_DATA_SIZE] = INPUTSELECTVGA;
  uint8_t InputSelectHDMI[_MAX_DATA_SIZE] = INPUTSELECTHDMI;
} ProjectorData;

void printSettings()
{
  char buffer[255];
  sprintf(buffer,
  "--- SERIAL SETTINGS: ---\nBaud rate: %d\nParity: %d\nStop bit: %f\nFlow control: %s\n",SerialSettings.baudRate, SerialSettings.parity, SerialSettings.stopBit, (SerialSettings.flowControl) ? "On" : "Off");
  Serial.println(buffer);
}

void printHex(uint8_t data[]){
  for (int i = 0; i < _MAX_DATA_SIZE; i++) {
        Serial.write(data[i]);
      }
}

void printData(){
  Serial.println(F("--- PROJECTOR COMMANDS ---"));
  Serial.print(F("Turn On: "));
  printHex(ProjectorData.TurnOn);
  Serial.print(F("Turn Off: "));
  printHex(ProjectorData.TurnOff);
  Serial.print(F("Input select - HDMI: "));
  printHex(ProjectorData.InputSelectHDMI);
  Serial.print(F("Input select - VGA: "));
  printHex(ProjectorData.InputSelectVGA);
}

void setup()
{
  Serial.begin(9600); // USB Debug interface
  //Serial1.begin(SerialSettings.baudRate, SERIAL_8N2);
  #ifdef DEBUG
  pinMode(LED_BUILTIN, OUTPUT); // TODO: 2x villoghat majd bekapcsolva maradhatna debugkor
  printSettings();
  printData();
  #endif
  Serial.println(".");
}

void loop()
{
  Serial.println(".");
  if (Serial.available() > 0) {
  int cmd = Serial.parseInt();
  

  switch (cmd) {
    case 1:
      Serial.println(F("1."));
      printHex(ProjectorData.TurnOn);
      break;
    case 2:
     Serial.println("2.");
     printHex(ProjectorData.TurnOff);
      break;
    case 3:
     Serial.println("3.");
     printHex(ProjectorData.InputSelectHDMI);
      break;
    case 4:
     Serial.println("4.");
     printHex(ProjectorData.InputSelectVGA);
      break;
    default:
      break;
   }
  }
  delay(100);
}
