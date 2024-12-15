# Phase 5

Run Debugger:

```bash
gdb ./bomb/bomb
lldb ./bomb/bomb
```

## Disassemble Phase 5

```asm
(gdb) disas phase_5
(lldb) di -n phase_5
```

### Prologue and Epilogue

```asm
bomb`phase_5:
bomb[0x401062] <+0>:   pushq  %rbx
bomb[0x401063] <+1>:   subq   $0x20, %rsp
bomb[0x401067] <+5>:   movq   %rdi, %rbx
bomb[0x40106a] <+8>:   movq   %fs:0x28, %rax
bomb[0x401073] <+17>:  movq   %rax, 0x18(%rsp)
bomb[0x401078] <+22>:  xorl   %eax, %eax

bomb[0x4010d9] <+119>: movq   0x18(%rsp), %rax
bomb[0x4010de] <+124>: xorq   %fs:0x28, %rax
bomb[0x4010e7] <+133>: je     0x4010ee                  ; <+140>
bomb[0x4010e9] <+135>: callq  0x400b30                  ; symbol stub for: __stack_chk_fail
bomb[0x4010ee] <+140>: addq   $0x20, %rsp
bomb[0x4010f2] <+144>: popq   %rbx
bomb[0x4010f3] <+145>: retq
```

- `%fs:0x28`: stack canary

```asm
(lldb) x/s $rdi
0x006038c0: "abcdef"
```

#### Random bit

```asm
bomb[0x40106a] <+8>:   movq   %fs:0x28, %rax

(lldb) reg r
General Purpose Registers:
       rax = 0x25054d9acf13f300
```

save random bit:

```asm
bomb[0x401073] <+17>:  movq   %rax, 0x18(%rsp)

(lldb) x -c8 '$rsp+0x18'
0x7fffffffd5c8: 00 f3 13 cf 9a 4d 05 25                          .....M.%
```

`eax` to 0:

```asm
bomb[0x401078] <+22>:  xorl   %eax, %eax

(lldb) reg r
rax = 0x0000000000000000
```

### Length of the string == 6

```asm
bomb[0x40107a] <+24>:  callq  0x40131b                  ; string_length
bomb[0x40107f] <+29>:  cmpl   $0x6, %eax
bomb[0x401082] <+32>:  je     0x4010d2       ; <+112>
bomb[0x401084] <+34>:  callq  0x40143a       ; explode_bomb
```

### Set eax to 0

```asm
bomb[0x4010d2] <+112>: movl   $0x0, %eax
bomb[0x4010d7] <+117>: jmp    0x40108b       ; <+41>
```

### Loop

```asm
bomb[0x40108b] <+41>:  movzbl (%rbx,%rax), %ecx
bomb[0x40108f] <+45>:  movb   %cl, (%rsp)
bomb[0x401092] <+48>:  movq   (%rsp), %rdx
bomb[0x401096] <+52>:  andl   $0xf, %edx
bomb[0x401099] <+55>:  movzbl 0x4024b0(%rdx), %edx
bomb[0x4010a0] <+62>:  movb   %dl, 0x10(%rsp,%rax)
bomb[0x4010a4] <+66>:  addq   $0x1, %rax
bomb[0x4010a8] <+70>:  cmpq   $0x6, %rax
bomb[0x4010ac] <+74>:  jne    0x40108b       ; <+41>
```

#### From Input Strings

```asm
(lldb) x/s $rbx
0x006038c0: "abcdef"

