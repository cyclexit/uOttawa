package main

import (
	"fmt"
	"strings"
)

func main() {
	lineWidth := 5
	symb := "x"
	lineSymb := symb
	// here
	for i := 0; i < 5; i++ {
		formatStr := fmt.Sprintf("%%%ds\n", lineWidth)
		fmt.Printf(formatStr, lineSymb)
		lineSymb += "x"
	}
	for i := 1; i < 5; i++ {
		lineSymb := strings.Repeat("x", 5-i)
		formatStr := fmt.Sprintf("%%%ds\n", lineWidth)
		fmt.Printf(formatStr, lineSymb)
	}
	// formatStr := fmt.Sprintf("%%%ds\n", lineWidth)
	// fmt.Printf(formatStr, lineSymb)
}
