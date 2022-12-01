import java.nio.file.Files
import java.nio.file.Paths

fun main(args: Array<String>) {
    val lineas = Files.readAllLines(Paths.get("src/main/resources/input.txt"))

    var sumas = arrayListOf<Int>()
    var par = 0
    for (caloria in lineas) {
        if (!caloria.equals("")) {
            par += Integer.parseInt(caloria)
        }
        else {
            sumas.add(par)
            par = 0
        }
    }

    println(sumas.max())

    //Parte 2
    sumas.sort()
    println(sumas[sumas.size - 1] + sumas[sumas.size - 2] + sumas[sumas.size - 3])
}