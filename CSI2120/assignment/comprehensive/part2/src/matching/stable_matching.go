package main

import (
	"bufio"
	"fmt"
	"os"
)

func main() {
	// read employer preference
	file, err := os.Open(os.Args[0])
	defer file.Close()
	if err != nil {
		panic(err)
	}
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		info := scanner.Text()
		fmt.Println(string(info))
	}
}
