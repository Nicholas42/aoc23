package dec14

import (
	"hash/fnv"
)

func hashField(field [][]byte) int {
	h := fnv.New32a()
	for _, row := range field {
		h.Write(row)
	}

	return int(h.Sum32())
}

func Cycle(field [][]byte) {
	TiltVertical(field, true)
	TiltHorizontal(field, true)
	TiltVertical(field, false)
	TiltHorizontal(field, false)
}

func DetectCycle(field [][]byte) (int, int) {
	hashes := make([]int, 0)

	cycle_detected := 0

	for cycle_detected == 0 {
		Cycle(field)
		hash := hashField(field)
		for index, prev_hash := range hashes {
			if prev_hash == hash {
				cycle_detected = len(hashes) - index
				break
			}
		}

		if cycle_detected > 0 {
			break
		}
		hashes = append(hashes, hash)
	}

	return cycle_detected, len(hashes)
}
