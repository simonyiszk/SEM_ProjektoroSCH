#pragma once

const int baudrate = 9600;

enum ProjectorType {
    nec, acer, benq
};

class Projector {
private:
    static void printHexToSerial(int*, int);

    static void turnOnNec();
    static void turnOffNec();
    static void sourceNec();

    static void turnOnAcer();
    static void turnOffAcer();
    static void sourceAcer();

    static void turnOnBenq();
    static void turnOffBenq();
    static void hdmiBenQ();
    static void hdmi2BenQ();
    

public:

    void (*turnOnCommand)();
    void (*turnOffCommand)();
    void (*sourceCommand)();
    void (*someFunction)();

    Projector(ProjectorType projectoryType);
};



