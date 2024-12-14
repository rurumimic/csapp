# in C

## Format

```bash
find . -iname '*.h' -o -iname '*.c' | xargs clang-format -i
```

---

## Phases

### Phase 2

```bash
make
./phase_2 "1 2 4 8 16 32"
```

```bash
Phase 2
Your Inputs: '1 2 4 8 16 32'
Six Numbers:  1 2 4 8 16 32
Numbers len:  6
Solution: 1 2 4 8 16 32
```

### Phase 4

```bash
make
./phase_4 "1 0"
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

