
; Author Jeff Duntemann
; A simpl e progra m in assembl y fo r Linux
; demonstratin g simpl e tex t fil e I/ O (throug h redirection ) fo r readin g a n
; inpu t fil e to a buffe r in blocks , forcin g lowercas e character s to
; uppercase , an d writin g th e modifie d buffe r t o a n outpu t file .
; Ru n it thi s way :
; uppercaser 2 > (outpu t file) < (input file)
; Buil d usin g thes e commands :
; nas m - f el f - g - F stab s uppercaser2.asm
; ld - o uppercaser 2 uppercaser2. o 


SECTION .bss					; Secltion with uninitialized data

		BUFFLEN equ 1024	; Length of buffer
		Buff:	resb BUFFLEN; Text buffer

SECTION .data					; Section with initialised data

SECTION .text					; Section with code

global _start					; Linker needs this to find the entry point

start:							
		nop               ; This no-op keeps gdb happy

; Read a buffer full of text from stdin:
read:			
		mov eax,3				; Specify sys_read call
		mov ebx,0				; Specify File Descriptor 0: Standard Input
		mov ecx,Buff    ; Pass offset of the buffer to read to
		mov edx,BUFFLEN ; Pass number of bytes to read at one pass
		int 80h         ; Call sys_read to fill the buffer
		mov esi,eax		  ; Copy sys_read return value for safekeeping
		cmp eax,0				; If eax=0, sys_read reached EOF on stdin
		je Done      		; Jump if Equal (to 0, from compare)

; Set up registers for the process buffer step:
		mov ecx, esi		; Place the number of bytes read into ecx
		mov ebp,Buff    ; Place address of buffer into ebp
		dec ebp					; Adjust count to offset

; Go through the buffer and convert lowercase to uppercase characters:
Scan:
		cmp byte [ebp+ecx],61h	; Test input char against lowercase
		jb Next  				; If below 'a' in ASCII, not lowercase
		cmp byte [ebp+ecx],7Ah	; Test input char against lowecase 'z'
		ja Next  				; If above 'z' in ASCII, not lowercase 
		sub byte [ebp+ecx],20h	; Subtract 20H to give uppercase
Next:	
    dec ecx					 ; Decrement counter
		jnz Scan  			 ; If characters remains, loop back

; Write the buffer full of processed text to stdout;
Write:
		mov eax,4				; Specify sys_write call
		mov ebx,1				; Specify File Descriptor 1: Standard Input
		mov ecx,Buff   	; Pass offset of the buffer
		mov edx,esi   	; Pass the # of bytes of data in the buffer
		int 80h					; Make sys_write kernel call
		jmp read  			; Loop back and load another buffer full

; All done! Let's end this party
Done:
		mov eax,1				; Code for Exit Syscall
		mov ebx,0				; Return a code of zero
		int 80H					; Make sys_exit kernel call
