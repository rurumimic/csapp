# (lldb) di -n phase_6
bomb`phase_6:
0x4010f4 <+0>:   pushq  %r14
0x4010f6 <+2>:   pushq  %r13
0x4010f8 <+4>:   pushq  %r12
0x4010fa <+6>:   pushq  %rbp
0x4010fb <+7>:   pushq  %rbx
0x4010fc <+8>:   subq   $0x50, %rsp
0x401100 <+12>:  movq   %rsp, %r13
0x401103 <+15>:  movq   %rsp, %rsi
0x401106 <+18>:  callq  0x40145c       ; read_six_numbers
0x40110b <+23>:  movq   %rsp, %r14
0x40110e <+26>:  movl   $0x0, %r12d
0x401114 <+32>:  movq   %r13, %rbp
0x401117 <+35>:  movl   (%r13), %eax
0x40111b <+39>:  subl   $0x1, %eax
0x40111e <+42>:  cmpl   $0x5, %eax
0x401121 <+45>:  jbe    0x401128       ; <+52>
0x401123 <+47>:  callq  0x40143a       ; explode_bomb
0x401128 <+52>:  addl   $0x1, %r12d
0x40112c <+56>:  cmpl   $0x6, %r12d
0x401130 <+60>:  je     0x401153       ; <+95>
0x401132 <+62>:  movl   %r12d, %ebx
0x401135 <+65>:  movslq %ebx, %rax
0x401138 <+68>:  movl   (%rsp,%rax,4), %eax
0x40113b <+71>:  cmpl   %eax, (%rbp)
0x40113e <+74>:  jne    0x401145       ; <+81>
0x401140 <+76>:  callq  0x40143a       ; explode_bomb
0x401145 <+81>:  addl   $0x1, %ebx
0x401148 <+84>:  cmpl   $0x5, %ebx
0x40114b <+87>:  jle    0x401135       ; <+65>
0x40114d <+89>:  addq   $0x4, %r13
0x401151 <+93>:  jmp    0x401114       ; <+32>
0x401153 <+95>:  leaq   0x18(%rsp), %rsi
0x401158 <+100>: movq   %r14, %rax
0x40115b <+103>: movl   $0x7, %ecx
0x401160 <+108>: movl   %ecx, %edx
0x401162 <+110>: subl   (%rax), %edx
0x401164 <+112>: movl   %edx, (%rax)
0x401166 <+114>: addq   $0x4, %rax
0x40116a <+118>: cmpq   %rsi, %rax
0x40116d <+121>: jne    0x401160       ; <+108>
0x40116f <+123>: movl   $0x0, %esi
0x401174 <+128>: jmp    0x401197       ; <+163>
0x401176 <+130>: movq   0x8(%rdx), %rdx
0x40117a <+134>: addl   $0x1, %eax
0x40117d <+137>: cmpl   %ecx, %eax
0x40117f <+139>: jne    0x401176       ; <+130>
0x401181 <+141>: jmp    0x401188       ; <+148>
0x401183 <+143>: movl   $0x6032d0, %edx ; imm = 0x6032D0
0x401188 <+148>: movq   %rdx, 0x20(%rsp,%rsi,2)
0x40118d <+153>: addq   $0x4, %rsi
0x401191 <+157>: cmpq   $0x18, %rsi
0x401195 <+161>: je     0x4011ab       ; <+183>
0x401197 <+163>: movl   (%rsp,%rsi), %ecx
0x40119a <+166>: cmpl   $0x1, %ecx
0x40119d <+169>: jle    0x401183       ; <+143>
0x40119f <+171>: movl   $0x1, %eax
0x4011a4 <+176>: movl   $0x6032d0, %edx ; imm = 0x6032D0
0x4011a9 <+181>: jmp    0x401176       ; <+130>
0x4011ab <+183>: movq   0x20(%rsp), %rbx
0x4011b0 <+188>: leaq   0x28(%rsp), %rax
0x4011b5 <+193>: leaq   0x50(%rsp), %rsi
0x4011ba <+198>: movq   %rbx, %rcx
0x4011bd <+201>: movq   (%rax), %rdx
0x4011c0 <+204>: movq   %rdx, 0x8(%rcx)
0x4011c4 <+208>: addq   $0x8, %rax
0x4011c8 <+212>: cmpq   %rsi, %rax
0x4011cb <+215>: je     0x4011d2       ; <+222>
0x4011cd <+217>: movq   %rdx, %rcx
0x4011d0 <+220>: jmp    0x4011bd       ; <+201>
0x4011d2 <+222>: movq   $0x0, 0x8(%rdx)
0x4011da <+230>: movl   $0x5, %ebp
0x4011df <+235>: movq   0x8(%rbx), %rax
0x4011e3 <+239>: movl   (%rax), %eax
0x4011e5 <+241>: cmpl   %eax, (%rbx)
0x4011e7 <+243>: jge    0x4011ee       ; <+250>
0x4011e9 <+245>: callq  0x40143a       ; explode_bomb
0x4011ee <+250>: movq   0x8(%rbx), %rbx
0x4011f2 <+254>: subl   $0x1, %ebp
0x4011f5 <+257>: jne    0x4011df       ; <+235>
0x4011f7 <+259>: addq   $0x50, %rsp
0x4011fb <+263>: popq   %rbx
0x4011fc <+264>: popq   %rbp
0x4011fd <+265>: popq   %r12
0x4011ff <+267>: popq   %r13
0x401201 <+269>: popq   %r14
0x401203 <+271>: retq

