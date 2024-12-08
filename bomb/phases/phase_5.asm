# (lldb) di -n phase_5
bomb`phase_5:
0x401062 <+0>:   pushq  %rbx
0x401063 <+1>:   subq   $0x20, %rsp
0x401067 <+5>:   movq   %rdi, %rbx
0x40106a <+8>:   movq   %fs:0x28, %rax
0x401073 <+17>:  movq   %rax, 0x18(%rsp)
0x401078 <+22>:  xorl   %eax, %eax
0x40107a <+24>:  callq  0x40131b       ; string_length
0x40107f <+29>:  cmpl   $0x6, %eax
0x401082 <+32>:  je     0x4010d2       ; <+112>
0x401084 <+34>:  callq  0x40143a       ; explode_bomb
0x401089 <+39>:  jmp    0x4010d2       ; <+112>
0x40108b <+41>:  movzbl (%rbx,%rax), %ecx
0x40108f <+45>:  movb   %cl, (%rsp)
0x401092 <+48>:  movq   (%rsp), %rdx
0x401096 <+52>:  andl   $0xf, %edx
0x401099 <+55>:  movzbl 0x4024b0(%rdx), %edx
0x4010a0 <+62>:  movb   %dl, 0x10(%rsp,%rax)
0x4010a4 <+66>:  addq   $0x1, %rax
0x4010a8 <+70>:  cmpq   $0x6, %rax
0x4010ac <+74>:  jne    0x40108b       ; <+41>
0x4010ae <+76>:  movb   $0x0, 0x16(%rsp)
0x4010b3 <+81>:  movl   $0x40245e, %esi ; imm = 0x40245E
0x4010b8 <+86>:  leaq   0x10(%rsp), %rdi
0x4010bd <+91>:  callq  0x401338       ; strings_not_equal
0x4010c2 <+96>:  testl  %eax, %eax
0x4010c4 <+98>:  je     0x4010d9       ; <+119>
0x4010c6 <+100>: callq  0x40143a       ; explode_bomb
0x4010cb <+105>: nopl   (%rax,%rax)
0x4010d0 <+110>: jmp    0x4010d9       ; <+119>
0x4010d2 <+112>: movl   $0x0, %eax
0x4010d7 <+117>: jmp    0x40108b       ; <+41>
0x4010d9 <+119>: movq   0x18(%rsp), %rax
0x4010de <+124>: xorq   %fs:0x28, %rax
0x4010e7 <+133>: je     0x4010ee       ; <+140>
0x4010e9 <+135>: callq  0x400b30       ; symbol stub for: __stack_chk_fail
0x4010ee <+140>: addq   $0x20, %rsp
0x4010f2 <+144>: popq   %rbx
0x4010f3 <+145>: retq

