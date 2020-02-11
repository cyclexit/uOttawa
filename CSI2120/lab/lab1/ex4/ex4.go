package main

import (
	"fmt"
)

type info struct {
	NStudents int
	Professor string
	Avg float32
}

func main() {
	m := make(map[string]info)

	m["CSI2110"] = info{186, "Lang", 79.5}
	m["CSI2120"] = info{211, "Moura", 81}

	for k, v := range m {
		fmt.Printf("Course Code: %s\n", k)
		fmt.Printf("Number of students: %d\n", v.NStudents)
		fmt.Printf("Professor: %s\n", v.Professor)
		fmt.Printf("Average: %f\n\n", v.Avg)
	}
}