# Phase 2

Run Debugger:

```bash
gdb ./bomb/bomb
lldb ./bomb/bomb
```

## Disassemble Phase 2

```asm
(gdb) disas phase_2
(lldb) di -n phase_2
```

```asm
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
```

## Disassemble `read_six_numbers`

```asm
(gdb) disas read_six_numbers # disas 0x40145c
(lldb) di -n read_six_numbers

bomb`read_six_numbers:
bomb[0x40145c] <+0>:  subq   $0x18, %rsp
bomb[0x401460] <+4>:  movq   %rsi, %rdx
bomb[0x401463] <+7>:  leaq   0x4(%rsi), %rcx
bomb[0x401467] <+11>: leaq   0x14(%rsi), %rax
bomb[0x40146b] <+15>: movq   %rax, 0x8(%rsp)
bomb[0x401470] <+20>: leaq   0x10(%rsi), %rax
bomb[0x401474] <+24>: movq   %rax, (%rsp)
bomb[0x401478] <+28>: leaq   0xc(%rsi), %r9
bomb[0x40147c] <+32>: leaq   0x8(%rsi), %r8
bomb[0x401480] <+36>: movl   $0x4025c3, %esi ; imm = 0x4025C3
bomb[0x401485] <+41>: movl   $0x0, %eax
bomb[0x40148a] <+46>: callq  0x400bf0       ; symbol stub for: __isoc99_sscanf
bomb[0x40148f] <+51>: cmpl   $0x5, %eax
bomb[0x401492] <+54>: jg     0x401499       ; <+61>
bomb[0x401494] <+56>: callq  0x40143a       ; explode_bomb
bomb[0x401499] <+61>: addq   $0x18, %rsp
bomb[0x40149d] <+65>: retq
```

Answer:

```bash
1 2 4 8 16 32
```

Phase 2 defused:

```bash
That's number 2.  Keep going!
```

