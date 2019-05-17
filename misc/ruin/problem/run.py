#!/usr/bin/env python3.5
import sys
import os
import binascii
import subprocess
import random
import re
import signal

from flag import flag

cmpl = 'rustc %s'

TIMEOUT = 20
SIZE = 1000
prefix_size = 0x100000
pow_difficulty = 24


def gen_filename():
    tmp = '/tmp/'
    return tmp + binascii.hexlify(os.urandom(16)).decode('ascii') + '.rs'

def proof_of_work():
    prefix = hex(random.randint(0, prefix_size))[2:]
    print('$ npm install -g proof-of-work')
    print('$ proof-of-work {} {}'.format(prefix, pow_difficulty))
    s = input()
    if len(s) != 32:
        return False
    if re.match('^[0-9a-f]+$', s) is None:
        return False
    cmd = 'proof-of-work verify {} {} {}'.format(prefix, pow_difficulty, s)
    try:
        subprocess.check_call(cmd.split(' '))
    except:
        return False
    return True


def main():
    signal.alarm(40 + TIMEOUT)
    if not proof_of_work():
        print('proof of work fail')
        return

    print('input your source code size')
    size = int(input())
    if size > SIZE:
        print('too big')
        return
    if size <= 0:
        print('invalid size')
        return

    print('OK. Please input your code')
    code = sys.stdin.read(size)
    if '#' in code:
        print('You cannot contain \'#\' in your code')
        return
    filename = gen_filename()
    with open(filename, 'w') as f:
        f.write(code)

    # os.close(2)
    print('Nice! I\'ll compile your code')
    try:
        subprocess.check_call((cmpl % filename).split(' '), timeout=TIMEOUT)
    except subprocess.TimeoutExpired:
        print('Good job. The flag is {}'.format(flag))
    finally:
        os.remove(filename)

main()
