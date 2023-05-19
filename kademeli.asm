;www.profahmet.com.tr.tc   www.profahmet.tr.cx
	LIST P=16F84A
	INCLUDE"P16F84A.INC"
	__CONFIG   _CP_OFF & _WDT_OFF & _PWRTE_ON & _HS_OSC
LT	EQU	H'20'
HT	EQU	H'21'
LT1	EQU	H'22'
HT1	EQU	H'23'
LSB	EQU	H'24'
MSB	EQU	H'25'
AYAR	EQU	H'26'

ZERO    EQU     H'3F'		; Say�lar i�in de�er atamalar�
ONE     EQU     H'06'
TWO     EQU     H'5B'
THREE   EQU     H'4F'
FOUR    EQU     H'66'
FIVE    EQU     H'6D'
SIX     EQU     H'7D'
SEVEN   EQU     H'07'
EIGHT   EQU     H'7F'
NINE    EQU     H'6F'
TEN	EQU	H'BF'
K_BIR	EQU     H'01'
K_IKI	EQU     H'03'
K_US	EQU     H'07'
K_DORT	EQU     H'0F'
K_BES	EQU     H'1F'
K_ALTI	EQU     H'3F'
K_YEDI	EQU     H'80'
K_SEKIZ	EQU     H'A3'
K_DOKUZ	EQU     H'C8'
K_ON	EQU     H'FF'
;----------------------
	ORG	0X00
	GOTO	BASLA
BASLA
	CLRF	PORTB
	CLRF	AYAR	; !!! AYAR'I MUTLAKA SIFIRLA YOKSA HATA �IKAR !!!!
	CLRF	LSB
	CLRF	MSB
	BSF	STATUS,5
	MOVLW	B'00010111';  PORTA,3 �IKI� P�N�
	MOVWF	TRISA
	CLRF	TRISB
	BCF	STATUS,5
	BCF	PORTA,3
	BCF	PORTA,2
	GOTO	TEST
TEST
	CALL	GOSTER
	MOVWF	PORTB
	BTFSS	PORTA,0
	GOTO	AZAL
	BTFSS	PORTA,1
	GOTO	ART
	GOTO	HAZIRLA
AZAL
	CALL	BEKLE
	MOVLW	.0
	SUBWF	AYAR,W
	BTFSC	STATUS,Z
	GOTO	TEST
	DECF	AYAR,F
	CALL	GOSTER
	MOVWF	PORTB
	GOTO	HAZIRLA
ART
	CALL	BEKLE
	MOVLW	.10
	SUBWF	AYAR,W
	BTFSC	STATUS,Z
	GOTO	TEST
	INCF	AYAR,F
	CALL	GOSTER
	MOVWF	PORTB
	GOTO	HAZIRLA
GOSTER
	MOVF	AYAR,W
KODLA
        ADDWF   PCL,F
        RETLW   ZERO
        RETLW   ONE
        RETLW   TWO
        RETLW   THREE
        RETLW   FOUR
        RETLW   FIVE
        RETLW   SIX
        RETLW   SEVEN
        RETLW   EIGHT
        RETLW   NINE
	RETLW	TEN
        RETLW   K_BIR
        RETLW   K_IKI
        RETLW   K_US
        RETLW   K_DORT
        RETLW   K_BES
        RETLW   K_ALTI
        RETLW   K_YEDI
        RETLW   K_SEKIZ
        RETLW   K_DOKUZ
	RETLW	K_ON
;--------------------
HAZIRLA
	CLRF	HT1
	CLRF	LT1
	MOVLW	.0
	SUBWF	AYAR,W
	BTFSC	STATUS,Z
	GOTO	TEST
ISLEM
	MOVF	AYAR,W
	ADDLW	.10
	CALL	KODLA
	MOVWF	HT1
	SUBLW	.255	
	BTFSC	STATUS,Z
	INCF	LT1,W
	MOVWF	LT1
	GOTO	CALIS
CALIS
	MOVF	HT1,W
	MOVWF	HT
	MOVF	LT1,W
	MOVWF	LT
SIFIR
	BCF	PORTA,3  ; PORTA,3'� "0" YAP
	CALL	SAYAC
	DECFSZ	LT,F
	GOTO	SIFIR
;----------------------
	BTFSS	PORTA,0
	GOTO	AZAL
	BTFSS	PORTA,1
	GOTO	ART
;----------------------
BIR
	BSF	PORTA,3  ; PORTA,3'� "1" YAP
	CALL	SAYAC
	DECFSZ	HT,F
	GOTO	BIR
	GOTO	CALIS
;----------------------
SAYAC
	MOVLW	.10
	MOVWF	LSB
SAY
	DECFSZ  LSB,F
	GOTO SAY
	RETURN
;----------------------
BEKLE
	MOVLW .255
	MOVWF LSB
DON1
	MOVLW .255
	MOVWF MSB
DON2	
	DECFSZ  MSB,F
	GOTO DON2
	DECFSZ  LSB,F
	GOTO DON1
	RETURN
;============================================================================;

	END