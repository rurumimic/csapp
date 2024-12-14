(lldb) di -n fun7
bomb`fun7:
bomb[0x401204] <+0>:  subq   $0x8, %rsp
bomb[0x401208] <+4>:  testq  %rdi, %rdi
bomb[0x40120b] <+7>:  je     0x401238       ; <+52>
bomb[0x40120d] <+9>:  movl   (%rdi), %edx
bomb[0x40120f] <+11>: cmpl   %esi, %edx
bomb[0x401211] <+13>: jle    0x401220       ; <+28>
bomb[0x401213] <+15>: movq   0x8(%rdi), %rdi
bomb[0x401217] <+19>: callq  0x401204       ; <+0>
bomb[0x40121c] <+24>: addl   %eax, %eax
bomb[0x40121e] <+26>: jmp    0x40123d       ; <+57>
bomb[0x401220] <+28>: movl   $0x0, %eax
bomb[0x401225] <+33>: cmpl   %esi, %edx
bomb[0x401227] <+35>: je     0x40123d       ; <+57>
bomb[0x401229] <+37>: movq   0x10(%rdi), %rdi
bomb[0x40122d] <+41>: callq  0x401204       ; <+0>
bomb[0x401232] <+46>: leal   0x1(%rax,%rax), %eax
bomb[0x401236] <+50>: jmp    0x40123d       ; <+57>
bomb[0x401238] <+52>: movl   $0xffffffff, %eax ; imm = 0xFFFFFFFF
bomb[0x40123d] <+57>: addq   $0x8, %rsp
bomb[0x401241] <+61>: retq

