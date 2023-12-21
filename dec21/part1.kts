import java.io.File

typealias Pos = Pair<Int, Int>
typealias Field = ArrayList<MutableList<Char>>

val input = File(args[0])

fun readInput(inputFile: File): Pair<Field, Pos> {
    val field = Field()
    var start = Pos(-1, -1)

    input.readLines().forEachIndexed { row, line ->
        val nextLine = mutableListOf<Char>()
        line.forEachIndexed { col, char ->
            nextLine.add(char)
            if (char == 'S') {
                start = Pos(row, col)
            }
        }
        if (nextLine.size > 0) {
            field.add(nextLine)
        }
    }

    return Pair(field, start)
}

fun generateNeighbors(pos: Pos) = sequence {
    val (x, y) = pos
    yield(Pos(x - 1, y))
    yield(Pos(x + 1, y))
    yield(Pos(x, y - 1))
    yield(Pos(x, y + 1))
}

fun Field.isOpen(pos: Pos) : Boolean {
    val (row, col) = pos
    return (row >= 0 && row < height && col >= 0 && col < width && field[row][col] != '#')
}

fun findNext(frontier: MutableSet<Pos>, visited: Set<Pos>, field: Field): MutableSet<Pos> {
    val ret = mutableSetOf<Pos>()
    for (pos in frontier) {
        for (neighbor in generateNeighbors(pos)) {
            if (!visited.contains(neighbor) && field.isOpen(neighbor)) {
                ret.add(neighbor)
            }
        }
    }

    return ret
}

val (field, start) = readInput(input)
val height = field.size
val width = field[0].size
var currentDist = 0
var frontier = mutableSetOf(start)
var lastFrontier = mutableSetOf<Pos>()
var evenDist = 1

while (frontier.size > 0) {
    val nextFrontier = findNext(frontier, lastFrontier, field)
    ++currentDist
    if (currentDist %2 == 1){
       evenDist += nextFrontier.size
    }
    lastFrontier = frontier
    frontier = nextFrontier

}

println(evenDist)
