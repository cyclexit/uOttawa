package main

import (
	"bufio"
	"os"
	"sync"
	"fmt"
	"strings"
	. "person"
	. "employer"
	. "student"
)

func offer(e *Employer) {
	if e.P.Match == -1 {
		curStudent := sMap[e.GetCurrent()]
		evaluate(e, curStudent)
	}
}

func evaluate(e *Employer, s *Student) {
	if s.P.Match == -1 {
		s.P.ChangeMatch(e.P.Name)
		e.P.ChangeMatch(s.P.Name)
	} else if (s.Prefer(s.P.Name)) {
		prevEmp := eMap[s.P.Pref[s.P.Match]]
		prevEmp.P.Unmatch()
		s.P.ChangeMatch(e.P.Name)
		e.P.ChangeMatch(s.P.Name)
		wg.Add(1)
		go func() {
			defer wg.Done()
			offer(prevEmp)
		}()
	} else {
		offer(e)
	}
}

// employer map
var eMap = make(map[string]*Employer)
// student map
var sMap = make(map[string]*Student)
// wait group
var wg sync.WaitGroup

func main() {
	// array to hold employers
	employers := make([]*Employer, 0)

	// read employers' preferences
	eFile, err := os.Open(os.Args[1])
	defer eFile.Close()
	if err != nil {
		panic(err)
	}
	eScanner := bufio.NewScanner(eFile)
	for eScanner.Scan() {
		info := strings.Split(eScanner.Text(), ",")
		e := NewEmployer(NewPerson(info[0], info[1:]))
		employers = append(employers, e)
		eMap[info[0]] = e
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
		s := NewStudent(NewPerson(info[0], info[1:]))
		sMap[info[0]] = s
	}
	if eScanner.Err() != nil {
		panic(eScanner.Err())
	}

	// McVitie-Wilson algorithm
	for i := 0; i < len(employers); i++ {
		index := i
		wg.Add(1)
		go func() {
			defer wg.Done()
			offer(employers[index])
		}()
	}
	wg.Wait()
	
	// print the result 
	for i := 0; i < len(employers); i++ {
		ep := employers[i].P
		fmt.Println(ep.Name + "," + ep.Pref[ep.Match])
	}
}
