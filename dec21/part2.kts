import java.io.File
import java.time.LocalTime

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

fun Field.isOpen(pos: Pos): Boolean {
    val (row, col) = pos
    val effectiveRow = ((row % height) + height) % height
    val effectiveCol = ((col % width) + width) % width
    return field[effectiveRow][effectiveCol] != '#'
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

fun <S, T : Number> List<S>.prodOf(func: (S) -> T): Double {
    var result = 1.0
    forEach { v -> result *= func(v).toDouble() }
    return result
}

fun lagrange(x: Int, points: List<Pos>): Double = points.sumOf { (x0, y0) ->
    val numerator = points.prodOf { (xn, _) ->
        if (x0 == xn) {
            1
        } else {
            x - xn
        }
    }
    val denominator = points.prodOf { (xn, _) ->
        if (x0 == xn) {
            1
        } else {
            x0 - xn
        }
    }
    numerator / denominator * y0
}

val (field, start) = readInput(input)
val height = field.size
val width = field[0].size
var currentDist = 0
var frontier = mutableSetOf(start)
var lastFrontier = mutableSetOf<Pos>()
val steps = 10 * width
var lastTime = LocalTime.now()
var reachable = 0

val offsetDistances = mutableListOf<Pos>()
val maxSteps = 26501365
val offset = maxSteps % width


while (frontier.size > 0 && currentDist <= steps) {
    val nextFrontier = findNext(frontier, lastFrontier, field)
    ++currentDist
    if (currentDist % 2 == 1) {
        reachable += nextFrontier.size
        if (currentDist % width == offset) {
            offsetDistances.add(Pos(currentDist, reachable))
        }
    }
    lastFrontier = frontier
    frontier = nextFrontier
}


val interpolates = offsetDistances.windowed(3).map { window ->
    lagrange(maxSteps, window)
}

println(interpolates.distinct().single().toLong())
