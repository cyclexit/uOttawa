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



func main() {
  // ** Question 3a) define meal with Schnitzel and Pumpkin Pie
	m := Meal{ }

  // ** Question 3a) calculate total price
	m.Total = 

	m.printMeal()
}
