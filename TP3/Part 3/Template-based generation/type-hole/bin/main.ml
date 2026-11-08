let trials = 1_000_000

let random_float min_value max_value =
  min_value +. Random.float (max_value -. min_value)



let () =
  let nb = ref trials in
  let pp = ref false in
  let () = Arg.parse
  [("-nb", Arg.Int (fun x -> nb := x), "Le nombre d'itération");
  ("-pp", Arg.Unit (fun _ -> pp:= true), "Pretty print pour le tp")
  ]
  (fun _ -> ())
  "Running seed" in

  Random.self_init ();

  let min_value = -1e10 in
  let max_value = 1e10 in
  let equal_count = ref 0 in

  for _ = 1 to !nb do
    let x = random_float min_value max_value in
    let y = random_float min_value max_value in
    let z = random_float min_value max_value in

    let new_x = {{ x }} in 
    let new_y = {{ y }} in 
    let new_z = {{ z }} in 

    let left = (fun a b c -> {{ f_l }}) new_x new_y new_z in
    let right = (fun a b c -> {{ f_r }}) new_x new_y new_z in

    if left = right then
      incr equal_count
  done;

  let percentage =
    100.0 *. float_of_int !equal_count /. float_of_int !nb
  in

  match !pp with
  | false -> Printf.printf
    "%.6f\n" percentage
    (*changed print to be consistent*)
  | true -> Printf.printf ("(%d;%.6f)\n") !nb percentage