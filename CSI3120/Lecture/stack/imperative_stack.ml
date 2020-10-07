#use "imperative_stack.mli";;

module ImpStack : IMP_STACK =
    struct
        type 'a stack = ('a list) ref
        let empty() : 'a stack = ref []
        let push (x:'a) (s:'a stack) : unit =
            s := x::(!s)
        let pop (s:'a stack) : 'a option =
            match !s with
            | [] -> None
            | hd::tl -> (s := tl; Some hd)
    end