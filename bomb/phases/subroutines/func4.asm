; (lldb) dis -n func4
bomb`func4:
bomb[0x400fce] <+0>:  subq   $0x8, %rsp
bomb[0x400fd2] <+4>:  movl   %edx, %eax
bomb[0x400fd4] <+6>:  subl   %esi, %eax
bomb[0x400fd6] <+8>:  movl   %eax, %ecx
bomb[0x400fd8] <+10>: shrl   $0x1f, %ecx
bomb[0x400fdb] <+13>: addl   %ecx, %eax
bomb[0x400fdd] <+15>: sarl   %eax
bomb[0x400fdf] <+17>: leal   (%rax,%rsi), %ecx
bomb[0x400fe2] <+20>: cmpl   %edi, %ecx
bomb[0x400fe4] <+22>: jle    0x400ff2       ; <+36>
bomb[0x400fe6] <+24>: leal   -0x1(%rcx), %edx
bomb[0x400fe9] <+27>: callq  0x400fce       ; <+0>
bomb[0x400fee] <+32>: addl   %eax, %eax
bomb[0x400ff0] <+34>: jmp    0x401007       ; <+57>
bomb[0x400ff2] <+36>: movl   $0x0, %eax
bomb[0x400ff7] <+41>: cmpl   %edi, %ecx
bomb[0x400ff9] <+43>: jge    0x401007       ; <+57>
bomb[0x400ffb] <+45>: leal   0x1(%rcx), %esi
bomb[0x400ffe] <+48>: callq  0x400fce       ; <+0>
bomb[0x401003] <+53>: leal   0x1(%rax,%rax), %eax
bomb[0x401007] <+57>: addq   $0x8, %rsp
bomb[0x40100b] <+61>: retq

