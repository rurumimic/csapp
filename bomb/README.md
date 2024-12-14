# Bomb Lab

- 3e
  - [README](http://csapp.cs.cmu.edu/3e/README-bomblab)
  - [PDF](http://csapp.cs.cmu.edu/3e/bomblab.pdf)
  - [Release Notes](http://csapp.cs.cmu.edu/3e/bomblab-release.html)

## Self-Study Handout

- Download: [https://csapp.cs.cmu.edu/3e/bomb.tar](https://csapp.cs.cmu.edu/3e/bomb.tar)

```bash
curl --insecure --ciphers DEFAULT@SECLEVEL=0 -o bomb.tar https://csapp.cs.cmu.edu/3e/bomb.tar
tar -xf bomb.tar
```

```bash
tree -aph bomb/

bomb/
├── [-rwxr-xr-x  26K]  bomb
├── [-rw-r--r-- 4.0K]  bomb.c
└── [-rw-rw-r--   49]  README
```

## Six Phases

- Phase 1: [solution](solutions/phase_1.md), [phase_1.asm](phases/phase_1.asm)
- Phase 2: [solution](solutions/phase_2.md), [phase_2.asm](phases/phase_2.asm), [phase_2.c](c/phase_2.c)
- Phase 3: [solution](solutions/phase_3.md), [phase_3.asm](phases/phase_3.asm)
- Phase 4: [solution](solutions/phase_4.md), [phase_4.asm](phases/phase_4.asm), [phase_4.c](c/phase_4.c)
- Phase 5
- Phase 6

Subroutines: [phases/subroutines/*.asm](phases/subroutines)

## Hints

### Phase 1

#### Run Debugger

```bash
gdb ./bomb/bomb
lldb ./bomb/bomb
```

#### Disassemble Phase 1

```bash
(gdb) disas phase_1 # disassemble phase_1
(lldb) di -n phase_1 # disassemble --name phase_1
```

```asm
bomb`phase_1:
bomb[0x400ee0] <+0>:  subq   $0x8, %rsp
```

- 0x8 = return address

```asm
bomb[0x400ee4] <+4>:  movl   $0x402400, %esi ; imm = 0x402400
```

- the string

```asm
bomb[0x400ee9] <+9>:  callq  0x401338       ; strings_not_equal
bomb[0x400eee] <+14>: testl  %eax, %eax
bomb[0x400ef0] <+16>: je     0x400ef7       ; <+23>
```

- testl: `source & destination`
- eax: return value
- if `eax & eax == 0` then `Zero Flag = 1`
- if `ZF == 1` then goto +23

```asm
bomb[0x400ef2] <+18>: callq  0x40143a       ; explode_bomb
bomb[0x400ef7] <+23>: addq   $0x8, %rsp
bomb[0x400efb] <+27>: retq
```

#### Examine Address

```bash
(gdb) x 0x402400

0x402400:       0x64726f42
```

```bash
(gdb) ??? 0x402400

0x402400:       "????????"
```

```bash
(lldb) memory read -c256 0x402400
```

#### Defuse Phase 1

```bash
(gdb) r # run
```

```bash
Welcome to my fiendish little bomb. You have 6 phases with
which to blow yourself up. Have a nice day!

????????

Phase 1 defused. How about the next one?
```

### Save solutions

```bash
echo "???" >> solutions/solutions.txt
```

```bash
gdb ./bomb/bomb
(gdb) r solutions/solutions.txt
```

