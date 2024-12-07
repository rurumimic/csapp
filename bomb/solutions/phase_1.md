# Phase 1

Run Debugger:

```bash
gdb ./bomb/bomb
```

Disassemble Phase 1:

```bash
Reading symbols from ./bomb/bomb...

(gdb) disas phase_1
Dump of assembler code for function phase_1:
   0x0000000000400ee0 <+0>:     sub    $0x8,%rsp
   0x0000000000400ee4 <+4>:     mov    $0x402400,%esi
   0x0000000000400ee9 <+9>:     call   0x401338 <strings_not_equal>
   0x0000000000400eee <+14>:    test   %eax,%eax
   0x0000000000400ef0 <+16>:    je     0x400ef7 <phase_1+23>
   0x0000000000400ef2 <+18>:    call   0x40143a <explode_bomb>
   0x0000000000400ef7 <+23>:    add    $0x8,%rsp
   0x0000000000400efb <+27>:    ret
End of assembler dump.
```

Examine Address:

```bash
(gdb) x/s 0x402400
0x402400:       "Border relations with Canada have never been better."
```

Run Phase 1:

```bash
(gdb) r
Starting program: /home/keanu/code/github/rurumimic/csapp/bomb/bomb/bomb
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
Welcome to my fiendish little bomb. You have 6 phases with
which to blow yourself up. Have a nice day!
```

Answer:

```bash
Border relations with Canada have never been better.
```

Phase 1 defused:

```bash
Phase 1 defused. How about the next one?
```

