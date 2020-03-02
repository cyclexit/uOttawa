# Prolog Note

## Index
* [Operator](#Operator)
* [Function](#Function)
  * [List operation](#List-operation)
  * [Others](#Others)
* [Prolog Environment](#Prolog-Environment)
  * [Load file](#Load-file)
  * [Turn on/off trace](#Turn-on/off-trace)
  * [List predicates](#List-predicates)
* [Other stuff](#Other-stuff)

## Operator
* `\+`: not
* `=\=`: not equal(numbers) </br>
  `\==`: not equal(others)

## Function
### List operation
* `length(?List, ?Int)`: get the list length.
* `member(?Elem, ?List)`: return true if *Elem* is a member of the *List*.
* `intersection(+Set1, +Set2, -Set3)`: *Set3* is the intersection of *Set1* and *Set2*.
* `union(+Set1, +Set2, -Set3)`: *Set3* is the union of *Set1* and *Set2*.
* `subtract(+Set, +Delete, -Result)`: *Result* is the difference of *Set* and *Delete*.
### Others
* `bagof(+Template, :Goal, -Bag)`: Create a bag which satifies the goal. Allow backtracking. </br>
  `+Var^Goal`: not to bind *Var* in *Goal*.
* `setof(+Template, +Goal, -Set)`: Equivalent to `bagof/3`, but sorts the result using `sort/2` to get a sorted list of alternatives without duplicates.

## Prolog Environment
### Load file
In Prolog environment, type `[file_name]` to load a file.
### Turn on/off trace.
* Turn on: `trace.`
* Turn off: `notrace, nodebug.`
### List predicates
`listing(:Pred)`

## Other stuff
* Remember to write the base case!
* Small-case letters and numbers will be treated as **literals**. </br>
  This feature can be used to implement flag arguments.[lab7/ex4](lab/lab7/ex4.prolog)
* If you want to pick something in an array, you need an auxilary array. </br>
  In the end, you just need to assign the auxilary array to the result.[lab7/ex3](lab/lab7/ex3.prolog)