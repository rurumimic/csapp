; (lldb) di -n phase_1
bomb`phase_1:
bomb[0x400ee0] <+0>:  subq   $0x8, %rsp
bomb[0x400ee4] <+4>:  movl   $0x402400, %esi ; imm = 0x402400
bomb[0x400ee9] <+9>:  callq  0x401338       ; strings_not_equal
bomb[0x400eee] <+14>: testl  %eax, %eax
bomb[0x400ef0] <+16>: je     0x400ef7       ; <+23>
bomb[0x400ef2] <+18>: callq  0x40143a       ; explode_bomb
bomb[0x400ef7] <+23>: addq   $0x8, %rsp
bomb[0x400efb] <+27>: retq

