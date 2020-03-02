# Prolog Note

## Index
* [Function](#Function)
* [Prolog Environment](#Prolog-Environment)
  * [Load file](#Load-file)
  * [Turn on/off trace](#Turn-on/off-trace)

## Function
* `length(?List, ?Int)`: get the list length.
* `member(?Elem, ?List)`: return true if *Elem* is a member of the *List*.
* `intersection(+Set1, +Set2, -Set3)`: *Set3* is the intersection of *Set1* and *Set2*.
* `union(+Set1, +Set2, -Set3)`: *Set3* is the union of *Set1* and *Set2*.
* `subtract(+Set, +Delete, -Result)`: *Result* is the difference of *Set* and *Delete*.

## Prolog Environment
### Load file
In Prolog environment, type `[file_name]` to load a file.
### Turn on/off trace.
* Turn on: `trace.`
* Turn off: `notrace, nodebug.`

## Other
* Remember to write the base case!
* Small-case letters and numbers will be treated as **literals**.