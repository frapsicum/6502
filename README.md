Code for Ben Eaters breadboard based [6502 computer](https://eater.net/6502).

## Memory Map

```
0000 0000 0000 0000 0000 
0XXX 00xx xxxx xxxx xxxx   RAM  16K bytes
1XXX 00xx xxxx xxxx xxxx   RAM
2XXX 00xx xxxx xxxx xxxx   RAM
3XXX 00xx xxxx xxxx xxxx   RAM

4XXX 010x xxxx xxxx xxxx   ACIA 4 bytes (invert a13 -> CS1)
5XXX 010x xxxx xxxx xxxx   ACIA
6XXX 011x xxxx xxxx xxxx   VIA  16 bytes
7XXX 011x xxxx xxxx xxxx   VIA

8XXX 1xxx xxxx xxxx xxxx   EEPROM  32K bytes
9XXX 1xxx xxxx xxxx xxxx   EEPROM
AXXX 1xxx xxxx xxxx xxxx   EEPROM
BXXX 1xxx xxxx xxxx xxxx   EEPROM
CXXX 1xxx xxxx xxxx xxxx   EEPROM
DXXX 1xxx xxxx xxxx xxxx   EEPROM
EXXX 1xxx xxxx xxxx xxxx   EEPROM
FXXX 1xxx xxxx xxxx xxxx   EEPROM
FFFF 1111 1111 1111 1111   EEPROM
```

## Update EEPROM

Compile and verify code is as expected.
```
$ vasm6502_oldstyle -Fbin -dotdir hello_world_4bit.S && hexdump -C a.out
```

Upload to EEPROM. I used [picoprom](https://github.com/gfoot/picoprom) for this.
```
minicom -b 115200 -o -D /dev/tty.usbmodem0000000000001
sx  a.out
```