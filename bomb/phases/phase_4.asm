; (lldb) di -n phase_4
bomb`phase_4:
bomb[0x40100c] <+0>:  subq   $0x18, %rsp
bomb[0x401010] <+4>:  leaq   0xc(%rsp), %rcx
bomb[0x401015] <+9>:  leaq   0x8(%rsp), %rdx
bomb[0x40101a] <+14>: movl   $0x4025cf, %esi ; imm = 0x4025CF
bomb[0x40101f] <+19>: movl   $0x0, %eax
bomb[0x401024] <+24>: callq  0x400bf0       ; symbol stub for: __isoc99_sscanf
bomb[0x401029] <+29>: cmpl   $0x2, %eax
bomb[0x40102c] <+32>: jne    0x401035       ; <+41>
bomb[0x40102e] <+34>: cmpl   $0xe, 0x8(%rsp)
bomb[0x401033] <+39>: jbe    0x40103a       ; <+46>
bomb[0x401035] <+41>: callq  0x40143a       ; explode_bomb
bomb[0x40103a] <+46>: movl   $0xe, %edx
bomb[0x40103f] <+51>: movl   $0x0, %esi
bomb[0x401044] <+56>: movl   0x8(%rsp), %edi
bomb[0x401048] <+60>: callq  0x400fce       ; func4
bomb[0x40104d] <+65>: testl  %eax, %eax
bomb[0x40104f] <+67>: jne    0x401058       ; <+76>
bomb[0x401051] <+69>: cmpl   $0x0, 0xc(%rsp)
bomb[0x401056] <+74>: je     0x40105d       ; <+81>
bomb[0x401058] <+76>: callq  0x40143a       ; explode_bomb
bomb[0x40105d] <+81>: addq   $0x18, %rsp
bomb[0x401061] <+85>: retq

