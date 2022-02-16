; Print hello world without any ram

  .org $8000
ORB = $6000
ORA = $6001
DDRB = $6002
DDRA = $6003

E = %10000000
W = %00000000
R = %01000000
RS0 = %00000000
RS1 = %00100000

reset:
set_output_mode:
  lda #$ff
  sta DDRB
  sta DDRA

  lda #(RS0|W)
  sta ORA
  lda #%00111000  ; 8 bits, 2 lines, 5x8 dots
  sta ORB
  lda #(RS0|W|E)
  sta ORA
  lda #(RS0|W)
  sta ORA

  lda #%00000001  ; Clear display, curson = 0
  sta ORB
  lda #(RS0|W|E)
  sta ORA
  lda #(RS0|W)
  sta ORA


  lda #%00001110  ; Display on, curson on, blink off
  sta ORB
  lda #(RS0|W|E)
  sta ORA
  lda #(RS0|W)
  sta ORA

  lda #%00000110  ; Increment curson, no display shift
  sta ORB
  lda #(RS0|W|E)
  sta ORA
  lda #(RS0|W)
  sta ORA

  lda #(RS1|W)
  sta ORA
  lda #"H"
  sta ORB
  lda #(RS1|W|E)
  sta ORA
  lda #(RS1|W)
  sta ORA

  lda #"E"
  sta ORB
  lda #(RS1|W|E)
  sta ORA
  lda #(RS1|W)
  sta ORA

  lda #"L"
  sta ORB
  lda #(RS1|W|E)
  sta ORA
  lda #(RS1|W)
  sta ORA

  lda #"L"
  sta ORB
  lda #(RS1|W|E)
  sta ORA
  lda #(RS1|W)
  sta ORA

  lda #"O"
  sta ORB
  lda #(RS1|W|E)
  sta ORA
  lda #(RS1|W)
  sta ORA

  lda #" "
  sta ORB
  lda #(RS1|W|E)
  sta ORA
  lda #(RS1|W)
  sta ORA

  lda #"A"
  sta ORB
  lda #(RS1|W|E)
  sta ORA
  lda #(RS1|W)
  sta ORA

  lda #"R"
  sta ORB
  lda #(RS1|W|E)
  sta ORA
  lda #(RS1|W)
  sta ORA

  lda #"N"
  sta ORB
  lda #(RS1|W|E)
  sta ORA
  lda #(RS1|W)
  sta ORA

  lda #"A"
  sta ORB
  lda #(RS1|W|E)
  sta ORA
  lda #(RS1|W)
  sta ORA

  lda #"!"
  sta ORB
  lda #(RS1|W|E)
  sta ORA
  lda #(RS1|W)
  sta ORA

  lda #(RS0|W)
  sta ORA
  lda #%11000000  ; Move curson to second line
  sta ORB
  lda #(RS0|W|E)
  sta ORA
  lda #(RS0|W)
  sta ORA

  lda #(RS1|W)
  sta ORA
  lda #"H"
  sta ORB
  lda #(RS1|W|E)
  sta ORA
  lda #(RS1|W)
  sta ORA

  lda #"E"
  sta ORB
  lda #(RS1|W|E)
  sta ORA
  lda #(RS1|W)
  sta ORA

  lda #"L"
  sta ORB
  lda #(RS1|W|E)
  sta ORA
  lda #(RS1|W)
  sta ORA

  lda #"L"
  sta ORB
  lda #(RS1|W|E)
  sta ORA
  lda #(RS1|W)
  sta ORA

  lda #"O"
  sta ORB
  lda #(RS1|W|E)
  sta ORA
  lda #(RS1|W)
  sta ORA

  lda #" "
  sta ORB
  lda #(RS1|W|E)
  sta ORA
  lda #(RS1|W)
  sta ORA

  lda #"N"
  sta ORB
  lda #(RS1|W|E)
  sta ORA
  lda #(RS1|W)
  sta ORA

  lda #"A"
  sta ORB
  lda #(RS1|W|E)
  sta ORA
  lda #(RS1|W)
  sta ORA

  lda #"V"
  sta ORB
  lda #(RS1|W|E)
  sta ORA
  lda #(RS1|W)
  sta ORA

  lda #"Y"
  sta ORB
  lda #(RS1|W|E)
  sta ORA
  lda #(RS1|W)
  sta ORA

  lda #"A"
  sta ORB
  lda #(RS1|W|E)
  sta ORA
  lda #(RS1|W)
  sta ORA

  lda #"!"
  sta ORB
  lda #(RS1|W|E)
  sta ORA
  lda #(RS1|W)
  sta ORA


loop:
  jmp loop

  .org $fffc
  .word reset
  .word $0000