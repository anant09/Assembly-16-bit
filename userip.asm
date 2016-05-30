	.model small
	.data

text db 'Enter data: ','$'
prompt db 'You had entered: ','$'
	
para_list label byte
max_len db 20
act_len db ?
u_data db 20 dup(' ')
	.code
.386
	main proc near
	mov ax,@data
	mov ds,ax
	lea dx,text
	mov ah,09h
	int 21h
	mov ah,0ah
	lea dx,para_list
	int 21h
	mov ah,09h
	lea dx,prompt
	int 21h
	
	
	movzx bx,act_len
	mov u_data[bx],07
	mov u_data[bx+1],'$'
	lea dx,u_data
	mov ah,09h
	int 21h
	
	mov ax,4c00h
	int 21h
	main endp 
end
	