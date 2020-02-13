package student

import "matching/person"

// Student is a struct to represent students
type Student struct {
	p *person.Person
}

func NewStudent(p *person.Person) *Student {
	return &Student{p}
}

func (s *Student) prefer(name string) bool {
	index := s.p.GetIndex(name)
	return index < s.p.GetMatch()
}
