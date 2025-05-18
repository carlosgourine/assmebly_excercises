stm8/

	#include "mapping.inc"
	#include "stm8s105c6.inc"
  segment 'ram0'
ledVal      ds.b
dirFlag     ds.b
	segment 'rom'


main.l
	; initialize SP
	ldw X,#stack_end
	ldw SP,X

	#ifdef RAM0	
	; clear RAM0
ram0_start.b EQU $ram0_segment_start
ram0_end.b EQU $ram0_segment_end
	ldw X,#ram0_start
clear_ram0.l
	clr (X)
	incw X
	cpw X,#ram0_end	
	jrule clear_ram0
	#endif

	#ifdef RAM1
	; clear RAM1
ram1_start.w EQU $ram1_segment_start
ram1_end.w EQU $ram1_segment_end	
	ldw X,#ram1_start
clear_ram1.l
	clr (X)
	incw X
	cpw X,#ram1_end	
	jrule clear_ram1
	#endif

	; clear stack
stack_start.w EQU $stack_segment_start
stack_end.w EQU $stack_segment_end
	ldw X,#stack_start
clear_stack.l
	clr (X)
	incw X
	cpw X,#stack_end	
	jrule clear_stack
	mov     PB_DDR,#$FF ;port b outputs
	mov     PB_CR1,#$FF ;push pull
  ld      A,#$01 ;(binary 00000001),this lights LED0 on PB0
	ld      ledVal,A ;store that initial value (0x01) in ram ledVal
	clr     dirFlag ;set direction = 0,shift left first
	ld      PB_ODR,A ;first led turned on?
  call    config_TIM3
	mov     TIM3_ARRH,#$3D ;in total H and L it should be 2Mhz/128,2Mhz/128*1=15625 and that should be 1 second dellay between leds
	mov     TIM3_ARRL,#$09 
	mov     TIM3_CR1,#%00000001 ;counter enabled 
	RIM
	
infinite_loop.l
	jra infinite_loop
  interrupt TIM3_ISR ;interupt service routine
TIM3_ISR:
	
	ld  A,TIM3_SR1  ;important to be able to clear status register later on it needs to be read first
	clr  TIM3_SR1   ;satus register set to 0,No update has occurred
	ld      A,ledVal           ;load accumulator with ledVal
	btjt    dirFlag,#0,shiftRight   ; if dirFlag_0  equal to 1 jump to shiftRight
shiftLeft:
	sll     A ;move bits to the left                 
	jrc     leftOverflow ;jump to leftOverflow if carry
	ld      ledVal,A
	ld     PB_ODR,A
	iret
leftOverflow:                      
	bset    dirFlag,#0         ; enabling it to shift left next time
	ld      A,#%10000000
	ld      ledVal,A
	ld     PB_ODR,A
	iret
shiftRight:
	srl     A                  
	jrc     rightOverflow
	ld      ledVal,A
	ld     PB_ODR,A
	iret
rightOverflow:                     ; hit the end -> bounce
	bres    dirFlag,#0         ; now go left
	ld      A,#$01
	ld      ledVal,A
	ld     PB_ODR,A
	iret
config_TIM3:
	mov   TIM3_CR1,  #$00    ; timer OFF, keep rest of CR1 = 0
	mov   TIM3_PSCR, #$07    ; prescaler 128  (16 MHz / 128 = 125 kHz)
	bset  TIM3_EGR,  #0      ; UG = 1 ? generate an update to reload PSC
	mov   TIM3_IER,  #$01    ; UIE = 1 ? enable update interrupt
	ret

	interrupt NonHandledInterrupt
NonHandledInterrupt.l
	iret

	segment 'vectit'
	dc.l {$82000000+main}									; reset
	dc.l {$82000000+NonHandledInterrupt}	; trap
	dc.l {$82000000+NonHandledInterrupt}	; irq0
	dc.l {$82000000+NonHandledInterrupt}	; irq1
	dc.l {$82000000+NonHandledInterrupt}	; irq2
	dc.l {$82000000+NonHandledInterrupt}	; irq3
	dc.l {$82000000+NonHandledInterrupt}	; irq4
	dc.l {$82000000+NonHandledInterrupt}	; irq5
	dc.l {$82000000+NonHandledInterrupt}	; irq6
	dc.l {$82000000+NonHandledInterrupt}	; irq7
	dc.l {$82000000+NonHandledInterrupt}	; irq8
	dc.l {$82000000+NonHandledInterrupt}	; irq9
	dc.l {$82000000+NonHandledInterrupt}	; irq10
	dc.l {$82000000+NonHandledInterrupt}	; irq11
	dc.l {$82000000+NonHandledInterrupt}	; irq12
	dc.l {$82000000+NonHandledInterrupt}	; irq13
	dc.l {$82000000+NonHandledInterrupt}	; irq14
	dc.l {$82000000+TIM3_ISR}	; irq15
	dc.l {$82000000+NonHandledInterrupt}	; irq16
	dc.l {$82000000+NonHandledInterrupt}	; irq17
	dc.l {$82000000+NonHandledInterrupt}	; irq18
	dc.l {$82000000+NonHandledInterrupt}	; irq19
	dc.l {$82000000+NonHandledInterrupt}	; irq20
	dc.l {$82000000+NonHandledInterrupt}	; irq21
	dc.l {$82000000+NonHandledInterrupt}	; irq22
	dc.l {$82000000+NonHandledInterrupt}	; irq23
	dc.l {$82000000+NonHandledInterrupt}	; irq24
	dc.l {$82000000+NonHandledInterrupt}	; irq25
	dc.l {$82000000+NonHandledInterrupt}	; irq26
	dc.l {$82000000+NonHandledInterrupt}	; irq27
	dc.l {$82000000+NonHandledInterrupt}	; irq28
	dc.l {$82000000+NonHandledInterrupt}	; irq29

	end
