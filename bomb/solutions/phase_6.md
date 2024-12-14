# Phase 6

Run Debugger:

```bash
gdb ./bomb/bomb
lldb ./bomb/bomb
```

## Disassemble Phase 6

```asm
(gdb) disas phase_6
(lldb) di -n phase_6
```

### Prologue

```asm
(lldb) reg r
rsp = 0x00007fffffffe1a0
```

```asm
bomb[0x4010fc] <+8>:   subq   $0x50, %rsp
bomb[0x401100] <+12>:  movq   %rsp, %r13
bomb[0x401103] <+15>:  movq   %rsp, %rsi
bomb[0x401106] <+18>:  callq  0x40145c       ; read_six_numbers
```

```asm
(lldb) reg r
rax = 0x0000000000000006
rsp = 0x00007fffffffe150
```

```asm
(lldb) x/d -c6 $rsp
0x7fffffffe150: 4
0x7fffffffe154: 3
0x7fffffffe158: 2
0x7fffffffe15c: 1
0x7fffffffe160: 6
0x7fffffffe164: 5
```

## Loop

#### Backup RSP

```asm
bomb[0x40110b] <+23>:  movq   %rsp, %r14
```

#### Index

```asm
bomb[0x40110e] <+26>:  movl   $0x0, %r12d
```

#### Range Check

```asm
bomb[0x401114] <+32>:  movq   %r13, %rbp
bomb[0x401117] <+35>:  movl   (%r13), %eax
bomb[0x40111b] <+39>:  subl   $0x1, %eax
bomb[0x40111e] <+42>:  cmpl   $0x5, %eax
bomb[0x401121] <+45>:  jbe    0x401128       ; <+52>
bomb[0x401123] <+47>:  callq  0x40143a       ; explode_bomb
```

- `r13`: stack pointer (`<+12>`). current number
- `rbp`: backup `r13`
- `eax`: current - 1. for 0-based index
- `0 <= current - 1 <= 5`

```asm
(lldb) x/d $r13
0x7fffffffe150: 4
```

#### To Next Number

```asm
bomb[0x401128] <+52>:  addl   $0x1, %r12d
bomb[0x40112c] <+56>:  cmpl   $0x6, %r12d
bomb[0x401130] <+60>:  je     0x401153       ; <+95>
```

#### Duplicate Check Loop

```asm
bomb[0x401132] <+62>:  movl   %r12d, %ebx
bomb[0x401135] <+65>:  movslq %ebx, %rax
bomb[0x401138] <+68>:  movl   (%rsp,%rax,4), %eax
bomb[0x40113b] <+71>:  cmpl   %eax, (%rbp)
bomb[0x40113e] <+74>:  jne    0x401145       ; <+81>
bomb[0x401140] <+76>:  callq  0x40143a       ; explode_bomb
```

- `rax = ebx`: current index

```asm
(lldb) x/d '$rsp + $rax * 4'
0x7fffffffe154: 3
```

- `eax`: current number 
- `rbp`: previous number
- `eax != rbp`: ok

##### To Next Number

```asm
bomb[0x401145] <+81>:  addl   $0x1, %ebx
bomb[0x401148] <+84>:  cmpl   $0x5, %ebx
bomb[0x40114b] <+87>:  jle    0x401135       ; <+65>
bomb[0x40114d] <+89>:  addq   $0x4, %r13
bomb[0x401151] <+93>:  jmp    0x401114       ; <+32>
```

- `ebx += 1`

#### C code with the same logic

```c
int i, j;

for (i = 0; i < 6; i++) {
    if (input[i] < 1 || input[i] > 6) {
        explode_bomb();
    }

    for (j = 0; j < i; j++) {
        if (input[i] == input[j]) {
            explode_bomb();
        }
    }
}
```

### Convert input values

```asm
bomb[0x401153] <+95>:  leaq   0x18(%rsp), %rsi
```

```asm
(lldb) x -c24 $rsp
0x7fffffffe150: 04 00 00 00 03 00 00 00 02 00 00 00 01 00 00 00  ................
0x7fffffffe160: 06 00 00 00 05 00 00 00                          ........
```

- `rsi`: end of numbers

```asm
bomb[0x401158] <+100>: movq   %r14, %rax
```

