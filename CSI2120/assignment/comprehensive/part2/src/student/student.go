package student

import "person"

// Student is a struct to represent students
type Student struct {
	P *person.Person
}

// NewStudent is the constructor of Student struct
func NewStudent(p *person.Person) *Student {
	return &Student{p}
}

func (s *Student) Prefer(name string) bool {
	var index int64
	for i := 0; i < len(s.P.Pref); i++ {
		if s.P.Pref[i] == name {
			index = int64(i)
		}
	}
	return index < s.P.Match
}
