package main

import (
	"fmt"
	"strings"
	"time"
)

type Category struct {
	name string // seat type
	base float32
}

func NewCategory(name string, base float32) *Category {
	return &Category{name, base}
}

func NewDefaultCategory() *Category {
	return &Category{standard, 25.0}
}

type Seat struct {
	number int32 // which seat on the row
	row    int32
	cat    *Category
}

func NewSeat(number int32, row int32, cat *Category) *Seat {
	return &Seat{number, row, cat}
}

func NewDefaultSeat() *Seat {
	return &Seat{1, 1, NewDefaultCategory()}
}

type Ticket struct {
	customer string
	seat     *Seat
	show     *Show
}

func NewTicket(customer string, seat *Seat, show *Show) *Ticket {
	return &Ticket{customer, seat, show}
}

func (t *Ticket) print() {
	fmt.Println("**This is your ticket**")
	fmt.Println("Show:", (*t.show).getName())
	fmt.Println("Start time:", (*t.show).getShowStart())
	fmt.Println("End time:", (*t.show).getShowEnd())
	fmt.Println("Customer:", t.customer)
	fmt.Printf("%s seat: row %d, number %d\n", t.seat.cat.name, t.seat.row, t.seat.number)
	fmt.Println("Price:", t.seat.cat.base)
	fmt.Println("***********************")
}

type Play struct {
	name      string
	purchased []Ticket
	showStart time.Time
	showEnd   time.Time
}

type Show interface {
	getName() string
	getShowStart() time.Time
	getShowEnd() time.Time
	addPurchase(*Ticket) bool
	isNotPurchased(*Ticket) bool
}

type Comedy struct {
	laughs float32
	deaths int32
	play   Play
}

func NewDefaultComedy() *Comedy {
	purchased := make([]Ticket, 0)
	start := time.Date(2020, time.March, 3, 16, 0, 0, 0, time.UTC)
	end := time.Date(2020, time.March, 3, 17, 20, 0, 0, time.UTC)
	return &Comedy{0.2, 0, Play{"Tartuffe", purchased, start, end}}
}

/*
 * Comedy implements Show interface
 */
func (s *Comedy) getName() string {
	return s.play.name
}

func (s *Comedy) getShowStart() time.Time {
	return s.play.showStart
}

func (s *Comedy) getShowEnd() time.Time {
	return s.play.showEnd
}

func (s *Comedy) addPurchase(t *Ticket) bool {
	flag := s.isNotPurchased(t)
	if flag {
		s.play.purchased = append(s.play.purchased, *t)
	}
	return flag
}

func (s *Comedy) isNotPurchased(t *Ticket) bool {
	flag := true
	for _, x := range s.play.purchased {
		if x.seat.row == t.seat.row && x.seat.number == t.seat.number {
			flag = false
			break
		}
	}
	return flag
}

type Tragedy struct {
	laughs float32
	deaths int32
	play   Play
}

func NewDefaultTragedy() *Tragedy {
	purchased := make([]Ticket, 0)
	start := time.Date(2020, time.April, 16, 9, 30, 0, 0, time.UTC)
	end := time.Date(2020, time.April, 16, 12, 30, 0, 0, time.UTC)
	return &Tragedy{0.0, 12, Play{"Macbeth", purchased, start, end}}
}

/*
 * Tragedy implements Show interface
 */
func (s *Tragedy) getName() string {
	return s.play.name
}

func (s *Tragedy) getShowStart() time.Time {
	return s.play.showStart
}

func (s *Tragedy) getShowEnd() time.Time {
	return s.play.showEnd
}

func (s *Tragedy) addPurchase(t *Ticket) bool {
	flag := s.isNotPurchased(t)
	if flag {
		s.play.purchased = append(s.play.purchased, *t)
	}
	return flag
}

func (s *Tragedy) isNotPurchased(t *Ticket) bool {
	flag := true
	for _, x := range s.play.purchased {
		if x.seat.row == t.seat.row && x.seat.number == t.seat.number {
			flag = false
			break
		}
	}
	return flag
}

type Theatre struct {
	seats []Seat
	shows []Show
}

func NewTheatre(numOfSeats int32, shows []Show) *Theatre {
	theatre := new(Theatre)
	theatre.seats = make([]Seat, numOfSeats)
	theatre.shows = shows
	return theatre
}