(lldb) x/b -c8 $rbx
0x006038c0: 0x61 0x62 0x63 0x64 0x65 0x66 0x00 0x00
```

```asm
bomb[0x40108b] <+41>:  movzbl (%rbx,%rax), %ecx
```

- `0x61` = `0x61 + rax (0)`

#### CL to RSP

```asm
(lldb) x $rsp
0x7fffffffd5b0: 02 00 00 00 00 00 00 00 31 14 40 00 00 00 00 00  ........1.@.....
```

```asm
bomb[0x40108f] <+45>:  movb   %cl, (%rsp)
```

```asm
(lldb) x $rsp
0x7fffffffd5b0: 61 00 00 00 00 00 00 00 31 14 40 00 00 00 00 00  a.......1.@.....
```

#### RSP to RDX

```asm
bomb[0x401092] <+48>:  movq   (%rsp), %rdx
bomb[0x401096] <+52>:  andl   $0xf, %edx
```

1. Copy `rsp` to `rdx`
1. Mask `rdx` with `0xf`

#### Copy from 0x4024b0

```asm
(lldb) x -c16 0x4024b0
0x004024b0: 6d 61 64 75 69 65 72 73 6e 66 6f 74 76 62 79 6c  maduiersnfotvbyl
```

```asm
; rdx = 0x01
bomb[0x401099] <+55>:  movzbl 0x4024b0(%rdx), %edx
```

```asm
(lldb) reg r
rdx = 0x0000000000000061

(lldb) p $rdx ; print $rdx
(unsigned long) 97

(lldb) p/x $rdx
(unsigned long) 0x0000000000000061
```

#### DL to RAX

```asm
(lldb) p $dl
(unsigned long) 'a'

(lldb) p/x $dl
(unsigned long) 0x61
```

```asm
(lldb) x $rsp
0x7fffffffd5b0: 61 00 00 00 00 00 00 00 31 14 40 00 00 00 00 00  a.......1.@.....
0x7fffffffd5c0: f8 d6 ff ff ff 7f 00 00 00 f3 13 cf 9a 4d 05 25  .............M.%
```

```asm
bomb[0x4010a0] <+62>:  movb   %dl, 0x10(%rsp,%rax)
```

```asm
(lldb) x $rsp
0x7fffffffd5b0: 61 00 00 00 00 00 00 00 31 14 40 00 00 00 00 00  a.......1.@.....
0x7fffffffd5c0: 61 d6 ff ff ff 7f 00 00 00 f3 13 cf 9a 4d 05 25  a............M.%
```

#### Add 1 to RAX

```asm
bomb[0x4010a4] <+66>:  addq   $0x1, %rax
bomb[0x4010a8] <+70>:  cmpq   $0x6, %rax
bomb[0x4010ac] <+74>:  jne    0x40108b       ; <+41>
```

Repeat until `rax` reaches `6`.

### Check the string

```asm
(lldb) b 0x4010ae
(lldb) x/s '$rsp + 0x10'
0x7fffffffd5c0: "aduier"
```

```asm
bomb[0x4010ae] <+76>:  movb   $0x0, 0x16(%rsp)
bomb[0x4010b3] <+81>:  movl   $0x40245e, %esi ; imm = 0x40245E
bomb[0x4010b8] <+86>:  leaq   0x10(%rsp), %rdi
bomb[0x4010bd] <+91>:  callq  0x401338       ; strings_not_equal
bomb[0x4010c2] <+96>:  testl  %eax, %eax
bomb[0x4010c4] <+98>:  je     0x4010d9       ; <+119>
bomb[0x4010c6] <+100>: callq  0x40143a       ; explode_bomb
bomb[0x4010cb] <+105>: nopl   (%rax,%rax)
bomb[0x4010d0] <+110>: jmp    0x4010d9       ; <+119>
```

```asm
(lldb) x/s 0x40245e
0x0040245e: "flyers"
```

```asm
(lldb) reg r
rax = 0x0000000000000001
```

### Compare strings

First try:

```txt
input :  abcdef
        maduiersnfotvbyl
output:  aduier
```

So:

```txt
input :
         !"#$%&'()*+,-./
        0123456789:;<=>?
        @ABCDEFGHIJKLMNO
        PQRSTUVWXYZ[\]^_ 
        `abcdefghijklmno
        pqrstuvwxyz{|}~ 
------------------------
        maduiersnfotvbyl
------------------------
output:      ers f    yl
```

---

## Answer

```bash
)/.%&'
9?>567
IONEFG
Y_^UVW
ionefg
y~uvw
```

- `<DEL>`: vim insert mode `<Ctrl + V> + <DEL>` 

Phase 5 defused:

```bash
Good work!  On to the next...
```

