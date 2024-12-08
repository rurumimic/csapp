# (lldb) di -n phase_2
bomb`phase_2:
0x400efc <+0>:  pushq  %rbp
0x400efd <+1>:  pushq  %rbx
0x400efe <+2>:  subq   $0x28, %rsp
0x400f02 <+6>:  movq   %rsp, %rsi
0x400f05 <+9>:  callq  0x40145c       ; read_six_numbers
0x400f0a <+14>: cmpl   $0x1, (%rsp)
0x400f0e <+18>: je     0x400f30       ; <+52>
0x400f10 <+20>: callq  0x40143a       ; explode_bomb
0x400f15 <+25>: jmp    0x400f30       ; <+52>
0x400f17 <+27>: movl   -0x4(%rbx), %eax
0x400f1a <+30>: addl   %eax, %eax
0x400f1c <+32>: cmpl   %eax, (%rbx)
0x400f1e <+34>: je     0x400f25       ; <+41>
0x400f20 <+36>: callq  0x40143a       ; explode_bomb
0x400f25 <+41>: addq   $0x4, %rbx
0x400f29 <+45>: cmpq   %rbp, %rbx
0x400f2c <+48>: jne    0x400f17       ; <+27>
0x400f2e <+50>: jmp    0x400f3c       ; <+64>
0x400f30 <+52>: leaq   0x4(%rsp), %rbx
0x400f35 <+57>: leaq   0x18(%rsp), %rbp
0x400f3a <+62>: jmp    0x400f17       ; <+27>
0x400f3c <+64>: addq   $0x28, %rsp
0x400f40 <+68>: popq   %rbx
0x400f41 <+69>: popq   %rbp
0x400f42 <+70>: retq

