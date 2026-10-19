let trials = 1_000_000

let random_float min_value max_value =
  min_value +. Random.float (max_value -. min_value)

let () =
  Random.self_init ();

  let min_value = -1e10 in
  let max_value = 1e10 in
  let equal_count = ref 0 in

  for _ = 1 to trials do
    let x = random_float min_value max_value in
    let y = random_float min_value max_value in
    let z = random_float min_value max_value in

    let left = (x +. y) +. z in
    let right = x +. (y +. z) in

    if left = right then
      incr equal_count
  done;

  let percentage =
    100.0 *. float_of_int !equal_count /. float_of_int trials
  in

  Printf.printf
    "%.4f\n" percentage
    (*changed print to be consistent*)