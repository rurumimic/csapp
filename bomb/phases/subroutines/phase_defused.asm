(lldb) di -n phase_defused
bomb`phase_defused:
bomb[0x4015c4] <+0>:   subq   $0x78, %rsp
bomb[0x4015c8] <+4>:   movq   %fs:0x28, %rax
bomb[0x4015d1] <+13>:  movq   %rax, 0x68(%rsp)
bomb[0x4015d6] <+18>:  xorl   %eax, %eax
bomb[0x4015d8] <+20>:  cmpl   $0x6, 0x202181(%rip) ; num_input_strings
bomb[0x4015df] <+27>:  jne    0x40163f       ; <+123>
bomb[0x4015e1] <+29>:  leaq   0x10(%rsp), %r8
bomb[0x4015e6] <+34>:  leaq   0xc(%rsp), %rcx
bomb[0x4015eb] <+39>:  leaq   0x8(%rsp), %rdx
bomb[0x4015f0] <+44>:  movl   $0x402619, %esi ; imm = 0x402619
bomb[0x4015f5] <+49>:  movl   $0x603870, %edi ; imm = 0x603870
bomb[0x4015fa] <+54>:  callq  0x400bf0       ; symbol stub for: __isoc99_sscanf
bomb[0x4015ff] <+59>:  cmpl   $0x3, %eax
bomb[0x401602] <+62>:  jne    0x401635       ; <+113>
bomb[0x401604] <+64>:  movl   $0x402622, %esi ; imm = 0x402622
bomb[0x401609] <+69>:  leaq   0x10(%rsp), %rdi
bomb[0x40160e] <+74>:  callq  0x401338       ; strings_not_equal
bomb[0x401613] <+79>:  testl  %eax, %eax
bomb[0x401615] <+81>:  jne    0x401635       ; <+113>
bomb[0x401617] <+83>:  movl   $0x4024f8, %edi ; imm = 0x4024F8
bomb[0x40161c] <+88>:  callq  0x400b10       ; symbol stub for: puts
bomb[0x401621] <+93>:  movl   $0x402520, %edi ; imm = 0x402520
bomb[0x401626] <+98>:  callq  0x400b10       ; symbol stub for: puts
bomb[0x40162b] <+103>: movl   $0x0, %eax
bomb[0x401630] <+108>: callq  0x401242       ; secret_phase
bomb[0x401635] <+113>: movl   $0x402558, %edi ; imm = 0x402558
bomb[0x40163a] <+118>: callq  0x400b10       ; symbol stub for: puts
bomb[0x40163f] <+123>: movq   0x68(%rsp), %rax
bomb[0x401644] <+128>: xorq   %fs:0x28, %rax
bomb[0x40164d] <+137>: je     0x401654       ; <+144>
bomb[0x40164f] <+139>: callq  0x400b30       ; symbol stub for: __stack_chk_fail
bomb[0x401654] <+144>: addq   $0x78, %rsp
bomb[0x401658] <+148>: retq

