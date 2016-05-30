	op macro  stuff,arg1
		mov ah,02h
		mov bh,00
		mov dh,arg1
		mov dl,col
		int 10h
		
		inc arg1
		
		lea dx,stuff
		mov ah,09h
		int 21h
		
		 endm
		 
		 
	
	
	.model small
	.stack 64
	.data 
m1	db	0c9h,15 dup(0cdh),0bbh,'$'
m2	db	0bah,'      Play     ',0bah,'$'
m3	db	0bah,'    Settings   ',0bah,'$'
m4	db	0bah,'      Quit     ',0bah,'$'
m5	db	0c8h,15 dup(0cdh),0bdh,'$'

m6	db	0c9h,15 dup(0cdh),0bbh,'$'
m7	db	0bah,'    New game   ',0bah,'$'
m8	db	0bah,'    Continue   ',0bah,'$'
m9	db	0bah,'      Back     ',0bah,'$'
m10	db	0c8h,15 dup(0cdh),0bdh,'$'

m11	db	0c9h,15 dup(0cdh),0bbh,'$'
m12	db	0bah,'     Graphics  ',0bah,'$'
m13	db	0bah,'      Audio    ',0bah,'$'
m14	db	0bah,'      Back     ',0bah,'$'
m15	db	0c8h,15 dup(0cdh),0bdh,'$'



row	db	7
col	db	30
rvar	db	8
tag		db	0

	.code
	main proc near
	mov ax,@data
	mov ds,ax
	
mainy:	
	
	call clrscreen
		
	mov row,7
	mov col,30
	
	call main_menu
	
	
	
	call highlight
	
k:	mov ah,10h
	int 16h
	
	cmp ah,50h	;down key
	je down
	cmp ah,48h	;up key
	je up
	cmp al,0dh
	je enterp
	jmp k

down:	
		cmp rvar,10
		je k
		call clrscreen
		mov col,30
		mov row,7
		cmp tag,1
		je psml
		cmp tag,2
		je psmo
		call main_menu
		inc rvar
		call highlight
		jmp k
		
up:	
		cmp rvar,8
		je k
		call clrscreen
		mov col,30
		mov row,7
		cmp tag,1
		je psm1
		cmp tag,2
		je psm2
		
		call main_menu
o:		dec rvar
		call highlight
		jmp k
		
		
enterp: cmp tag,1
		je bk
		cmp tag,2
		je bk
		cmp rvar,8
		je play
		cmp rvar,9
		je options
		cmp rvar,10
		je exit
		
play: 	
		mov tag,1
		call clrscreen
		call sub_menu_1
		mov col,31
		mov rvar,8
		call highlight
		jmp k

options: 	
			mov tag,2
			call clrscreen
			call sub_menu_2
		mov col,31
		mov rvar,8
		call highlight
		jmp k
bk: cmp rvar,10
	mov tag,0
	je	mainy
	jmp k
	
psml:	call sub_menu_1
		inc rvar
		call highlight
		jmp k
psmo:	call sub_menu_2
		inc rvar
		call highlight
		jmp k
psm1:	call sub_menu_1
		dec rvar
		call highlight
		jmp k
psm2:	call sub_menu_2
		dec rvar
		call highlight
		jmp k
		
		
		
		
		
		
		
		

	
	
	
exit:	mov ax,4c00h
	int 21h
	
	main endp
	
clrscreen proc near
	mov ax,0600h
	mov cx,0000
	mov bh,17h
	mov dx,184fh
	int 10h
	ret
clrscreen endp

main_menu proc near
	mov row,7
	
	op m1,row
	op m2,row
	op m3,row
	op m4,row
	op m5,row
	
	ret
main_menu endp

sub_menu_2 proc near
	
	mov row,7
		mov col,30
		op m11,row
		op m12,row
		op m13,row
		op m14,row
		op m15,row
	
	ret
sub_menu_2 endp

sub_menu_1 proc near
	mov row,7
		mov col,30
		op m6,row
		op m7,row
		op m8,row
		op m9,row
		op m10,row
	
	ret
sub_menu_1 endp

highlight	proc	near
	mov cx,15
	inc col
l1: 	
		
		
		mov ah,02h
		mov bh,00
		mov dh,rvar
		mov dl,col
		int 10h
		
		mov ah,08h
		mov bh,00	
		int 10h
		mov ah,09h
		mov bh,00
		mov bl,72h
		push cx
		mov cx, 1
		int 10h
		pop cx
		inc col
		loop l1

	ret
highlight endp
 	
	end