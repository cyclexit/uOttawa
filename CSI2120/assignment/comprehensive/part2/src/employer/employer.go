package employer

import "person"

// Employer is a struct to represent employers
type Employer struct {
	P   *person.Person
	Cur int64
}

// NewEmployer is the constructor of Employer struct
func NewEmployer(p *person.Person) *Employer {
	return &Employer{p, 0}
}

func (e *Employer) getCurrent() string {
	name := e.P.Pref[e.Cur]
	e.Cur++
	return name
}