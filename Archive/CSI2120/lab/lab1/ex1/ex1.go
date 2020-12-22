package main

import (
	"fmt"
	"math"
)

func main() {
	var x float64
	fmt.Scanf("%f", &x)
	fmt.Printf("%f, %f\n", math.Floor(x), math.Ceil(x))
}