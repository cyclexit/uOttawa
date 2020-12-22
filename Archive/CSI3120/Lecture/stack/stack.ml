#use "stack.mli";;

module ListStack : STACK =
    struct
        type 'a stack = 'a list
        let empty () : 'a stack = []
        let is_empty (s:'a stack) : bool = 
            match s with
            | [] -> true
            | _::_ -> false
        let push (x:'a) (s:'a stack) : 'a stack = x::s
        let pop (s:'a stack) : 'a stack = 
            match s with
            | [] -> []
            | _::tl -> tl
        let top (s:'a stack) : 'a option = 
            match s with
            | [] -> None
            | hd::_ -> Some hd
    end