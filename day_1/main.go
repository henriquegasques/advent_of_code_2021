package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
)

func main() {
	file, err := os.Open("input.txt")
	defer file.Close()

	if err != nil {
		log.Fatalf("failed opening file: %s", err)
	}

	scanner := bufio.NewScanner(file)
	scanner.Split(bufio.ScanLines)

	var inputLines []string
	for scanner.Scan() {
		inputLines = append(inputLines, scanner.Text())
	}

	var previousDepth int
	numberOfDepthIncreases := 0
	for _, line := range inputLines {
		depth, err := strconv.Atoi(line)

		if err != nil {
			panic(err)
		}

		if depth > previousDepth {
			numberOfDepthIncreases++
		}

		previousDepth = depth
	}

	fmt.Println(numberOfDepthIncreases)
}
