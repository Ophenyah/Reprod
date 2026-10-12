
type exo = Associativite | BankNaive | BankOptimized

let generate () = 
  (Random.float 1.0, Random.float 1.0, Random.float 1.0)



let compare_sum (x,y,z) =
  Float.equal ((x +. y) +. z) (x +. (y +. z)) 


let rec run_nb_stats (nb, y, n) = 
  match nb with
  | 0 -> (y,n)
  | _ -> match compare_sum (generate ()) with 
      | true -> run_nb_stats (nb-1, y+1, n)
      | false -> run_nb_stats (nb-1, y, n+1)


let run_nb nb =
  let (a,b) = run_nb_stats (nb, 0, 0) in
  float_of_int(a) /. (float_of_int a +. float_of_int b)


let banking money year = 
  let rec banking money year totaly = 
  match year with
  | 1 -> money-.1.
  | _ ->  banking ((money -. 1. ) *. (Int.to_float ((totaly +1)-year))) (year-1) totaly
in banking money year year

(* Pas fonctionnel encore
let banking_op (money) year =
    let rec banking_op money year totaly =
  match year with
  | 1 ->  Decimal.(-) (money) (Decimal.one)
  | _ ->  banking_op (Decimal.( * ) (Decimal.(-) (money) (Decimal.one))   (Decimal.of_int(((totaly +1)-year))))   (year-1) totaly
in banking_op money year year
*)

(* seed 48596  82.7762, 100000000 it*)
let () = 
let seed = ref None in
let nb = ref 500000 in
let to_file = ref false in
let exo = ref Associativite in
let () = Arg.parse
[("-seed", Arg.Int (fun x -> seed := Some x), "La seed du random");
 ("-nb", Arg.Int (fun x -> nb := x), "Le nombre d'itération");
 ("-type",  Arg.String (fun x -> exo := match x with 
 | "a" -> Associativite
 | "bn" -> BankNaive
 | "bo" -> BankOptimized
 | _ -> failwith "Erreur arg, ni a ni b"
 ), "L'exo à run : associativite (a) ou banque (b)")
]
(fun _ -> ())
"Running seed"
in
let () = match !seed with
| None -> Random.self_init ()
| Some a -> Random.init a
in
 let value = match !exo with
 | Associativite -> 
 100. *. run_nb !nb |> Float.to_string
 | BankNaive -> banking (Float.exp 1.0) 50 |> Float.to_string
 | BankOptimized -> failwith "NIY" (*banking_op (Decimal.of_string Decimal.Context. "2.718281828459") 50 |> Decimal.to_string *)
 in 
 match !to_file with
 | false -> value |> print_endline
 | true -> failwith "NIY"