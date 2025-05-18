stm8/

	#include "mapping.inc"
	#include "stm8s105c6.inc"
	
	segment 'ram0'


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

	mov   PD_DDR, #4
	mov   PD_CR1, #4
	bres  PA_DDR, #3
	bset  PA_CR1, #3
	bset  PA_CR2, #3
	bres  PE_DDR, #5
	bset  PE_CR1, #5
	bset  PE_CR2, #5
	mov   EXTI_CR1, #%00000010
	mov   EXTI_CR2, #%00000010
	call config_TIM2
	mov   TIM2_ARRH, #$01
	mov   TIM2_ARRL, #$8F
	mov   TIM2_CCR1H, #$00
	mov   TIM2_CCR1L, #$64
	mov   TIM2_CCER1, #%00000001
	mov   TIM2_CR1, #1
	RIM
	
infinite_loop.l
	jra infinite_loop
  interrupt PA3_ISR
PA3_ISR:
	mov   TIM2_CR1, #1      ; start PWM
	iret	
  interrupt PE5_ISR
PE5_ISR:
	mov   TIM2_CR1, #0      ; stop PWM
	iret
config_TIM2:
	mov     TIM2_CR1,   #%00000001 ; counter enable ON
	mov     TIM2_IER,   #$00       ; no interrupts (PWM mode)
	mov     TIM2_CCMR1, #%01100000 ; PWM mode 1, CC1 output
	mov     TIM2_CCER1, #%00000000 ; CC1 output disabled (enabled in main)
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
	dc.l {$82000000+PA3_ISR}	; irq3
	dc.l {$82000000+NonHandledInterrupt}	; irq4
	dc.l {$82000000+NonHandledInterrupt}	; irq5
	dc.l {$82000000+NonHandledInterrupt}	; irq6
	dc.l {$82000000+PE5_ISR}	; irq7
	dc.l {$82000000+NonHandledInterrupt}	; irq8
	dc.l {$82000000+NonHandledInterrupt}	; irq9
	dc.l {$82000000+NonHandledInterrupt}	; irq10
	dc.l {$82000000+NonHandledInterrupt}	; irq11
	dc.l {$82000000+NonHandledInterrupt}	; irq12
	dc.l {$82000000+NonHandledInterrupt}	; irq13
	dc.l {$82000000+NonHandledInterrupt}	; irq14
	dc.l {$82000000+NonHandledInterrupt}	; irq15
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
