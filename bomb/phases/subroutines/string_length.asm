; (lldb) di -n string_length
bomb`string_length:
bomb[0x40131b] <+0>:  cmpb   $0x0, (%rdi)
bomb[0x40131e] <+3>:  je     0x401332       ; <+23>
bomb[0x401320] <+5>:  movq   %rdi, %rdx
bomb[0x401323] <+8>:  addq   $0x1, %rdx
bomb[0x401327] <+12>: movl   %edx, %eax
bomb[0x401329] <+14>: subl   %edi, %eax
bomb[0x40132b] <+16>: cmpb   $0x0, (%rdx)
bomb[0x40132e] <+19>: jne    0x401323       ; <+8>
bomb[0x401330] <+21>: rep    retq
bomb[0x401332] <+23>: movl   $0x0, %eax
bomb[0x401337] <+28>: retq