const (
	prime    = "Prime"
	standard = "Standard"
	special  = "Special"
)

func main() {
	// Initialize two shows
	shows := make([]Show, 2)
	comedy := NewDefaultComedy()
	comedy.play.showStart = time.Date(2020, time.March, 3, 19, 30, 0, 0, time.Local)
	comedy.play.showEnd = time.Date(2020, time.March, 3, 22, 0, 0, 0, time.Local)
	tragedy := NewDefaultTragedy()
	tragedy.play.showStart = time.Date(2020, time.April, 10, 20, 00, 0, 0, time.Local)
	tragedy.play.showEnd = time.Date(2020, time.April, 10, 23, 00, 0, 0, time.Local)
	shows[0] = comedy
	shows[1] = tragedy
	// Initialize the theatre
	theatre := NewTheatre(25, shows)
	cnt := 0
	for i := 1; i <= 5; i++ {
		for j := 1; j <= 5; j++ {
			if i == 1 {
				theatre.seats[cnt] = *NewSeat(int32(j), int32(i), NewCategory(prime, 35.0))
			} else if 2 <= i && i <= 4 {
				theatre.seats[cnt] = *NewSeat(int32(j), int32(i), NewCategory(standard, 25.0))
			} else {
				theatre.seats[cnt] = *NewSeat(int32(j), int32(i), NewCategory(special, 15.0))
			}
			cnt++
		}
	}
	// forever loop
	for {
		fmt.Println("These plays are available:")
		for _, x := range theatre.shows {
			fmt.Println(x.getName())
			fmt.Println("  start time:", x.getShowStart())
			fmt.Println("  end time: ", x.getShowEnd())
		}
		// get the play name
		fmt.Printf("Please enter the FULL name for the play: ")
		var playName string
		fmt.Scanf("%s", &playName)
		playName = strings.Trim(strings.ToLower(playName), " ")
		if playName != "tartuffe" && playName != "macbeth" {
			fmt.Println("Sorry, this play is not available now.")
		} else {
			fmt.Println("We have 25 seats in 5 rows evenly.")
			// get the row number
			var row int32
			fmt.Printf("Please enter the row: ")
			fmt.Scanf("%d", &row)
			for row < 1 || row > 5 {
				fmt.Printf("We don't have No.%d row\n", row)
				fmt.Printf("Please enter the row again: ")
				fmt.Scanf("%d", &row)
			}
			// get the seat number in the row
			var seatNum int32
			fmt.Printf("Please enter the seat number: ")
			fmt.Scanf("%d", &seatNum)
			for seatNum < 1 || seatNum > 5 {
				fmt.Printf("We don't have No.%d seat on the row\n", seatNum)
				fmt.Printf("Please enter the seat number again: ")
				fmt.Scanf("%d", &seatNum)
			}
			// generate the seat
			var seat *Seat
			if row == 1 {
				seat = NewSeat(seatNum, row, NewCategory(prime, 35.0))
			} else if 2 <= row && row <= 4 {
				seat = NewSeat(seatNum, row, NewCategory(standard, 25.0))
			} else {
				seat = NewSeat(seatNum, row, NewCategory(special, 15.0))
			}
			// get the customer name
			var custName string
			fmt.Printf("Please enter your name now: ")
			fmt.Scanf("%s", &custName)
			custName = strings.ToLower(strings.Trim(custName, " "))
			// deal with the order
			fmt.Printf("\nDealing with your order...\n\n")
			if playName == "tartuffe" {
				ticket := NewTicket(custName, seat, &theatre.shows[0])
				if theatre.shows[0].addPurchase(ticket) {
					fmt.Println("Your order is confirmed.")
					ticket.print()
				} else {
					flag := false
					// check the same row
					for i := 1; i <= 5; i++ {
						ticket.seat.number = int32(i)
						if theatre.shows[0].addPurchase(ticket) {
							flag = true
							break
						}
					}
					if flag {
						fmt.Println("Sorry the seat you choose has been sold.")
						fmt.Println("We change your seat.")
						ticket.print()
					} else {
						// check cheaper seats
						// remember to change the category
						for i := ticket.seat.row + 1; i <= 5; i++ {
							ticket.seat.row = int32(i)
							if i == 1 {
								ticket.seat.cat.name = prime
								ticket.seat.cat.base = 35.0
							} else if 2 <= i && i <= 4 {
								ticket.seat.cat.name = standard
								ticket.seat.cat.base = 25.0
							} else {
								ticket.seat.cat.name = special
								ticket.seat.cat.base = 15.0
							}
							for j := 1; j <= 5; j++ {
								ticket.seat.number = int32(j)
								if theatre.shows[0].addPurchase(ticket) {
									flag = true
									break
								}
							}
							if flag {
								break
							}
						}
						if flag {
							fmt.Println("Sorry the seat you choose has been sold.")
							fmt.Println("We change your seat.")
							ticket.print()
						} else {
							// check more expensive seats
							// remember to change the category
							for i := ticket.seat.row - 1; i >= 1; i-- {
								ticket.seat.row = int32(i)
								if i == 1 {
									ticket.seat.cat.name = prime
									ticket.seat.cat.base = 35.0
								} else if 2 <= i && i <= 4 {
									ticket.seat.cat.name = standard
									ticket.seat.cat.base = 25.0
								} else {
									ticket.seat.cat.name = special
									ticket.seat.cat.base = 15.0
								}
								for j := 1; j <= 5; j++ {
									ticket.seat.number = int32(j)
									if theatre.shows[0].addPurchase(ticket) {
										flag = true
										break
									}
								}
								if flag {
									break
								}
							}
							if flag {
								fmt.Println("Sorry the seat you choose has been sold.")
								fmt.Println("We change your seat.")
								ticket.print()
							} else {
								fmt.Println("Sorry, the seats for this show sold out.")
							}
						}
					}
				}
			} else {
				ticket := NewTicket(custName, seat, &theatre.shows[1])
				if theatre.shows[1].addPurchase(ticket) {
					fmt.Println("Your order is confirmed.")
					ticket.print()
				} else {
					flag := false
					// check the same row
					for i := 1; i <= 5; i++ {
						ticket.seat.number = int32(i)
						if theatre.shows[1].addPurchase(ticket) {
							flag = true
							break
						}
					}
					if flag {
						fmt.Println("Sorry the seat you choose has been sold.")
						fmt.Println("We change your seat.")
						ticket.print()
					} else {
						// check cheaper seats
						// remember to change the category
						for i := ticket.seat.row + 1; i <= 5; i++ {
							ticket.seat.row = int32(i)
							if i == 1 {
								ticket.seat.cat.name = prime
								ticket.seat.cat.base = 35.0
							} else if 2 <= i && i <= 4 {
								ticket.seat.cat.name = standard
								ticket.seat.cat.base = 25.0
							} else {
								ticket.seat.cat.name = special
								ticket.seat.cat.base = 15.0
							}
							for j := 1; j <= 5; j++ {
								ticket.seat.number = int32(j)
								if theatre.shows[1].addPurchase(ticket) {
									flag = true
									break
								}
							}
							if flag {
								break
							}
						}
						if flag {
							fmt.Println("Sorry the seat you choose has been sold.")
							fmt.Println("We change your seat.")
							ticket.print()
						} else {
							// check more expensive seats
							// remember to change the category
							for i := ticket.seat.row - 1; i >= 1; i-- {
								ticket.seat.row = int32(i)
								if i == 1 {
									ticket.seat.cat.name = prime
									ticket.seat.cat.base = 35.0
								} else if 2 <= i && i <= 4 {
									ticket.seat.cat.name = standard
									ticket.seat.cat.base = 25.0
								} else {
									ticket.seat.cat.name = special
									ticket.seat.cat.base = 15.0
								}
								for j := 1; j <= 5; j++ {
									ticket.seat.number = int32(j)
									if theatre.shows[1].addPurchase(ticket) {
										flag = true
										break
									}
								}
								if flag {
									break
								}
							}
							if flag {
								fmt.Println("Sorry the seat you choose has been sold.")
								fmt.Println("We change your seat.")
								ticket.print()
							} else {
								fmt.Println("Sorry, the seats for this show sold out.")
							}
						}
					}
				}
			}
		}
		fmt.Println()
	}
}
