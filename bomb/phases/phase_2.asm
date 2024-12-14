; (lldb) di -n phase_2
bomb`phase_2:
bomb[0x400efc] <+0>:  pushq  %rbp
bomb[0x400efd] <+1>:  pushq  %rbx
bomb[0x400efe] <+2>:  subq   $0x28, %rsp
bomb[0x400f02] <+6>:  movq   %rsp, %rsi
bomb[0x400f05] <+9>:  callq  0x40145c       ; read_six_numbers
bomb[0x400f0a] <+14>: cmpl   $0x1, (%rsp)
bomb[0x400f0e] <+18>: je     0x400f30       ; <+52>
bomb[0x400f10] <+20>: callq  0x40143a       ; explode_bomb
bomb[0x400f15] <+25>: jmp    0x400f30       ; <+52>
bomb[0x400f17] <+27>: movl   -0x4(%rbx), %eax
bomb[0x400f1a] <+30>: addl   %eax, %eax
bomb[0x400f1c] <+32>: cmpl   %eax, (%rbx)
bomb[0x400f1e] <+34>: je     0x400f25       ; <+41>
bomb[0x400f20] <+36>: callq  0x40143a       ; explode_bomb
bomb[0x400f25] <+41>: addq   $0x4, %rbx
bomb[0x400f29] <+45>: cmpq   %rbp, %rbx
bomb[0x400f2c] <+48>: jne    0x400f17       ; <+27>
bomb[0x400f2e] <+50>: jmp    0x400f3c       ; <+64>
bomb[0x400f30] <+52>: leaq   0x4(%rsp), %rbx
bomb[0x400f35] <+57>: leaq   0x18(%rsp), %rbp
bomb[0x400f3a] <+62>: jmp    0x400f17       ; <+27>
bomb[0x400f3c] <+64>: addq   $0x28, %rsp
bomb[0x400f40] <+68>: popq   %rbx
bomb[0x400f41] <+69>: popq   %rbp
bomb[0x400f42] <+70>: retq

