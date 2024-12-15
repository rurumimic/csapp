bomb`skip:
bomb[0x4013f9] <+0>:  pushq  %rbx
bomb[0x4013fa] <+1>:  movslq 0x20235f(%rip), %rax ; num_input_strings
bomb[0x401401] <+8>:  leaq   (%rax,%rax,4), %rdi
bomb[0x401405] <+12>: shlq   $0x4, %rdi
bomb[0x401409] <+16>: addq   $0x603780, %rdi ; imm = 0x603780
bomb[0x401410] <+23>: movq   0x202351(%rip), %rdx ; infile
bomb[0x401417] <+30>: movl   $0x50, %esi
bomb[0x40141c] <+35>: callq  0x400b80       ; symbol stub for: fgets
bomb[0x401421] <+40>: movq   %rax, %rbx
bomb[0x401424] <+43>: testq  %rax, %rax
bomb[0x401427] <+46>: je     0x401435       ; <+60>
bomb[0x401429] <+48>: movq   %rax, %rdi
bomb[0x40142c] <+51>: callq  0x4013bc       ; blank_line
bomb[0x401431] <+56>: testl  %eax, %eax
bomb[0x401433] <+58>: jne    0x4013fa       ; <+1>
bomb[0x401435] <+60>: movq   %rbx, %rax
bomb[0x401438] <+63>: popq   %rbx
bomb[0x401439] <+64>: retq