- `rax = r14`: restore rsp

```asm
bomb[0x40115b] <+103>: movl   $0x7, %ecx
bomb[0x401160] <+108>: movl   %ecx, %edx
bomb[0x401162] <+110>: subl   (%rax), %edx
bomb[0x401164] <+112>: movl   %edx, (%rax)
```

- `rax = 7 - rax`: for descending

```asm
bomb[0x401166] <+114>: addq   $0x4, %rax
bomb[0x40116a] <+118>: cmpq   %rsi, %rax
bomb[0x40116d] <+121>: jne    0x401160       ; <+108>
```

- Convert all 6 numbers

```asm
(lldb) x/d -c6 $rsp
0x7fffffffe150: 3
0x7fffffffe154: 4
0x7fffffffe158: 5
0x7fffffffe15c: 6
0x7fffffffe160: 1
0x7fffffffe164: 2
```

### Create a linked list

```asm
bomb[0x40116f] <+123>: movl   $0x0, %esi
bomb[0x401174] <+128>: jmp    0x401197       ; <+163>
bomb[0x401176] <+130>: movq   0x8(%rdx), %rdx
bomb[0x40117a] <+134>: addl   $0x1, %eax
bomb[0x40117d] <+137>: cmpl   %ecx, %eax
bomb[0x40117f] <+139>: jne    0x401176       ; <+130>
bomb[0x401181] <+141>: jmp    0x401188       ; <+148>
bomb[0x401183] <+143>: movl   $0x6032d0, %edx ; imm = 0x6032D0
bomb[0x401188] <+148>: movq   %rdx, 0x20(%rsp,%rsi,2)
bomb[0x40118d] <+153>: addq   $0x4, %rsi
bomb[0x401191] <+157>: cmpq   $0x18, %rsi
bomb[0x401195] <+161>: je     0x4011ab       ; <+183>
bomb[0x401197] <+163>: movl   (%rsp,%rsi), %ecx
bomb[0x40119a] <+166>: cmpl   $0x1, %ecx
bomb[0x40119d] <+169>: jle    0x401183       ; <+143>
bomb[0x40119f] <+171>: movl   $0x1, %eax
bomb[0x4011a4] <+176>: movl   $0x6032d0, %edx ; imm = 0x6032D0
bomb[0x4011a9] <+181>: jmp    0x401176       ; <+130>
```

- `<+123>`: `esi = 0`
- `<+163>`: `ecx = rsp + rsi` (3 = 3 + 0)
- `<+166>`: `ecx >= 1`. if normal node
- `<+171>`: `eax = 1`
- `<+176>`: `edx = 0x6032d0`. node1

```asm
(lldb) x -c88 0x6032d0
0x006032d0: 4c 01 00 00 01 00 00 00 e0 32 60 00 00 00 00 00  L........2`.....
0x006032e0: a8 00 00 00 02 00 00 00 f0 32 60 00 00 00 00 00  .........2`.....
0x006032f0: 9c 03 00 00 03 00 00 00 00 33 60 00 00 00 00 00  .........3`.....
0x00603300: b3 02 00 00 04 00 00 00 10 33 60 00 00 00 00 00  .........3`.....
0x00603310: dd 01 00 00 05 00 00 00 20 33 60 00 00 00 00 00  ........ 3`.....
0x00603320: bb 01 00 00 06 00 00 00                          ........
```

Search Node:

- `<+130>`: `edx` = next node
- `<+134>`: `eax += 1`. next index
- `<+137>`: `ecx == eax`. find node

Find Node3:

- `<+141>`: Jump to `<+148>`
- `<+148>`: save `edx` (node3) to `rsi` (0) index node

```asm
(lldb) x -c48 '$rsp + 0 * 2 + 0x20'
(lldb) x -c48 '$rsp + 32'

