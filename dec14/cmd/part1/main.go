package main

import (
	"dec14/internal/dec14"
	"fmt"
)

func main() {
	field := dec14.ReadInput("input.txt")

	dec14.TiltVertical(field, true)

	fmt.Println(dec14.CalculateLoad(field))
}
