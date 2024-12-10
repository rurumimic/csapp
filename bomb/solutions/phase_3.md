# Phase 3

Run Debugger:

```bash
gdb ./bomb/bomb
lldb ./bomb/bomb
```

## Disassemble Phase 3

```asm
(gdb) disas phase_3
(lldb) di -n phase_3
```

```bash
(lldb) b phase_3
(lldb) b 0x400f75
```

```bash
(lldb) x -c64 0x402470
0x00402470: 7c 0f 40 00 00 00 00 00 b9 0f 40 00 00 00 00 00  |.@.......@.....
0x00402480: 83 0f 40 00 00 00 00 00 8a 0f 40 00 00 00 00 00  ..@.......@.....
0x00402490: 91 0f 40 00 00 00 00 00 98 0f 40 00 00 00 00 00  ..@.......@.....
0x004024a0: 9f 0f 40 00 00 00 00 00 a6 0f 40 00 00 00 00 00  ..@.......@.....
```

```asm
0x400f7c <+57> : movl   $0xcf, %eax
0x400fb9 <+118>: movl   $0x137, %eax ; imm = 0x137
0x400f83 <+64> : movl   $0x2c3, %eax ; imm = 0x2C3
0x400f8a <+71> : movl   $0x100, %eax ; imm = 0x100
0x400f91 <+78> : movl   $0x185, %eax ; imm = 0x185
0x400f98 <+85> : movl   $0xce, %eax
0x400f9f <+92> : movl   $0x2aa, %eax ; imm = 0x2AA
0x400fa6 <+99> : movl   $0x147, %eax ; imm = 0x147
```

```bash
->  0x400fbe <+123>: cmpl   0xc(%rsp), %eax

(lldb) register read
```

Answer:

```bash
0 207
1 311
2 707
3 256
4 389
5 206 
6 682
7 327
```

Phase 3 defused:

```bash
Halfway there!
```

