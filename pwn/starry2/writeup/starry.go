package main

import (
	"bufio"
	"fmt"
	"os"
)

var jumps map[int]int
var stack []int
var pc = 0

const (
	DUP = iota
	SWAP
	ROTATE
	POP
	PUSH
	ADD
	SUB
	MUL
	DIV
	MOD
	PNUM
	PCHAR
	RNUM
	RCHAR
	CJUMP
)

type Type int

type Inst struct {
	t Type
	v int
}

func abort() {
	panic("bye.")
}
func pop() int {
	if len(stack) == 0 {
		abort()
	}
	ret := stack[len(stack)-1]
	stack = stack[:len(stack)-1]
	return ret
}
func push(x int) {
	stack = append(stack, x)
}
func run(inst Inst) {
	t := inst.t
	val := inst.v
	switch t {
	case DUP:
		v := pop()
		push(v)
		push(v)
	case SWAP:
		x := pop()
		y := pop()
		push(x)
		push(y)
	case ROTATE:
		x := pop()
		y := pop()
		z := pop()
		push(x)
		push(z)
		push(y)
	case POP:
		pop()
	case PUSH:
		push(val)
	case ADD:
		y := pop()
		x := pop()
		push(x + y)
	case SUB:
		y := pop()
		x := pop()
		push(x - y)
	case MUL:
		y := pop()
		x := pop()
		push(x * y)
	case DIV:
		y := pop()
		x := pop()
		push(x / y)
	case MOD:
		y := pop()
		x := pop()
		push(x % y)
	case PNUM:
		fmt.Printf("%d", pop())
	case PCHAR:
		ch := rune(pop() % 256)
		fmt.Printf("%c", ch)
	case CJUMP:
		c := pop()
		if c != 0 {
			pc = jumps[val]
		}
	case RNUM:
		fallthrough
	case RCHAR:
		panic("sorry not implemented")
	default:
		panic("oops")
	}
}

func parse(s string) []Inst {
	count := 0
	result := make([]Inst, 0, 100)
	for _, c := range s {
		switch c {
		case ' ':
			count++
		case '+':
			switch count {
			case 0:
				panic("invalid")
			case 1:
				result = append(result, Inst{DUP, 0})
			case 2:
				result = append(result, Inst{SWAP, 0})
			case 3:
				result = append(result, Inst{ROTATE, 0})
			case 4:
				result = append(result, Inst{POP, 0})
			default:
				n := count - 5
				result = append(result, Inst{PUSH, n})
			}
			count = 0
		case '*':
			n := count % 5
			switch n {
			case 0:
				result = append(result, Inst{ADD, 0})
			case 1:
				result = append(result, Inst{SUB, 0})
			case 2:
				result = append(result, Inst{MUL, 0})
			case 3:
				result = append(result, Inst{DIV, 0})
			case 4:
				result = append(result, Inst{MOD, 0})
			}
			count = 0
		case ',':
			n := count % 2
			switch n {
			case 0:
				result = append(result, Inst{RNUM, 0})
			case 1:
				result = append(result, Inst{RCHAR, 0})
			}
			count = 0
		case '.':
			n := count % 2
			switch n {
			case 0:
				result = append(result, Inst{PNUM, 0})
			case 1:
				result = append(result, Inst{PCHAR, 0})
			}
			count = 0
		case '`':
			jumps[count] = len(result) - 1
			count = 0
		case '\'':
			result = append(result, Inst{CJUMP, count})
			count = 0
		}
	}
	return result
}

const flag = "              + +  *        +     * +   .      + +  *     +     * * +   .        + +  *        +     * * +   .       + +  *     +     * * +   .         + +  *      +     *     * +   .        + +  *          +     * * +   .            + +  *         +     *     * +   .        + +  *           +     * * +   .      + +  *       +     *     * +   .     + +  *     +     * * +   .       + +  *     +     * * +   .            + +  *                   +     * * +   .        + +  *        +     * * +   .            + +  *        +     *     * +   .         + +  *         +     *     * +   .      + +  *       +     * * +   .        + +  *         +     *     * +   .        + +  *         +     * * +   .             + +  *          +     * * +   .             + +  *              +     *     * +   .        + +  *      +     *     * +   .              + +  *       +     * * +   .           + +  *     +     *     * +   .      + +  *     +     *     * +   .        + +  *     +     *     * +   .        + +  *     +     * * +   .      + +  *       +     * * +   .         + +  *           +     * * +   .        + +  *        +     * * +   .              + +  *        +     *     * +   .        + +  *        +     * * +   .      + +  *       +     * * +   .        + +  *     +     *     * +   .             + +  *                   +     * * +   .          + +  *             +     *     * +   .        + +  *       +     *     * +   .       + +  *         +     *     * +   .         + +  *        +     * * +   .       + +  *         +     *     * +   .        + +  *     +     *     * +   .           + +  *       +     * * +   .        + +  *        +     * * +   .             + +  *      +     *     * +   .        + +  *         +     *     * +   .        + +  *      +     * * +   .             + +  *         +     * * +   .              + +  *        +     *     * +   .        + +  *        +     * * +   .      + +  *       +     * * +   .        + +  *     +     *     * +   .             + +  *                   +     * * +   .            + +  *          +     *     * +   .         + +  *      +     * * +   .      + +  *      +     *     * +   .       + +  *       +     * * +   .         + +  *        +     * * +   .             + +  *                     +     *     * +   .     + +  *     +     * * +   .     + +  *     +     * * +   .      + +  *     +     * * +   ."

func main() {
	jumps = make(map[int]int)
	stack = make([]int, 0, 100)
	insts := make([]Inst, 0, 100)

	// setup
	stack = append(stack, 1)
	insts = append(insts, Inst{CJUMP, -1})
	flagCode := parse(flag)
	insts = append(insts, flagCode...)
	jumps[-1] = len(insts) - 1

	fmt.Println("Hello. This is the STARRY MACHINE CHALLENGE REVENGE")
	fmt.Println("Please paste your beautiful code!")
	sc := bufio.NewScanner(os.Stdin)
	if !sc.Scan() {
		return
	}
	code := sc.Text()
	userCode := parse(code)
	insts = append(insts, userCode...)

	for {
		inst := insts[pc]
		run(inst)
		pc++
		if pc < 0 || pc >= len(insts) {
			break
		}
	}
}
