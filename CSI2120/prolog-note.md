# Prolog Note

## Index
* [Syntax](#Syntax)
* [Operator](#Operator)
* [Function](#Function)
  * [List operation](#List-operation)
  * [Collect solutions](#Collect-solutions)
* [Prolog Environment](#Prolog-Environment)
  * [Load file](#Load-file)
  * [Turn on/off trace](#Turn-on/off-trace)
  * [List predicates](#List-predicates)
* [Other stuff](#Other-stuff)

***

## Syntax
* list: `[a1, a2, ..., an]`
* pair: `key-val`</br>
  list of pairs: `[k1-v1, k2-v2, ..., kn-vn]` </br>
  get value with key from pairs: `Pairs.Key`(*Pairs* is a list of key-val pairs) </br>
  iterate through pairs: `[K-V|Pairs]`(*Pairs* is a list of key-val pairs)

## Operator
* `\+`: not
* `=\=`: not equal(numbers) </br>
  `\==`: not equal(others)
* `=<`: less than or equal to </br>
  `>=`: greater than or equal to
* `=`: assign string literal to a variable

## Function
### List operation
* `length(?List, ?Int)`: get the list length.
* `member(?Elem, ?List)`: return true if *Elem* is a member of the *List*. </br>
  If *Elem* is an unassigned variable, member will iterate throungh the whole the list.
* `intersection(+Set1, +Set2, -Set3)`: *Set3* is the intersection of *Set1* and *Set2*. </br>
  `union(+Set1, +Set2, -Set3)`: *Set3* is the union of *Set1* and *Set2*. </br>
  `subtract(+Set, +Delete, -Result)`: *Result* is the difference of *Set* and *Delete*.
* `max_member(-Max, +List)`: get the max member in the list. </br>
  `min_member(-Min, +List)`: get the min member in the list. 
### Collect solutions
* `bagof(+Template, :Goal, -Bag)`: Create *Bag* which satifies the *Goal* with *Template*. Allow backtracking. </br>
  *Template* is a variable, and *Goal* is a predicate with parameters. </br>
  `+Var^Goal`: not to bind *Var* in *Goal*.
* `findall(+Template, :Goal, -Bag)`: Do not bind any variable.
* `setof(+Template, +Goal, -Set)`: Equivalent to `bagof/3`, but sorts the result using `sort/2` to get a sorted list of alternatives without duplicates. The order of lists is also sorted by `sort/2`.

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