0x7fffffffe170: f0 32 60 00 00 00 00 00 00 33 60 00 00 00 00 00  .2`......3`.....
0x7fffffffe180: 10 33 60 00 00 00 00 00 20 33 60 00 00 00 00 00  .3`..... 3`.....
0x7fffffffe190: d0 32 60 00 00 00 00 00 e0 32 60 00 00 00 00 00  .2`......2`.....
```

- `<+153>`: `rsi += 4`. next index
- `<+157>`: `rsi == 24`. loop ended
- `<+163>`: `ecx = rsp + rsi`: next number

### Connect a linked list

```asm
bomb[0x4011ab] <+183>: movq   0x20(%rsp), %rbx
bomb[0x4011b0] <+188>: leaq   0x28(%rsp), %rax
bomb[0x4011b5] <+193>: leaq   0x50(%rsp), %rsi
```

- `rbx`: current node
- `rax`: second node
- `rsi`: tail node

```asm
bomb[0x4011ba] <+198>: movq   %rbx, %rcx
bomb[0x4011bd] <+201>: movq   (%rax), %rdx
bomb[0x4011c0] <+204>: movq   %rdx, 0x8(%rcx)
```

- `rcx`: current node address
- `rdx`: next node address
- `rcx + 8 = rdx`: current node's next pointer = next node address

```asm
bomb[0x4011c4] <+208>: addq   $0x8, %rax
bomb[0x4011c8] <+212>: cmpq   %rsi, %rax
bomb[0x4011cb] <+215>: je     0x4011d2       ; <+222>
bomb[0x4011cd] <+217>: movq   %rdx, %rcx
bomb[0x4011d0] <+220>: jmp    0x4011bd       ; <+201>
bomb[0x4011d2] <+222>: movq   $0x0, 0x8(%rdx)
```

- `rax += 8`: next node
- until tail node
- `rcx`: next node address
- loop
- end of a list

```asm
(lldb) x -c96 0x6032d0
0x006032d0: 4c 01 00 00 01 00 00 00 e0 32 60 00 00 00 00 00  L........2`.....
0x006032e0: a8 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00  ................
0x006032f0: 9c 03 00 00 03 00 00 00 00 33 60 00 00 00 00 00  .........3`.....
0x00603300: b3 02 00 00 04 00 00 00 10 33 60 00 00 00 00 00  .........3`.....
0x00603310: dd 01 00 00 05 00 00 00 20 33 60 00 00 00 00 00  ........ 3`.....
0x00603320: bb 01 00 00 06 00 00 00 d0 32 60 00 00 00 00 00  .........2`.....
```

```asm
(lldb) x -c48 $rbx
0x006032f0: 9c 03 00 00 03 00 00 00 00 33 60 00 00 00 00 00  .........3`.....
0x00603300: b3 02 00 00 04 00 00 00 10 33 60 00 00 00 00 00  .........3`.....
0x00603310: dd 01 00 00 05 00 00 00 20 33 60 00 00 00 00 00  ........ 3`.....
```

- `0x20(%rsp)`: 3
- `rbx`: `0x20(%rsp)`
- `0x6032f0` is head node

### Validate a linked list

```asm
bomb[0x4011da] <+230>: movl   $0x5, %ebp
bomb[0x4011df] <+235>: movq   0x8(%rbx), %rax
bomb[0x4011e3] <+239>: movl   (%rax), %eax
bomb[0x4011e5] <+241>: cmpl   %eax, (%rbx)
bomb[0x4011e7] <+243>: jge    0x4011ee       ; <+250>
bomb[0x4011e9] <+245>: callq  0x40143a       ; explode_bomb
bomb[0x4011ee] <+250>: movq   0x8(%rbx), %rbx
bomb[0x4011f2] <+254>: subl   $0x1, %ebp
bomb[0x4011f5] <+257>: jne    0x4011df       ; <+235>
```

- `ebp = 5`
- `rbx`: current node address
- `rax`: next node address
- `current >= next`: ok
- `rbx += 8`
- `ebp -= 1`
- `ebp == 0`: loop ended

### Epilogue

```asm
bomb[0x4011f7] <+259>: addq   $0x50, %rsp
bomb[0x4011fb] <+263>: popq   %rbx
bomb[0x4011fc] <+264>: popq   %rbp
bomb[0x4011fd] <+265>: popq   %r12
bomb[0x4011ff] <+267>: popq   %r13
bomb[0x401201] <+269>: popq   %r14
bomb[0x401203] <+271>: retq
```

---

## Answer

```asm
4 3 2 1 6 5
```

