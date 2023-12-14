package main

import (
	"dec14/internal/dec14"
	"fmt"
)

func main() {
	field := dec14.ReadInput("input.txt")

	cycle, current_offset := dec14.DetectCycle(field)

	offset := (1000000000-current_offset)%cycle - 1

	for i := 0; i < offset; i++ {
		dec14.Cycle(field)
	}

	fmt.Println(dec14.CalculateLoad(field))
}
