; (lldb) di -n read_line
bomb`read_line:
bomb[0x40149e] <+0>:   subq   $0x8, %rsp
bomb[0x4014a2] <+4>:   movl   $0x0, %eax
bomb[0x4014a7] <+9>:   callq  0x4013f9                  ; skip
bomb[0x4014ac] <+14>:  testq  %rax, %rax
bomb[0x4014af] <+17>:  jne    0x40151f                  ; <+129>
bomb[0x4014b1] <+19>:  movq   0x202290(%rip), %rax      ; stdin@@GLIBC_2.2.5
bomb[0x4014b8] <+26>:  cmpq   %rax, 0x2022a9(%rip)      ; infile
bomb[0x4014bf] <+33>:  jne    0x4014d5                  ; <+55>
bomb[0x4014c1] <+35>:  movl   $0x4025d5, %edi           ; imm = 0x4025D5
bomb[0x4014c6] <+40>:  callq  0x400b10                  ; symbol stub for: puts
bomb[0x4014cb] <+45>:  movl   $0x8, %edi
bomb[0x4014d0] <+50>:  callq  0x400c20                  ; symbol stub for: exit
bomb[0x4014d5] <+55>:  movl   $0x4025f3, %edi           ; imm = 0x4025F3
bomb[0x4014da] <+60>:  callq  0x400ae0                  ; symbol stub for: getenv
bomb[0x4014df] <+65>:  testq  %rax, %rax
bomb[0x4014e2] <+68>:  je     0x4014ee                  ; <+80>
bomb[0x4014e4] <+70>:  movl   $0x0, %edi
bomb[0x4014e9] <+75>:  callq  0x400c20                  ; symbol stub for: exit
bomb[0x4014ee] <+80>:  movq   0x202253(%rip), %rax      ; stdin@@GLIBC_2.2.5
bomb[0x4014f5] <+87>:  movq   %rax, 0x20226c(%rip)      ; infile
bomb[0x4014fc] <+94>:  movl   $0x0, %eax
bomb[0x401501] <+99>:  callq  0x4013f9                  ; skip
bomb[0x401506] <+104>: testq  %rax, %rax
bomb[0x401509] <+107>: jne    0x40151f                  ; <+129>
bomb[0x40150b] <+109>: movl   $0x4025d5, %edi           ; imm = 0x4025D5
bomb[0x401510] <+114>: callq  0x400b10                  ; symbol stub for: puts
bomb[0x401515] <+119>: movl   $0x0, %edi
bomb[0x40151a] <+124>: callq  0x400c20                  ; symbol stub for: exit
bomb[0x40151f] <+129>: movl   0x20223b(%rip), %edx      ; num_input_strings
bomb[0x401525] <+135>: movslq %edx, %rax
bomb[0x401528] <+138>: leaq   (%rax,%rax,4), %rsi
bomb[0x40152c] <+142>: shlq   $0x4, %rsi
bomb[0x401530] <+146>: addq   $0x603780, %rsi           ; imm = 0x603780
bomb[0x401537] <+153>: movq   %rsi, %rdi
bomb[0x40153a] <+156>: movl   $0x0, %eax
bomb[0x40153f] <+161>: movq   $-0x1, %rcx
bomb[0x401546] <+168>: repne  scasb     %es:(%rdi), %al
bomb[0x401548] <+170>: notq   %rcx
bomb[0x40154b] <+173>: subq   $0x1, %rcx
bomb[0x40154f] <+177>: cmpl   $0x4e, %ecx
bomb[0x401552] <+180>: jle    0x40159a                  ; <+252>
bomb[0x401554] <+182>: movl   $0x4025fe, %edi           ; imm = 0x4025FE
bomb[0x401559] <+187>: callq  0x400b10                  ; symbol stub for: puts
bomb[0x40155e] <+192>: movl   0x2021fc(%rip), %eax      ; num_input_strings
bomb[0x401564] <+198>: leal   0x1(%rax), %edx
bomb[0x401567] <+201>: movl   %edx, 0x2021f3(%rip)      ; num_input_strings
bomb[0x40156d] <+207>: cltq
bomb[0x40156f] <+209>: imulq  $0x50, %rax, %rax
bomb[0x401573] <+213>: movabsq $0x636e7572742a2a2a, %rdi ; imm = 0x636E7572742A2A2A
bomb[0x40157d] <+223>: movq   %rdi, 0x603780(%rax)
bomb[0x401584] <+230>: movabsq $0x2a2a2a64657461, %rdi   ; imm = 0x2A2A2A64657461
bomb[0x40158e] <+240>: movq   %rdi, 0x603788(%rax)
bomb[0x401595] <+247>: callq  0x40143a                  ; explode_bomb
bomb[0x40159a] <+252>: subl   $0x1, %ecx
bomb[0x40159d] <+255>: movslq %ecx, %rcx
bomb[0x4015a0] <+258>: movslq %edx, %rax
bomb[0x4015a3] <+261>: leaq   (%rax,%rax,4), %rax
bomb[0x4015a7] <+265>: shlq   $0x4, %rax
bomb[0x4015ab] <+269>: movb   $0x0, 0x603780(%rcx,%rax)
bomb[0x4015b3] <+277>: addl   $0x1, %edx
bomb[0x4015b6] <+280>: movl   %edx, 0x2021a4(%rip)      ; num_input_strings
bomb[0x4015bc] <+286>: movq   %rsi, %rax
bomb[0x4015bf] <+289>: addq   $0x8, %rsp
bomb[0x4015c3] <+293>: retq

