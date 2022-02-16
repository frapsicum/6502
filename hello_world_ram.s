; Print hello world with ram, so can use routines.
; Uses 8 bit interface

  .org $8000
PORTB = $6000
PORTA = $6001
DDRB = $6002
DDRA = $6003

LCD_E = %10000000
LCD_W = %00000000
LCD_R = %01000000
LCD_INS = %00000000
LCD_DATA = %00100000

lcd_instruction_pre:
    lda #(LCD_INS|LCD_W)
    sta PORTA
    rts

lcd_data_pre:
    lda #(LCD_DATA|LCD_W)
    sta PORTA
    rts

; Send A register contents to PORTB as instruction
; A register is consumed
lcd_send_instruction:
    sta PORTB
    lda #(LCD_INS|LCD_W|LCD_E)
    sta PORTA
    lda #(LCD_INS|LCD_W)
    sta PORTA
    rts

; Send A register contents to PORTB as data
; A register is consumed
lcd_send_data:
    sta PORTB
    lda #(LCD_DATA|LCD_W|LCD_E)
    sta PORTA
    lda #(LCD_DATA|LCD_W)
    sta PORTA
    rts

lcd_write_hello:
  jsr lcd_data_pre
  lda #"H"
  jsr lcd_send_data

  lda #"E"
  jsr lcd_send_data

  lda #"L"
  jsr lcd_send_data

  lda #"L"
  jsr lcd_send_data

  lda #"O"
  jsr lcd_send_data
  rts

reset:
  lda #$ff
  sta DDRB
  sta DDRA

  jsr lcd_instruction_pre
  lda #%00111000  ; 8 bits, 2 lines, 5x8 dots
  jsr lcd_send_instruction

  lda #%00000110  ; Increment curson, no display shift
  jsr lcd_send_instruction

  lda #%00001110  ; Display on, curson on, blink off
  jsr lcd_send_instruction
  jmp initial_iter
loop:
  jsr lcd_instruction_pre
initial_iter:
  lda #%00000001  ; Clear display, curson = 0
  jsr lcd_send_instruction

  jsr lcd_write_hello

  lda #" "
  jsr lcd_send_data

  lda #"A"
  jsr lcd_send_data

  lda #"R"
  jsr lcd_send_data

  lda #"N"
  jsr lcd_send_data

  lda #"A"
  jsr lcd_send_data

  lda #"!"
  jsr lcd_send_data

  jsr lcd_instruction_pre
  lda #%11000000  ; Move curson to second line
  jsr lcd_send_instruction

  jsr lcd_write_hello

  lda #" "
  jsr lcd_send_data

  lda #"N"
  jsr lcd_send_data

  lda #"A"
  jsr lcd_send_data

  lda #"V"
  jsr lcd_send_data

  lda #"Y"
  jsr lcd_send_data

  lda #"A"
  jsr lcd_send_data

  lda #"!"
  jsr lcd_send_data

  jmp loop

  .org $fffc
  .word reset
  .word $0000