# (lldb) di -n phase_1
bomb`phase_1:
0x400ee0 <+0>:  subq   $0x8, %rsp
0x400ee4 <+4>:  movl   $0x402400, %esi ; imm = 0x402400
0x400ee9 <+9>:  callq  0x401338       ; strings_not_equal
0x400eee <+14>: testl  %eax, %eax
0x400ef0 <+16>: je     0x400ef7       ; <+23>
0x400ef2 <+18>: callq  0x40143a       ; explode_bomb
0x400ef7 <+23>: addq   $0x8, %rsp
0x400efb <+27>: retq

