module type STACK =
    sig
        type 'a stack
        val empty : unit -> 'a stack
        val is_empty : 'a stack -> bool
        val push : 'a -> 'a stack -> 'a stack
        val pop : 'a stack -> 'a stack
        val top : 'a stack -> 'a option
    end