#!/usr/bin/env python3.6
import sys
import os
import binascii

cmpl = 'rustc %s'

def gen_filename():
    tmp = '/tmp/'
    return tmp + binascii.hexlify(os.urandom(16)) + '.rs'

def proof_of_work():
    pass

def main():
    if not proof_of_work():
        return

    print('input your source code size')
    size = int(input())
    if size > 1000:
        print('too big')
        return
    if size <= 0:
        print('invalid size')
        return

    code = sys.stdin.read(size)
    filename = gen_filename()
    with open(filename, 'w') as f:
        f.write(code)

    # os.close(2)

    commands = [
            cmpl % filename,
            ]
    for command in commands:
        print(command)
        ret = os.system(command)
        if ret != 0:
            break

main()
