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

## Solutions

- [Phase 1](solutions/phase_1.md)
- Phase 2
- Phase 3
- Phase 4
- Phase 5
- Phase 6

## Hints

### Phase 1

#### Run Debugger

```bash
gdb ./bomb/bomb
```

#### Disassemble Phase 1

```bash
(gdb) disas phase_1 # disassemble phase_1
```

```asm
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

#### Examine Address

```bash
(gdb) x 0x402400

0x402400:       0x64726f42
```

```bash
(gdb) ??? 0x402400

0x402400:       "????????"
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

