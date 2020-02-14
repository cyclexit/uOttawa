package main

import (
	"bufio"
	"fmt"
	"os"
)

func main() {
	// employers
	// read employer preference
	eFile, err := os.Open(os.Args[1])
	defer eFile.Close()
	if err != nil {
		panic(err)
	}
	eScanner := bufio.NewScanner(eFile)
	for eScanner.Scan() {
		fmt.Println(eScanner.Text()) // test
	}
	if eScanner.Err() != nil {
		panic(eScanner.Err())
	}

}
