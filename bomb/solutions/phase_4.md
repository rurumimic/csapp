# Phase 4

Run Debugger:

```bash
gdb ./bomb/bomb
lldb ./bomb/bomb
```

```bash
              7
         /         \
      3              11
    /   \          /    \
   1     5       9      13
  / \   / \     / \     / \
 0   2 4   6   8  10  12  14
```

## Disassemble Phase 4

```asm
(gdb) disas phase_4
(lldb) di -n phase_4
```

Prologue and Get 2 input values:

```asm
bomb`phase_4:
bomb[0x40100c] <+0>:  subq   $0x18, %rsp
bomb[0x401010] <+4>:  leaq   0xc(%rsp), %rcx
bomb[0x401015] <+9>:  leaq   0x8(%rsp), %rdx
bomb[0x40101a] <+14>: movl   $0x4025cf, %esi ; imm = 0x4025CF
bomb[0x40101f] <+19>: movl   $0x0, %eax
bomb[0x401024] <+24>: callq  0x400bf0       ; symbol stub for: __isoc99_sscanf
bomb[0x401029] <+29>: cmpl   $0x2, %eax
bomb[0x40102c] <+32>: jne    0x401035       ; <+41>
```

Examine the string:

```bash
(lldb) x/s 0x4025cf
0x004025cf: "%d %d"
```

If `$rsp + 8` less than or equal to 14:

```asm
bomb[0x40102e] <+34>: cmpl   $0xe, 0x8(%rsp)
bomb[0x401033] <+39>: jbe    0x40103a       ; <+46>
bomb[0x401035] <+41>: callq  0x40143a       ; explode_bomb
```

1. 14 > `$rsp + 8`
1. `jbe <+46>`

Call func4:

```asm
bomb[0x40103a] <+46>: movl   $0xe, %edx
bomb[0x40103f] <+51>: movl   $0x0, %esi
bomb[0x401044] <+56>: movl   0x8(%rsp), %edi
bomb[0x401048] <+60>: callq  0x400fce       ; func4
bomb[0x40104d] <+65>: testl  %eax, %eax
bomb[0x40104f] <+67>: jne    0x401058       ; <+76>
```

- `edx`: 14
- `esi`: 0
- `edi`: first argument
- `eax`: 3 (13, 40)

### Call func4 1st

Prologue:

```asm
bomb`func4:
bomb[0x400fce] <+0>:  subq   $0x8, %rsp
```

Parameters:

```asm
bomb[0x400fd2] <+4>:  movl   %edx, %eax
bomb[0x400fd4] <+6>:  subl   %esi, %eax
bomb[0x400fd6] <+8>:  movl   %eax, %ecx
bomb[0x400fd8] <+10>: shrl   $0x1f, %ecx
bomb[0x400fdb] <+13>: addl   %ecx, %eax
bomb[0x400fdd] <+15>: sarl   %eax
```

1. `edx` -> `eax`: 14
1. `eax` - `esi` : 14 - 0
1. `ecx`: `eax` 14
1. `ecx >> 31`: `0b1110 >> 31` = `0b0000` = 0
1. `ecx` + `eax`: 0 + 14 = 14 = `0b1110`
1. `CF` = `eax >> 1`: `CF` = 0, `eax` = 7

```asm
bomb[0x400fdf] <+17>: leal   (%rax,%rsi), %ecx
bomb[0x400fe2] <+20>: cmpl   %edi, %ecx
bomb[0x400fe4] <+22>: jle    0x400ff2       ; <+36>
```

1. `ecx` = `rax` + `rsi` * 1: 7 = 7 + 0 * 1
1. `edi` >= `ecx`: 13 >= 7
1. `jle <+36>`

```asm
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
```

`<+36>`
1. `eax`: 0
1. `edi` <= `ecx`: 13 <= 7
   1. `jge <+57>`
1. `esi` = `rcx + 1`: 7 + 1 = 8
1. `callq <+0>`

#### Call func4 2nd

Parameters:

```asm
bomb[0x400fd2] <+4>:  movl   %edx, %eax
bomb[0x400fd4] <+6>:  subl   %esi, %eax
bomb[0x400fd6] <+8>:  movl   %eax, %ecx
bomb[0x400fd8] <+10>: shrl   $0x1f, %ecx
bomb[0x400fdb] <+13>: addl   %ecx, %eax
bomb[0x400fdd] <+15>: sarl   %eax
```

