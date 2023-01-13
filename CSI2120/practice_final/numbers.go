package main

import "fmt"

func main() {
	numbers := []int{216, 218, 221, 260}
	ch := make(chan int)

	// Your solution
	go func() {
		defer close(ch)
		for _, num := range numbers {
			ch <- num
		}
	}()

	for {
		if num, ok := <-ch; !ok {
			fmt.Println("Channel closed")
			break
		} else {
			fmt.Println(num)
		}
	}
}
