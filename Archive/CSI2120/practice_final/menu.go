package main

import "fmt"

type Desert struct {
	Name  string
	Price float32
}

type MainCourse struct {
	Name  string
	Price float32
}

type Meal struct {
	MainCourse
	Desert
	Total float32
}

// ** Question 3a) supply printMeal function
func (m Meal) printMeal() {
	fmt.Printf("Main: %s at %.2f\n", m.MainCourse.Name, m.MainCourse.Price)
	fmt.Printf("Desert: %s at %.2f\n", m.Desert.Name, m.Desert.Price)
	fmt.Printf("Total: %.2f\n", m.Total)
}

func main() {
	// ** Question 3a) define meal with Schnitzel and Pumpkin Pie
	m := Meal{MainCourse{"Schnitzel", 15.50}, Desert{"Pumpkin Pie", 5.60}, 0.0}

	// ** Question 3a) calculate total price
	m.Total = m.MainCourse.Price + m.Desert.Price

	m.printMeal()
}
