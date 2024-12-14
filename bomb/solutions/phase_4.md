# Phase 4

Run Debugger:

```bash
gdb ./bomb/bomb
lldb ./bomb/bomb
```

## Disassemble Phase 4

```asm
(gdb) disas phase_4
(lldb) di -n phase_4
```

### Prologue and 2 input values

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

#### Examine the string

```bash
(lldb) x/s 0x4025cf
0x004025cf: "%d %d"
```

### Check the range of 1st input value

```asm
bomb[0x40102e] <+34>: cmpl   $0xe, 0x8(%rsp)
bomb[0x401033] <+39>: jbe    0x40103a       ; <+46>
bomb[0x401035] <+41>: callq  0x40143a       ; explode_bomb
```

- `jbe` compares using unsigned logic. 
- `0 <= $rsp + 8 <= 14`

### Call func4

```asm
bomb[0x40103a] <+46>: movl   $0xe, %edx
bomb[0x40103f] <+51>: movl   $0x0, %esi
bomb[0x401044] <+56>: movl   0x8(%rsp), %edi
bomb[0x401048] <+60>: callq  0x400fce       ; func4
```

- `edx`: `14`
- `esi`: `0`
- `edi`: 1st input value

### After calling func4

```asm
bomb[0x401048] <+60>: callq  0x400fce       ; func4
bomb[0x40104d] <+65>: testl  %eax, %eax
bomb[0x40104f] <+67>: jne    0x401058       ; <+76>
bomb[0x401051] <+69>: cmpl   $0x0, 0xc(%rsp)
bomb[0x401056] <+74>: je     0x40105d       ; <+81>
bomb[0x401058] <+76>: callq  0x40143a       ; explode_bomb
bomb[0x40105d] <+81>: addq   $0x18, %rsp
bomb[0x401061] <+85>: retq
```

- `eax != 0`: explode bomb
- `eax == 0`
  - `2nd input != 0`: explod bomb
  - `2nd input == 0`: return `phase_4`

**2nd input value must be 0.**

---

## Disassemble func4

### Prologue

```asm
bomb`func4:
bomb[0x400fce] <+0>:  subq   $0x8, %rsp
```

### Parameters

```asm
bomb[0x400fd2] <+4>:  movl   %edx, %eax
bomb[0x400fd4] <+6>:  subl   %esi, %eax
bomb[0x400fd6] <+8>:  movl   %eax, %ecx
bomb[0x400fd8] <+10>: shrl   $0x1f, %ecx ; shift right logical
bomb[0x400fdb] <+13>: addl   %ecx, %eax
bomb[0x400fdd] <+15>: sarl   %eax        ; shift arithmetic right
bomb[0x400fdf] <+17>: leal   (%rax,%rsi), %ecx
```

1. `<+4 ~ +8>`: `ecx = eax = edx - esi`
1. `<+10>`: `ecx = sign bit` (`ecx >> 31`)
1. `<+13>`: `eax = sign + eax` (for negative floor division)
1. `<+15>`: `eax = eax >> 1` (preserve the sign bit)
1. `<+17>`: `ecx = rax + rsi * 1`

#### C code with the same logic

```c
int func4(int node, int low, int high) {
	int size = high - low;
	int sign = (size >> (sizeof (int) * 8 - 1) ) & 1; // 4bytes * 8bit - 1bit
	int mid = low + (size + sign) / 2; // for negative floor division
}
```

### Compares with the 1st value

- `edi`: 1st input
- `ecx`: mid

```asm
bomb[0x400fe2] <+20>: cmpl   %edi, %ecx
bomb[0x400fe4] <+22>: jle    0x400ff2       ; <+36>

bomb[0x400ff7] <+41>: cmpl   %edi, %ecx
bomb[0x400ff9] <+43>: jge    0x401007       ; <+57>

bomb[0x401007] <+57>: addq   $0x8, %rsp
bomb[0x40100b] <+61>: retq
```

1. `<+20>`: `1st >= mid`
   1. `<+41>`: `1st <= mid` (`1st == mid`)
      1. `<+57>`: return `func4`
   1. `<+45>`: `1st > mid`
1. `<+24>`: `1st < mid`

#### `1st == mid`

```asm
bomb[0x400fe2] <+20>: cmpl   %edi, %ecx
bomb[0x400fe4] <+22>: jle    0x400ff2       ; <+36>

bomb[0x400ff2] <+36>: movl   $0x0, %eax
bomb[0x400ff7] <+41>: cmpl   %edi, %ecx
bomb[0x400ff9] <+43>: jge    0x401007       ; <+57>

bomb[0x401007] <+57>: addq   $0x8, %rsp
bomb[0x40100b] <+61>: retq
```

1. `eax = 0`
1. return `0` 

#### `1st > mid`

`<+48>`: Call `func4` again

```asm
bomb[0x400fe2] <+20>: cmpl   %edi, %ecx
bomb[0x400fe4] <+22>: jle    0x400ff2       ; <+36>

bomb[0x400ff2] <+36>: movl   $0x0, %eax
bomb[0x400ff7] <+41>: cmpl   %edi, %ecx
bomb[0x400ff9] <+43>: jge    0x401007       ; <+57>
bomb[0x400ffb] <+45>: leal   0x1(%rcx), %esi
bomb[0x400ffe] <+48>: callq  0x400fce       ; <+0>
bomb[0x401003] <+53>: leal   0x1(%rax,%rax), %eax
bomb[0x401007] <+57>: addq   $0x8, %rsp
bomb[0x40100b] <+61>: retq
```

- `edx`: `edx` (`high`)
- `esi`: `rcx + 1` (`rcx = mid`)
- `edi`: 1st input value

After calling `func4`:

- `eax = 2 * func4(1st, mid+1, high) + 1`
- return `eax`

#### `1st < mid`

`<+48>`: Call `func4` again

```asm
bomb[0x400fe2] <+20>: cmpl   %edi, %ecx
bomb[0x400fe4] <+22>: jle    0x400ff2       ; <+36>
bomb[0x400fe6] <+24>: leal   -0x1(%rcx), %edx
bomb[0x400fe9] <+27>: callq  0x400fce       ; <+0>
bomb[0x400fee] <+32>: addl   %eax, %eax
bomb[0x400ff0] <+34>: jmp    0x401007       ; <+57>

bomb[0x401007] <+57>: addq   $0x8, %rsp
bomb[0x40100b] <+61>: retq
```

- `edx`: `edx = rcx - 1` (`high = mid - 1`)
- `esi`: `esi` (`esi = low`)
- `edi`: 1st input value

After calling `func4`:

- `eax = 2 * func4(1st, low, mid - 1)`
- return `eax`

#### C code with the same logic

```c
if (node == mid) {
	return 0;
}

if (node < mid) {
	return 2 * func4(node, low, mid - 1);
} else {
	return 2 * func4(node, mid + 1, high) + 1; // +1 when moving right
}
```

---

## Answer

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

