; (lldb) di -n strings_not_equal
bomb`strings_not_equal:
bomb[0x401338] <+0>:   pushq  %r12
bomb[0x40133a] <+2>:   pushq  %rbp
bomb[0x40133b] <+3>:   pushq  %rbx
bomb[0x40133c] <+4>:   movq   %rdi, %rbx
bomb[0x40133f] <+7>:   movq   %rsi, %rbp
bomb[0x401342] <+10>:  callq  0x40131b       ; string_length
bomb[0x401347] <+15>:  movl   %eax, %r12d
bomb[0x40134a] <+18>:  movq   %rbp, %rdi
bomb[0x40134d] <+21>:  callq  0x40131b       ; string_length
bomb[0x401352] <+26>:  movl   $0x1, %edx
bomb[0x401357] <+31>:  cmpl   %eax, %r12d
bomb[0x40135a] <+34>:  jne    0x40139b       ; <+99>
bomb[0x40135c] <+36>:  movzbl (%rbx), %eax
bomb[0x40135f] <+39>:  testb  %al, %al
bomb[0x401361] <+41>:  je     0x401388       ; <+80>
bomb[0x401363] <+43>:  cmpb   (%rbp), %al
bomb[0x401366] <+46>:  je     0x401372       ; <+58>
bomb[0x401368] <+48>:  jmp    0x40138f       ; <+87>
bomb[0x40136a] <+50>:  cmpb   (%rbp), %al
bomb[0x40136d] <+53>:  nopl   (%rax)
bomb[0x401370] <+56>:  jne    0x401396       ; <+94>
bomb[0x401372] <+58>:  addq   $0x1, %rbx
bomb[0x401376] <+62>:  addq   $0x1, %rbp
bomb[0x40137a] <+66>:  movzbl (%rbx), %eax
bomb[0x40137d] <+69>:  testb  %al, %al
bomb[0x40137f] <+71>:  jne    0x40136a       ; <+50>
bomb[0x401381] <+73>:  movl   $0x0, %edx
bomb[0x401386] <+78>:  jmp    0x40139b       ; <+99>
bomb[0x401388] <+80>:  movl   $0x0, %edx
bomb[0x40138d] <+85>:  jmp    0x40139b       ; <+99>
bomb[0x40138f] <+87>:  movl   $0x1, %edx
bomb[0x401394] <+92>:  jmp    0x40139b       ; <+99>
bomb[0x401396] <+94>:  movl   $0x1, %edx
bomb[0x40139b] <+99>:  movl   %edx, %eax
bomb[0x40139d] <+101>: popq   %rbx
bomb[0x40139e] <+102>: popq   %rbp
bomb[0x40139f] <+103>: popq   %r12
bomb[0x4013a1] <+105>: retq

