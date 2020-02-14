package person

// Person is a struct to represent a person
type Person struct {
	Name  string
	Pref  []string
	Match int64
}

// NewPerson is the constructor of Person struct
func NewPerson(name string, pref []string) *Person {
	return &Person{name, pref, -1}
}

func (p *Person) ChangeMatch(name string) {
	for i := 0; i < len(p.Pref); i++ {
		if p.Pref[i] == name {
			p.Match = int64(i)
			break
		}
	}
}

func (p *Person) Unmatch() {
	p.Match = -1
}