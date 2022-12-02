open System
open System.IO

let mutable line = Console.ReadLine()
let mutable score = 0
let mutable score' = 0
let isValid = function null -> false | _ -> true
while (isValid line) do
    let first = match line.[0] with
                 | 'A' -> 1 // rock
                 | 'B' -> 2 // paper
                 | 'C' -> 3 // scissors
                 | _ -> 0

    // --- Part One ---
    let third = match line.[2] with
                 | 'X' -> 1 // rock
                 | 'Y' -> 2 // paper
                 | 'Z' -> 3 // scissors
                 | _ -> 0

    let outcome = ((first - third + 3) % 3)
    score <- score + third + match outcome with
                              | 0 -> 3 // draw
                              | 1 -> 0 // lose
                              | 2 -> 6 // win
                              | _ -> 0

    // --- Part Two ---
    let third' = match line.[2] with
                  | 'X' -> 2 // lose
                  | 'Y' -> 0 // draw
                  | 'Z' -> 1 // win
                  | _ -> 0

    let outcome = ((first + third' - 1) % 3) + 1
    score' <- score' + outcome + match third' with
                                  | 0 -> 3 // draw
                                  | 1 -> 6 // win
                                  | 2 -> 0 // lose
                                  | _ -> 0

    line <- Console.ReadLine()

printfn "%d" score
printfn "%d" score'
