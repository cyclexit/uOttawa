let rec zip (xs : int list) (ys : int list) : (int * int) list option = 
    match (xs, ys) with
    | ([], []) -> Some []
    | (x::xs', y::ys') ->
        (match (zip xs' ys') with
        | None -> None
        | Some zs -> Some ((x, y)::zs))
    | (_, _) -> None;;

let _ =
    zip [2;4] [3;5]