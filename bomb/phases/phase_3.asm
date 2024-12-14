; (lldb) di -n phase_3
bomb`phase_3:
bomb[0x400f43] <+0>:   subq   $0x18, %rsp
bomb[0x400f47] <+4>:   leaq   0xc(%rsp), %rcx
bomb[0x400f4c] <+9>:   leaq   0x8(%rsp), %rdx
bomb[0x400f51] <+14>:  movl   $0x4025cf, %esi ; imm = 0x4025CF
bomb[0x400f56] <+19>:  movl   $0x0, %eax
bomb[0x400f5b] <+24>:  callq  0x400bf0       ; symbol stub for: __isoc99_sscanf
bomb[0x400f60] <+29>:  cmpl   $0x1, %eax
bomb[0x400f63] <+32>:  jg     0x400f6a       ; <+39>
bomb[0x400f65] <+34>:  callq  0x40143a       ; explode_bomb
bomb[0x400f6a] <+39>:  cmpl   $0x7, 0x8(%rsp)
bomb[0x400f6f] <+44>:  ja     0x400fad       ; <+106>
bomb[0x400f71] <+46>:  movl   0x8(%rsp), %eax
bomb[0x400f75] <+50>:  jmpq   *0x402470(,%rax,8)
bomb[0x400f7c] <+57>:  movl   $0xcf, %eax
bomb[0x400f81] <+62>:  jmp    0x400fbe       ; <+123>
bomb[0x400f83] <+64>:  movl   $0x2c3, %eax ; imm = 0x2C3
bomb[0x400f88] <+69>:  jmp    0x400fbe       ; <+123>
bomb[0x400f8a] <+71>:  movl   $0x100, %eax ; imm = 0x100
bomb[0x400f8f] <+76>:  jmp    0x400fbe       ; <+123>
bomb[0x400f91] <+78>:  movl   $0x185, %eax ; imm = 0x185
bomb[0x400f96] <+83>:  jmp    0x400fbe       ; <+123>
bomb[0x400f98] <+85>:  movl   $0xce, %eax
bomb[0x400f9d] <+90>:  jmp    0x400fbe       ; <+123>
bomb[0x400f9f] <+92>:  movl   $0x2aa, %eax ; imm = 0x2AA
bomb[0x400fa4] <+97>:  jmp    0x400fbe       ; <+123>
bomb[0x400fa6] <+99>:  movl   $0x147, %eax ; imm = 0x147
bomb[0x400fab] <+104>: jmp    0x400fbe       ; <+123>
bomb[0x400fad] <+106>: callq  0x40143a       ; explode_bomb
bomb[0x400fb2] <+111>: movl   $0x0, %eax
bomb[0x400fb7] <+116>: jmp    0x400fbe       ; <+123>
bomb[0x400fb9] <+118>: movl   $0x137, %eax ; imm = 0x137
bomb[0x400fbe] <+123>: cmpl   0xc(%rsp), %eax
bomb[0x400fc2] <+127>: je     0x400fc9       ; <+134>
bomb[0x400fc4] <+129>: callq  0x40143a       ; explode_bomb
bomb[0x400fc9] <+134>: addq   $0x18, %rsp
bomb[0x400fcd] <+138>: retq

