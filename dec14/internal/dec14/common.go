package dec14

import (
	"log"
	"os"
	"strings"
)

func ite(selector bool, trueV int, falseV int) int {
	if selector {
		return trueV
	} else {
		return falseV
	}
}

func TiltVertical(field [][]byte, toNorth bool) {
	column_height := len(field)
	direction := ite(toNorth, 1, -1)

	for column := 0; column < len(field[0]); column++ {
		last_free := ite(toNorth, 0, column_height-1)

		for i := 0; i < column_height; i++ {
			row := ite(toNorth, i, column_height-i-1)
			place := field[row][column]
			switch place {
			case '.':
			case 'O':
				field[row][column] = '.'
				field[last_free][column] = 'O'
				last_free += direction
			case '#':
				last_free = row + direction
			}
		}
	}
}

func TiltHorizontal(field [][]byte, toWest bool) {
	row_length := len(field[0])
	direction := ite(toWest, 1, -1)

	for row := 0; row < len(field); row++ {
		last_free := ite(toWest, 0, row_length-1)

		for i := 0; i < row_length; i++ {
			column := ite(toWest, i, row_length-i-1)
			place := field[row][column]
			switch place {
			case '.':
			case 'O':
				field[row][column] = '.'
				field[row][last_free] = 'O'
				last_free += direction
			case '#':
				last_free = column + direction
			}
		}
	}
}

func CalculateLoad(field [][]byte) int {
	column_height := len(field)
	sum := 0

	for column := 0; column < len(field[0]); column++ {
		for row := 0; row < column_height; row++ {
			place := field[row][column]
			switch place {
			case 'O':
				sum += column_height - row
			case '.':
			case '#':
			}
		}
	}

	return sum
}

func ReadInput(file string) [][]byte {
	content, err := os.ReadFile(file)
	if err != nil {
		log.Fatal(err)
	}
	lines := strings.Split(string(content), "\n")
	column_height := len(lines) - 1

	field := make([][]byte, column_height)
	for i := 0; i < column_height; i++ {
		field[i] = []byte(lines[i])
	}

	return field
}
