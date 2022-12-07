import java.nio.file.Files
import java.nio.file.Paths
import java.util.Stack
import kotlin.math.min

data class MetaData(var path: String, var size: Int)

fun parseBlock(command: List<String>, path: String): MetaData {
    val op = command[0].split(" ")[1] //remove dollar sign
    val body = command.slice(1 until command.size)
    var newPath = ""
    var size = 0
    when(op) {
        "cd" ->
            newPath = if (command[0].split(" ")[2] == "..") {
                ".."
            } else {
                if (command[0].split(" ")[2] == "/") {
                    "/"
                } else {
                    path + "/" + command[0].split(" ")[2]
                }
            }
        "ls" ->
            for (item in body) {
                if (item.split(" ")[0] == "dir") continue
                size += item.split(" ")[0].toInt()
            }
    }
    return MetaData(newPath, size)
}

fun updatePointer(pointer: Int, lineas: List<String>): Int {
    var newPointer = pointer
    while(newPointer + 1 < lineas.size && lineas[newPointer + 1].split(" ")[0] != "$") {
        newPointer += 1
    }
    return newPointer
}

fun main() {
    val lines = Files.readAllLines(Paths.get("src/main/resources/input.txt"))
    val sizeTreshold = 100000

    //hashmap with sizes each directory has
    var sizes = HashMap<String, Int>()
    var dirStack = Stack<String>()
    //directories visited but not exited
    var visited = ArrayList<String>()

    var pointer = 0
    //auxiliar pointer
    var auxPointer = 0

    while(pointer < lines.size) {
        auxPointer = updatePointer(pointer, lines)
        val block = lines.slice(pointer..auxPointer)
        pointer = auxPointer + 1
        val actualPath = if (dirStack.isEmpty()) "" else dirStack.peek()
        val (path, size) = parseBlock(block, actualPath)
        if (!path.isNullOrBlank()) {
            if (path == "..") {
                val pathCompleted = dirStack.pop()
                visited.remove(pathCompleted)
            }
            else {
                dirStack.push(path)
                visited.add(path)
            }
        }
        for (path in visited) {
            sizes[path] = sizes[path]?.plus(size) ?: size
        }

    }

    var total = 0
    sizes.forEach { (key, value) -> if (value < sizeTreshold) total += value }

    println(total)

    //Part 2
    val maxSpace = 70000000
    val limitSpace = 30000000
    val occupiedSpace = sizes["/"]
    val freeSpace = maxSpace - occupiedSpace!!
    val necessarySpace = limitSpace - freeSpace

    var minSpace = maxSpace

    for (i in 0 until sizes.size) {
        val (_, value) = sizes.toList()[i]
        if (value >= necessarySpace && value < minSpace) {
            minSpace = value
        }
    }

    println(minSpace)


}