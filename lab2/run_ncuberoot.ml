#use "mcuberoot.ml";;
open Printf
let grade = 0.0;;
let gpt = 2.5;;

let model_check_mcuberoot x y z = (x*.y*.z)>0.0 ;;

(* model solution for cube root *)
let model_mcuberoot (x:float) (y:float) (z:float) = if model_check_mcuberoot x y z then 
	(x*.y*.z)**(1.0/.3.0) else -1.0;;



let print_error student ta = 
	Printf.printf("ERROR: Wrong answer...\n");
	Printf.printf "Your answer: %s\n" student;
	Printf.printf "Expected answer: %s\n" ta;
	print_string "\n";;

let test_cube x y z t = 
	Printf.printf "Test Case %d\n" t;
	Printf.printf "x:%f y:%f z:%f\n" x y z;
	let student = mcuberoot x y z in
	let ta = model_mcuberoot x y z in
	if student = ta then (print_string "Correct Answer...\n\n"; gpt) 
	else (print_error (string_of_float student) (string_of_float ta); 0.0);;

let test_check_cube x y z t = 
	Printf.printf "Test Case %d\n" t;
	Printf.printf "x:%f y:%f z:%f\n" x y z;
	let student = check_mcuberoot x y z in
	let ta = model_check_mcuberoot x y z in
	if student = ta then (print_string "Correct Answer...\n\n"; gpt) 
	else (print_error (string_of_bool student) (string_of_bool ta); 0.0);;


print_string "Testing poly.ml file...\n\n";;

print_string "Testing function: check_mcuberoot...\n";;
let grade = grade +. test_check_cube (-1.0) 2.0 (-3.0) 1;;
let grade = grade +. test_check_cube 45.5 (-7.0) 40.0 2;;
let grade = grade +. test_check_cube (-10.7) (4.8) 3.0 3;;
let grade = grade +. test_check_cube 11.1 27.4 83.9 4;;
let grade = grade +. test_check_cube (-21.0) (-60.0) (-93.0) 5;;

print_string "Testing function: mcuberoot...\n";;
let grade = grade +. test_cube 7.0 (-2.0) 3.0 1;;
let grade = grade +. test_cube 2.0 2.0 2.0 2;;
let grade = grade +. test_cube (-8.0) (-9.0) 6.0 3;;
let grade = grade +. test_cube (-45.0) 12.0 3.0 4;;
let grade = grade +. test_cube 64.0 5.0 93.0 5;;



let file = "result.txt";;
let () =
  (* Write message to file *)
  let oc = open_out_gen [Open_creat; Open_text; Open_append] 0o640 file in  (* create or truncate file, return channel *)
  fprintf oc "%f\n" grade;   (* write something *)   
  close_out oc;;



