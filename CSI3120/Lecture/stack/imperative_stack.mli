module type IMP_STACK =
    sig
        type 'a stack
        val empty : unit -> 'a stack
        val push : 'a -> 'a stack -> unit
        val pop : 'a stack -> 'a option
    end
