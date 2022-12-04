package main

import (
	"fmt"
	"bufio"
	"os"
    "strings"
)

func checkSameLetter(a string, b string) string {
    for i := 0; i < len(a); i++ {
        if strings.Contains(b, string(a[i])) {
            return string(a[i])
        }
    }
    return ""
}

func checkSameLetterThree(a string, b string, c string) string {
    for i := 0; i < len(a); i++ {
        if strings.Contains(b, string(a[i])) && strings.Contains(c, string(a[i])) {
            return string(a[i])
        }
    }
    return ""
}

func main() {
    readFile, err := os.Open("Day 3/Dani/input.txt")
  
    if err != nil {
        fmt.Println(err)
    }
    fileScanner := bufio.NewScanner(readFile)
    fileScanner.Split(bufio.ScanLines)
    var fileLines []string
  
    for fileScanner.Scan() {
        fileLines = append(fileLines, fileScanner.Text())
    }
  
    readFile.Close()

    //declare void map[string]int
	priorities := make(map[string]int)
	//set priorities from [a-z] to 1-26 and from [A-Z] to 27-52
	for i := 0; i < 26; i++ {
		priorities[string(i+97)] = i+1
		priorities[string(i+65)] = i+27
	}

    result := 0

    for _, line := range fileLines {
        half1 := line[:len(line)/2]
        half2 := line[len(line)/2:]
        letter := checkSameLetter(half1, half2)
        result += priorities[letter]
    }

    fmt.Println(result)

    //Part 2
    result2 := 0
    for i := 0; i < len(fileLines); i += 3 {
        letter := checkSameLetterThree(fileLines[i], fileLines[i+1], fileLines[i+2])
        result2 += priorities[letter]
    }

    fmt.Println(result2)
}



