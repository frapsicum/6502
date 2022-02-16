; Print hello world with 4 bit interface, and using strings.

  .org $8000
PORTB = $6000
DDRB = $6002
SENTINEL = $3FFF  ; last bit of RAM

LCD_E  =   %00001000
LCD_EB =   %11110111
LCD_W =    %00000000
LCD_R =    %00000100
LCD_INS =  %00000000
LCD_DATA = %00000010

reset:
; Initialization
  lda #$ff
  sta DDRB
  clc

  lda SENTINEL
  CMP #$42
  beq lcd_initialized
  lda #$42
  sta SENTINEL

  lda #(%00100000 |LCD_INS|LCD_W)  ; 4 bit mode init as one instruction
  sta PORTB
  lda #(%00100000 |LCD_INS|LCD_W|LCD_E)
  sta PORTB
  lda #(%00100000 |LCD_INS|LCD_W)
  sta PORTB

  lda #%00101000  ; 4 bits, 2 lines, 5x8 dots
  jsr lcd_send_instruction

  lda #%00000110  ; Increment cursor, no display shift
  jsr lcd_send_instruction

  lda #%00001110  ; Display on, curson on, blink off
  jsr lcd_send_instruction
; Main
lcd_initialized:
loop:
  lda #%00000001  ; Clear display, cursor = 0
  jsr lcd_send_instruction

  ldx #0
write_arna:
  lda arna,x
  beq write_arna_end
  jsr lcd_send_data
  inx
  jmp write_arna
write_arna_end:

  lda #%11000000  ; Move cursor to second line
  jsr lcd_send_instruction

  ldx #0
write_nanu:
  lda nanu,x
  beq write_nanu_end
  jsr lcd_send_data
  inx
  jmp write_nanu
write_nanu_end:
  jmp loop

; Library
; Wait for LCD to clear its busy flag.
lcd_wait:
  pha
  lda #%00001111  ; data bits input, control output
  sta DDRB
  lda #(LCD_INS|LCD_R) ;
  sta PORTB
lcd_busy:
  lda #(LCD_INS|LCD_R|LCD_E)
  sta PORTB
  lda PORTB  ; Read busy in B7
  rol  ; Busy -> Carry
  lda #(LCD_INS|LCD_R) ; ignore second 4 bits.
  sta PORTB
  lda #(LCD_INS|LCD_R|LCD_E)
  sta PORTB
  lda #(LCD_INS|LCD_R)
  sta PORTB
  bcs lcd_busy
  lda #$ff  ; data and control bits output
  sta DDRB
  pla
  rts

; Send A register contents to PORTB as 4-bit instruction
; First high order 4 bits, then sends low order 4 bits.
; A and X register are consumed
lcd_send_instruction:
    jsr lcd_wait
    tax
    and #$F0  ; high order 4 bits
    ora #(LCD_INS|LCD_W)
    sta PORTB
    ora #(LCD_E)
    sta PORTB
    and #(LCD_EB)
    sta PORTB
    txa
    rol
    rol
    rol
    rol
    and #$F0  ; low order 4 bits in position
    ora #(LCD_INS|LCD_W)
    sta PORTB
    ora #(LCD_E)
    sta PORTB
    and #(LCD_EB)
    sta PORTB
    rts

; Send A register contents to PORTB as 4-bit data
; First high order 4 bits, then sends low order 4 bits.
; A and X register are consumed
lcd_send_data:
    jsr lcd_wait
    tax
    and #$F0  ; high order 4 bits
    ora #(LCD_DATA|LCD_W)
    sta PORTB
    ora #(LCD_E)
    sta PORTB
    and #(LCD_EB)
    sta PORTB
    txa
    rol
    rol
    rol
    rol
    and #$F0  ; low order 4 bits in position
    ora #(LCD_DATA|LCD_W)
    sta PORTB
    ora #(LCD_E)
    sta PORTB
    and #(LCD_EB)
    sta PORTB
    rts

arna: .asciiz "Hello Arna!"
nanu: .asciiz "Hello Nanu!"

  .org $fffc
  .word reset
  .word $0000