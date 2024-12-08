# (lldb) di -n read_six_numbers
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