1. `edx` -> `eax`: 14
1. `eax` - `esi` : 14 - 8 = 6
1. `ecx`: `eax` 6
1. `ecx << 31`: `0b0110` = 0
1. `eax` = `ecx` + `eax`: 0 + 6 = 6 = `0b0110`
1. `CF` = `eax >> 1`: `CF` = 0, `eax` = `0b0011` = 3

```asm
bomb[0x400fdf] <+17>: leal   (%rax,%rsi), %ecx
bomb[0x400fe2] <+20>: cmpl   %edi, %ecx
bomb[0x400fe4] <+22>: jle    0x400ff2       ; <+36>
```

1. `ecx` = `rax` + `rsi` * 1: 11 = 3 + 8 * 1
1. `edi` >= `ecx`: 13 >= 11
1. `jle <+36>`

```asm
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
```

`<+36>`
1. `eax`: 0
1. `edi` <= `ecx`: 13 <= 11
   1. `jge <+57>`
1. `esi` = `rcx + 1`: 11 + 1 = 12
1. `callq <+0>`

#### Call func4 3rd

Parameters:

```asm
bomb[0x400fd2] <+4>:  movl   %edx, %eax
bomb[0x400fd4] <+6>:  subl   %esi, %eax
bomb[0x400fd6] <+8>:  movl   %eax, %ecx
bomb[0x400fd8] <+10>: shrl   $0x1f, %ecx
bomb[0x400fdb] <+13>: addl   %ecx, %eax
bomb[0x400fdd] <+15>: sarl   %eax
```

1. `edx` -> `eax`: 14
1. `eax` - `esi` : 14 - 12 = 2
1. `ecx`: `eax` 2
1. `ecx << 31`: `0b0010` = 0
1. `eax` = `ecx` + `eax`: 0 + 2 = 2 = `0b0010`
1. `CF` = `eax >> 1`: `CF` = 0, `eax` = `0b0001` = 1

```asm
bomb[0x400fdf] <+17>: leal   (%rax,%rsi), %ecx
bomb[0x400fe2] <+20>: cmpl   %edi, %ecx
bomb[0x400fe4] <+22>: jle    0x400ff2       ; <+36>
```

1. `ecx` = `rax` + `rsi` * 1: 13 = 1 + 12 * 1
1. `edi` >= `ecx`: 13 >= 13
1. `jle <+36>`

```asm
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
```

`<+36>`
1. `eax`: 0
1. `edi` <= `ecx`: 13 <= 13
1. `jge <+57>`
1. Step Out func4 (3rd)
1. `func4 <+53>`, `eax` = `rax + rax * 1 + 1` = 0 + 0 * 1 + 1 = 1
1. Step Out func4 (2nd)
1. `func4 <+53>`, `eax` = `rax + rax * 1 + 1` = 1 + 1 * 1 + 1 = 3
1. Step Out func4 (1st)
1. `phase4 <+65>`

### Phase 4

```asm
bomb[0x40104d] <+65>: testl  %eax, %eax
bomb[0x40104f] <+67>: jne    0x401058       ; <+76>
```

1. `eax` & `eax` = 3 & 3 = 3
1. `rflags` = 206 = `10 0000 0110`
1. `jne <+76>`: ZF (6nd) = 0
1. bomb!

## Solution

```asm
(lldb) b 0x40104d
(lldb) reg r # check eax is 0
(lldb) r
```

```asm
bomb[0x401051] <+69>: cmpl   $0x0, 0xc(%rsp)
bomb[0x401056] <+74>: je     0x40105d       ; <+81>
bomb[0x401058] <+76>: callq  0x40143a       ; explode_bomb
```

Answer:

```bash
0 0
1 0
3 0
7 0
```

Phase 4 defused:

```bash
So you got that one.  Try this one.
```

---

## Binary Search

```bash
              7
         /         \
      3              11
    /   \          /    \
   1     5       9      13
  / \   / \     / \     / \
 0   2 4   6   8  10  12  14
```

