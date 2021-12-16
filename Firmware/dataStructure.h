#define _MAX_DATA_SIZE 16

struct _SerialSettings
{
    int baudRate; // bit per second
    int parity; // on or off
    double stopBit; // 1, 1.5 or 2 bit
    int flowControl; // on or off
} SerialSettings ;

struct _ProjectorData{ // TO-DO: Lehet a tömb méreteket okosabban kezelni?
    uint8_t TurnOn[_MAX_DATA_SIZE] = {};
    uint8_t TurnOff[_MAX_DATA_SIZE] = {};
    uint8_t InputSelectVGA[_MAX_DATA_SIZE] = {};
    uint8_t InputSelectHDMI[_MAX_DATA_SIZE] = {};
} ProjectorData;