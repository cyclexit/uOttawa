package person

// Person is a struct to represent a person
type Person struct {
	name  string
	pref  []string
	match int64
}

// NewPerson is the constructor of Person struct
func NewPerson(name string, pref []string) *Person {
	return &Person{name, pref, -1}
}

func (p *Person) GetMatchedName() string {
	if p.match == -1 {
		return "" // unmacthed
	}
	return p.pref[p.match]
}

func (p *Person) ChangeMatch(name string) {
	if name == "" {
		p.match = -1 // change to the unmatched state
	} else {
		for i := 0; i < len(p.pref); i++ {
			if p.pref[i] == name {
				p.match = int64(i)
				break
			}
		}
	}
}

func (p *Person) GetMatch() int64 {
	return p.match
}

func (p *Person) GetPref(i int64) string {
	return p.pref[i]
}

func (p *Person) GetIndex(name string) int64 {
	for i := 0; i < len(p.pref); i++ {
		if p.pref[i] == name {
			return int64(i)
		}
	}
	return int64(-1)
}
