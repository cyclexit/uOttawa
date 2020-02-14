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