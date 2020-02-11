package main

import (
	"fmt"
)

type person struct {
	lastName  string
	firstName string
	iD        int
}

func inPerson(p *person, id int) (int, error) {
	var str string
	fmt.Scanf("%s", &str)
	p.lastName = str
	fmt.Scanf("%s", &str)
	p.firstName = str
	p.iD = id
	return id + 1, nil
}

func printPerson(p person) {
	fmt.Println("last name: " + p.lastName)
	fmt.Println("first name: " + p.firstName)
	fmt.Println("id:", p.iD)
}

func main() {
	nextID := 101
	for {
		var (
			p   person
			err error
		)
		nextID, err = inPerson(&p, nextID)
		if err != nil {
			fmt.Println("Invalid entry ... exiting")
			break
		}
		printPerson(p)
	}
}
