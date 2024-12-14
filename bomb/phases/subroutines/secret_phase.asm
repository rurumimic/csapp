(lldb) di -n secret_phase
bomb`secret_phase:
bomb[0x401242] <+0>:  pushq  %rbx
bomb[0x401243] <+1>:  callq  0x40149e       ; read_line
bomb[0x401248] <+6>:  movl   $0xa, %edx
bomb[0x40124d] <+11>: movl   $0x0, %esi
bomb[0x401252] <+16>: movq   %rax, %rdi
bomb[0x401255] <+19>: callq  0x400bd0       ; symbol stub for: strtol
bomb[0x40125a] <+24>: movq   %rax, %rbx
bomb[0x40125d] <+27>: leal   -0x1(%rax), %eax
bomb[0x401260] <+30>: cmpl   $0x3e8, %eax   ; imm = 0x3E8
bomb[0x401265] <+35>: jbe    0x40126c       ; <+42>
bomb[0x401267] <+37>: callq  0x40143a       ; explode_bomb
bomb[0x40126c] <+42>: movl   %ebx, %esi
bomb[0x40126e] <+44>: movl   $0x6030f0, %edi ; imm = 0x6030F0
bomb[0x401273] <+49>: callq  0x401204       ; fun7
bomb[0x401278] <+54>: cmpl   $0x2, %eax
bomb[0x40127b] <+57>: je     0x401282       ; <+64>
bomb[0x40127d] <+59>: callq  0x40143a       ; explode_bomb
bomb[0x401282] <+64>: movl   $0x402438, %edi ; imm = 0x402438
bomb[0x401287] <+69>: callq  0x400b10       ; symbol stub for: puts
bomb[0x40128c] <+74>: callq  0x4015c4       ; phase_defused
bomb[0x401291] <+79>: popq   %rbx
bomb[0x401292] <+80>: retq

