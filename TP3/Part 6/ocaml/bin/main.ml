
type range = A | B | C
type iter = X | Y | Z

let range_to_tuple x = match x with 
| A -> (0.,1.)
| B -> (-1e-16, 1e16)
| C -> (-1e-10, 1e10)



let iter_to_nb x = match x with 
| X -> 100
| Y -> 1000
| Z -> 1000000



let random_float min_value max_value =
  min_value +. Random.float (max_value -. min_value)



let () =
  let nb = ref 0 in
  let pp = ref false in
  let ze = ref false in
  let range = ref A in
  let iter = ref X in
  let () = Arg.parse
  [("-nb", Arg.Int (fun x -> nb := x), "Le nombre d'itération");
  ("-pp", Arg.Unit (fun _ -> pp:= true), "Pretty print pour le tp");
  ("-range", Arg.Int (fun x -> match  x with
  | 0 -> range :=  A
  | 1 -> range :=  B
  | 2 -> range :=  C 
  | _ -> range :=  A), "La range");
  ("-iter", Arg.Int (fun x -> match  x with
  | 0 -> iter :=  X
  | 1 -> iter :=  Y
  | 2 -> iter :=  Z 
  | _ -> iter :=  X), "nb iter");
    ("-Z", Arg.Set ze, "nb iter")
  ]
  (fun _ -> ())
  "Running seed" in

  Random.self_init ();

  let (a1,a2) = range_to_tuple !range in
  let iteration = iter_to_nb !iter in 


  let min_value = a1 in
  let max_value = a2 in
  let equal_count = ref 0 in

  for _ = 1 to iteration do



    let x =  random_float min_value max_value in
    let y = random_float min_value max_value in
    let z = random_float min_value max_value in
    
    let new_x = Z.of_float x in 
    let new_y = Z.of_float y in 
    let new_z = Z.of_float z in 

    let t = begin 
      if (!ze) then
        (Z.(+) (Z.(+) new_x new_y) new_z) 
        = 
        (Z.(+)  new_x (Z.(+) new_y new_z ))
    else
      (x +. (y +. z)) 
      =
      ((x+.y) +. z)
    end in


    if t then
      incr equal_count
  done;

  let percentage =
    100.0 *. float_of_int !equal_count /. float_of_int iteration
  in

  match !pp with
  | false -> Printf.printf
    "%.6f\n" percentage
    (*changed print to be consistent*)
  | true -> Printf.printf ("(%d;%.6f)\n") iteration percentage