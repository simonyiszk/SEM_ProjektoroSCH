#!/usr/bin/python3

import time
import serial
import serial.tools.list_ports
import readline     # ez a felfele nyíllal felajánlja az input()-ban a korábban megadott értékeket. jó cucc.

print(" == Projektorokat soros porton piszkáló tesztprogram == ")

commandlist = {
  "turnOnNec": bytearray([0x02, 0x0, 0x0, 0x0, 0x0, 0x02]),
  "turnOffNec": bytearray([2, 1, 0, 0, 0, 3]),
  "sourceNec": bytearray([0x02, 0x03, 0x00, 0x00, 0x02, 0x01, 0x1, 0x9]),
  "turnOnAcer": bytearray([0x2A, 0x20, 0x30, 0x20, 0x49, 0x52, 0x20, 0x30, 0x30, 0x31, 0x0D]),
  "turnOffAcer": bytearray([0x2A, 0x20, 0x30, 0x20, 0x49, 0x52, 0x20, 0x30, 0x30, 0x32, 0x0D]),
  "sourceAcer": bytearray([0x2A, 0x20, 0x30, 0x20, 0x49, 0x52, 0x20, 0x30, 0x33, 0x31, 0x0D]),
  "turnOnBenq": bytearray([0x0D, 0x2A, 0x70, 0x6F, 0x77, 0x3D, 0x6F, 0x6E, 0x23, 0x0D]),
  "turnOffBenq": bytearray([0x0D, 0x2A, 0x70, 0x6F, 0x77, 0x3D, 0x6F, 0x66, 0x66, 0x23, 0x0D]),
  "hdmiBenQ": bytearray([0x0D, 0x2A, 0x73, 0x6F, 0x75, 0x72, 0x3D, 0x68, 0x64, 0x6D, 0x69, 0x23, 0x0D]),
  "hdmi2BenQ": bytearray([0x0D, 0x2A, 0x73, 0x6F, 0x75, 0x72, 0x3D, 0x68, 0x64, 0x6D, 0x69, 0x32, 0x23, 0x0D]),
    # ér bővíteni a parancsok listáját
}

# Fancy, soros port detektáló / kiválasztó kódrészlet:

ports = serial.tools.list_ports.comports()      # soros portok listája
device = ""

if len(ports)==0:
    print("Nem található soros port!")
    exit()
elif len(ports)==1:         # automatikusan válassza ki, ha csak az az egy van
    device = ports[0].device
else:
    p = 0
    sel = ''
    while(sel=='' or int(sel)<0 or int(sel)>=p):    # érvényességvizsgálat
        p = 0
        for info in ports:
            print('[', p, ']', info)
            p += 1
        sel = input("Válassz portot: ")     # sorszámot kell megadni
        if(not sel.isnumeric()):
            sel = ''
    device = ports[int(sel)].device

# A lényeg:

try:
    Projector = serial.Serial(device)
    Projector.baudrate = 9600
except serial.SerialException:
    print("Nem lehetett megnyitni a portot:", device)
    raise SystemExit

command = ''
response = '-'      # alapértelmezetten: nincs válasz

begin_bold_font = "\033[1m"     # varázslatos vezérlő karakterek
end_bold_font = "\033[0m"
up_1_line = "\033[A"
clear_line = "\033[K"

print("Parancsok:")
for c in commandlist:
    print(begin_bold_font, c, end_bold_font, "\t", commandlist.get(c))
print(" q = Kilépés")

while(command!='q'):

    print(clear_line, up_1_line)
    print("  Előző válasz:", begin_bold_font, response, end_bold_font)
    print(clear_line, up_1_line)
    command = input("Milyen parancsot küldjünk: ")

    if(command=='q'):
        Projector.close()
        print(" adiós")
    else:
        print(up_1_line, up_1_line, up_1_line)
        if(command in commandlist.keys()):
            Projector.write(commandlist.get(command))
            response = bytearray()
            time.sleep(0.1)     # hogy tutira megjöjjön a válasz
            while Projector.inWaiting() > 0:
                response.extend(Projector.read())
        else:
            response = '-'
