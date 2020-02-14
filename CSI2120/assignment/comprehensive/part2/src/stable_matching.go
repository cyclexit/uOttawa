package main

import (
	"bufio"
	// "fmt"
	"os"
	"strings"
	"person"
	"employer"
	"student"
)

func main() {
	// array to hold employers
	employers := make([]*employer.Employer, 0)
	// array to hold unmatched employers
	unmatched := make([]*employer.Employer, 0)
	// employer map
	eMap := make(map[string]*employer.Employer)
	// student map
	sMap := make(map[string]*student.Student)

	// read employers' preferences
	eFile, err := os.Open(os.Args[1])
	defer eFile.Close()
	if err != nil {
		panic(err)
	}
	eScanner := bufio.NewScanner(eFile)
	for eScanner.Scan() {
		info := strings.Split(eScanner.Text(), ",")
		e := employer.NewEmployer(person.NewPerson(info[0], info[1:]))
		employers = append(employers, e)
		unmatched = append(unmatched, e)
		eMap[info[0]] = e
		/*
		fmt.Println(e.P.Name) // test
		for i := 0; i < len(e.P.Pref); i++ {
			fmt.Printf("%s ", e.P.Pref[i])
		}
		fmt.Println()
		*/
	}
	if eScanner.Err() != nil {
		panic(eScanner.Err())
	}
	// read students' preferences
	sFile, err := os.Open(os.Args[2])
	defer sFile.Close()
	if err != nil {
		panic(err)
	}
	sScanner := bufio.NewScanner(sFile)
	for sScanner.Scan() {
		info := strings.Split(sScanner.Text(), ",")
		s := student.NewStudent(person.NewPerson(info[0], info[1:]))
		sMap[info[0]] = s
		/*
		fmt.Println(s.P.Name) // test
		for i := 0; i < len(s.P.Pref); i++ {
			fmt.Printf("%s ", s.P.Pref[i])
		}
		fmt.Println()
		*/
	}
	if eScanner.Err() != nil {
		panic(eScanner.Err())
	}
}
