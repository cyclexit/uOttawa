package employer

import "matching/person"

// Employer is a struct to represent employers
type Employer struct {
	p   *person.Person
	cur int64
}

// NewEmployer is the constructor of Employer struct
func NewEmployer(p *person.Person) *Employer {
	return &Employer{p, 0}
}

func (e *Employer) GetCurrent() string {
	name := e.p.GetPref(e.cur)
	e.cur++
	return name
}
