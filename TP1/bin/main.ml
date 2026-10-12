

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


  (* seed 48596  82.7762, 10M it*)
let () = 
let seed = ref None in
let nb = ref 500000 in
let () = Arg.parse
[("-seed", Arg.Int (fun x -> seed := Some x), "La seed du random");
 ("-nb", Arg.Int (fun x -> nb := x), "Le nombre d'itération")
]
(fun _ -> ())
"Running seed"
in
let () = match !seed with
| None -> Random.self_init ()
| Some a -> Random.init a
in
 100. *. run_nb !nb |> Float.to_string |> print_endline