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

	var depthScans []int
	for scanner.Scan() {
		depth, _ := strconv.Atoi(scanner.Text())
		depthScans = append(depthScans, depth)
	}

	partOne(depthScans)
	partTwo(depthScans)
}

func partOne(depthScans []int) {
	var previousDepth int
	var numberOfDepthIncreases int
	for _, depth := range depthScans {
		if depth > previousDepth {
			numberOfDepthIncreases++
		}

		previousDepth = depth
	}

	fmt.Println(numberOfDepthIncreases)
}

func partTwo(depthScans []int) {
	var measurementWindows [][]int
	windowSize := 3

	for i := 0; i < len(depthScans); i++ {
		windowEnd := i + windowSize

		if windowEnd > len(depthScans) {
			break
		}

		measurementWindows = append(measurementWindows, depthScans[i:windowEnd])
	}

	var previousWindowDepth int
	var numberOfDepthIncreases int
	for _, window := range measurementWindows {
		var windowDepth int
		for _, depth := range window {
			windowDepth += depth
		}

		if windowDepth > previousWindowDepth {
			numberOfDepthIncreases++
		}

		previousWindowDepth = windowDepth
	}

	fmt.Println(numberOfDepthIncreases)
}
