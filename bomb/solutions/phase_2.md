# Phase 2

Run Debugger:

```bash
gdb ./bomb/bomb
lldb ./bomb/bomb
```

## Disassemble Phase 2

```asm
(gdb) disas phase_2
(lldb) di -n phase_2
```

Prologue:

```asm
bomb`phase_2:
0x400efc <+0>:  pushq  %rbp
0x400efd <+1>:  pushq  %rbx
0x400efe <+2>:  subq   $0x28, %rsp
```

- `0x28` = `0x10` + `0x18`
  - `0x08` (return address) + `0x08` (16-byte alignment)
    - 16 byte alignment: floating point, SIMD
  - `0x18` (six numbers)

Call `read_six_numbers`:

```asm
0x400f02 <+6>:  movq   %rsp, %rsi
0x400f05 <+9>:  callq  0x40145c       ; read_six_numbers
0x400f0a <+14>: cmpl   $0x1, (%rsp)
0x400f0e <+18>: je     0x400f30       ; <+52>
0x400f10 <+20>: callq  0x40143a       ; explode_bomb
```

Stack state after `read_six_numbers` completes:

```bash
(lldb) register read
rsp = 0x00007fffffffe1b0

(lldb) x -c24 $rsp
0x7fffffffe1b0: 01 00 00 00 02 00 00 00 04 00 00 00 08 00 00 00  ................
0x7fffffffe1c0: 10 00 00 00 20 00 00 00                          .... ...

(lldb) x -c48 '$rsp'
0x7fffffffe1b0: 01 00 00 00 02 00 00 00 04 00 00 00 08 00 00 00  ................
0x7fffffffe1c0: 10 00 00 00 20 00 00 00 31 14 40 00 00 00 00 00  .... ...1.@.....
0x7fffffffe1d0: 18 e3 ff ff ff 7f 00 00 18 e3 ff ff ff 7f 00 00  ................
```

Loop:

```asm
0x400f15 <+25>: jmp    0x400f30       ; <+52>
0x400f17 <+27>: movl   -0x4(%rbx), %eax
0x400f1a <+30>: addl   %eax, %eax
0x400f1c <+32>: cmpl   %eax, (%rbx)
0x400f1e <+34>: je     0x400f25       ; <+41>
0x400f20 <+36>: callq  0x40143a       ; explode_bomb
0x400f25 <+41>: addq   $0x4, %rbx
0x400f29 <+45>: cmpq   %rbp, %rbx
0x400f2c <+48>: jne    0x400f17       ; <+27>
0x400f2e <+50>: jmp    0x400f3c       ; <+64>
0x400f30 <+52>: leaq   0x4(%rsp), %rbx
0x400f35 <+57>: leaq   0x18(%rsp), %rbp
0x400f3a <+62>: jmp    0x400f17       ; <+27>
```

C code with the same logic:

```c
int xs[6] = {1, 2, 4, 8, 16, 32};
 
for (int i = 1; i < 6; i++) {
  if (xs[i] != xs[i-1] * 2) {
    return 1;
  }
}
```

Numbers stored on the stack in 4 bytes:

```asm
0x7fffffffe1b0: 1 ; (lldb) x/d -s4 $rsp
0x7fffffffe1b4: 2 ; (lldb) x/d -s4 '$rsp + 0x4'
0x7fffffffe1b8: 4 ; (lldb) x/d -s4 '$rsp + 8'
0x7fffffffe1bc: 8 ; (lldb) x/d -s4 '$rsp + 12'
0x7fffffffe1c0: 16 ; (lldb) x/d -s4 '$rsp + 16'
0x7fffffffe1c4: 32 ; (lldb) x/d -s4 '$rsp + 0x18'
```

Assembly logic sequence:

1. `rbx` = `0x00007fffffffe1b4` = 2
1. `rbp` = `0x00007fffffffe1c8`
1. `jmp <+27>`: loop 1 (1 + 1 = 2)
   1. `eax` = `rbx - 0x4` = 1 = `x/d '$rbx - 0x4'`
   1. `eax` = `eax + eax` = 1 + 1 = 2
   1. `eax` (2) == `rbx` (2)
   1. `je <+41>`
   1. `rbx + 0x4` = `0x00007fffffffe1b8` = 4 = `x/d $rbx`
   1. `rbp != rbx`
1. `jne <+27>`: loop 2 (2 + 2 = 4)
   1. `eax` = `rbx - 0x4` = 2 = `x/d '$rbx - 0x4'`
   1. `eax` = `eax + eax` = 2 + 2 = 4
   1. `eax` (4) == `rbx` (4)
   1. `je <+41>`
   1. `rbx + 0x4` = `0x00007fffffffe1bc` = 8 = `x/d $rbx`
   1. `rbp != rbx`
1. `jne <+27>`: loop 3 (4 + 4 = 8)
1. `jne <+27>`: loop 4 (8 + 8 = 16)
1. `jen <+27>`: loop 5 (16 + 16 = 32)
   1. `eax` = `rbx - 0x4` = 16 = `x/d '$rbx - 0x4'`
   1. `eax` = `eax + eax` = 16 + 16 = 32
   1. `eax` (32) == `rbx` (32)
   1. `je <+41>`
   1. `rbx + 0x4` = `0x00007fffffffe1c8`
   1. `rbp == rbx`
1. `jmp <+64>`

Epilogue:

```asm
0x400f3c <+64>: addq   $0x28, %rsp
0x400f40 <+68>: popq   %rbx
0x400f41 <+69>: popq   %rbp
0x400f42 <+70>: retq
```

## Disassemble `read_six_numbers`

```bash
(gdb) disas read_six_numbers # disas 0x40145c
(lldb) di -n read_six_numbers
```

Prologue:

```asm
bomb`read_six_numbers:
bomb[0x40145c] <+0>:  subq   $0x18, %rsp 
```

