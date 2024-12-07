# phase_1

sub    $0x8,%rsp
mov    $0x402400,%esi
call   0x401338 <strings_not_equal>
test   %eax,%eax
je     0x400ef7 <phase_1+23>
call   0x40143a <explode_bomb>
add    $0x8,%rsp
ret

