package main

import (
	"fmt"
	"math"
)

var resChanel = make(chan float64)
var (
	ch1 = make(chan float64)
	ch2 = make(chan float64)
	ch3 = make(chan float64)
)

func z1(x1 float64, x2 float64) {
	var temp float64 = (0.1 + 0.3*x1 + 0.4*x2)
	ch1 <- float64(1 / (1 + math.Exp(-temp)))
}

func z2(x1 float64, x2 float64) {
	var temp float64 = (0.5 + 0.8*x1 + 0.3*x2)
	ch2 <- float64(1 / (1 + math.Exp(-temp)))
}

func z3(x1 float64, x2 float64) {
	var temp float64 = (0.7 + 0.6*x1 + 0.6*x2)
	ch3 <- float64(1 / (1 + math.Exp(-temp)))
}

func t1(z1 float64, z2 float64, z3 float64) {
	var temp float64 = (0.5 + 0.3*z1 + 0.7*z2 + 0.1*z3)
	resChanel <- float64(1 / (1 + math.Exp(-temp)))
}

func main() {
	var n int
	fmt.Scanf("%d", &n)
	for i := 1; i <= n; i++ {
		x1 := math.Sin(2 * math.Pi * float64(i-1) / float64(n))
		x2 := math.Cos(2 * math.Pi * float64(i-1) / float64(n))
		go z1(x1, x2)
		go z2(x1, x2)
		go z3(x1, x2)
		go t1(<-ch1, <-ch2, <-ch3)
		// fmt.Println(x1, x2)
		fmt.Printf("The result when k = %d is %f\n", i, <-resChanel)
	}
}