- `0x18` = `0x10` + `0x08`
  - `0x08` (return address) + `0x08` (16-byte alignment)
    - 16 byte alignment: floating point, SIMD
  - `0x08` (two numbers)

Stack pointer address value movement:

```asm
; phase_2
rsp = 0x00007fffffffe1d8
; 0x400efe <+2>:  subq   $0x28, %rsp
rsp = 0x00007fffffffe1b0

; read_six_numbers
rsp = 0x00007fffffffe1a8
; bomb[0x40145c] <+0>:  subq   $0x18, %rsp
rsp = 0x00007fffffffe190
```

Setting sscanf function parameters:

```asm
bomb[0x401460] <+4>:  movq   %rsi, %rdx
bomb[0x401463] <+7>:  leaq   0x4(%rsi), %rcx
bomb[0x401467] <+11>: leaq   0x14(%rsi), %rax
bomb[0x40146b] <+15>: movq   %rax, 0x8(%rsp)
bomb[0x401470] <+20>: leaq   0x10(%rsi), %rax
bomb[0x401474] <+24>: movq   %rax, (%rsp)
bomb[0x401478] <+28>: leaq   0xc(%rsi), %r9
bomb[0x40147c] <+32>: leaq   0x8(%rsi), %r8
```

1. `rdx`
2. `rcx`
3. `r8`
4. `r9`
5. `rsp`
6. `rsp + 0x8`

Setting the second parameter of the sscanf function:

```asm
bomb[0x401480] <+36>: movl   $0x4025c3, %esi ; imm = 0x4025C3
```

Examine string value:

```bash
(gdb) x/s 0x4025c3
(lldb) x/s 0x4025c3

0x004025c3: "%d %d %d %d %d %d"
```

Protocol of x86-64 System V ABI:

```asm
bomb[0x401485] <+41>: movl   $0x0, %eax
```

- clear `AL` (zero FP args in XMM registers)

Call sscanf:

```asm
bomb[0x40148a] <+46>: callq  0x400bf0       ; symbol stub for: __isoc99_sscanf
```

Compare number of numbers:

```asm
bomb[0x40148f] <+51>: cmpl   $0x5, %eax
bomb[0x401492] <+54>: jg     0x401499       ; <+61>
```

View FLAG:

```bash
(lldb) register read

rflags = 0x0000000000000202

; 0000 0010 0000 0010
;       o    sz     c
```

- compl: `destination - source`
  - Zero Flag = 1: `dest - src = 0`
  - Sign Flag = 1: `dest - src < 0`
  - Carry Flag = 1: `dest - src < 0`
  - Overflow Flag = 1: if an overflow occurs
- `compl $0x5, %eax`
  - `eax - 5 = 0`: ZF = 1
  - `eax - 5 > 0`: ZF = 0, SF = 0
  - `eax - 5 < 0`: SF = 1
- `jg`: `ZF == 0` and `SF == OF`

Stack state:

```asm
(lldb) x -c64 '$rsp-16'
0x7fffffffe180: 90 e2 ff ff ff 7f 00 00 8f 14 40 00 00 00 00 00  ..........@.....
0x7fffffffe190: c0 e1 ff ff ff 7f 00 00 c4 e1 ff ff ff 7f 00 00  ................
0x7fffffffe1a0: 18 e3 ff ff ff 7f 00 00 0a 0f 40 00 00 00 00 00  ..........@.....
0x7fffffffe1b0: 01 00 00 00 02 00 00 00 04 00 00 00 08 00 00 00  ................
```

| address                         | content        | value                           |
|---------------------------------|----------------|---------------------------------|
| `rsp + 0x18` (`0x7fffffffe1a8`) | return address | bomb`phase_2 <+14> (`0x400f0a`) |
| `rsp + 0x10` (`0x7fffffffe1a0`) | alignment      |                                 |
| `rsp + 0x08` (`0x7fffffffe198`) | 6th number     | `0x00007fffffffe1c4`            |
| `rsp + 0x00` (`0x7fffffffe190`) | 5th number     | `0x00007fffffffe1c0`            |

Epilogue:

```asm
bomb[0x401494] <+56>: callq  0x40143a       ; explode_bomb
bomb[0x401499] <+61>: addq   $0x18, %rsp
bomb[0x40149d] <+65>: retq
```

Answer:

```bash
1 2 4 8 16 32
```

Phase 2 defused:

```bash
That's number 2.  Keep going!
```

