; (lldb) di -n explode_bomb
bomb`explode_bomb:
bomb[0x40143a] <+0>:  subq   $0x8, %rsp
bomb[0x40143e] <+4>:  movl   $0x4025a3, %edi ; imm = 0x4025A3
bomb[0x401443] <+9>:  callq  0x400b10       ; symbol stub for: puts
bomb[0x401448] <+14>: movl   $0x4025ac, %edi ; imm = 0x4025AC
bomb[0x40144d] <+19>: callq  0x400b10       ; symbol stub for: puts
bomb[0x401452] <+24>: movl   $0x8, %edi
bomb[0x401457] <+29>: callq  0x400c20       ; symbol stub for: exit

