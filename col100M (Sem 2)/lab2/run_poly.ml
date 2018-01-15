#use "poly.ml";;
open Printf
let grade = 0.0;;
let gpt = 2.5;;

let model_check_poly x y z = (x>0) && (y>0) && (z>0);;

(* model solution for poly function *)
let model_poly x y z =if model_check_poly x y z then 
	x*x*x + 2*x*y*z*z*y*z + 1 else -1;;



let print_error student ta = 
	Printf.printf("ERROR: Wrong answer...\n");
	Printf.printf "Your answer: %s\n" student;
	Printf.printf "Expected answer: %s\n" ta;
	print_string "\n";;


let test_poly x y z t = 
	Printf.printf "Test Case %d\n" t;
	Printf.printf "x:%d y:%d z:%d\n" x y z;
	let student = poly x y z in
	let ta = model_poly x y z in
	if student = ta then (print_string "Correct Answer...\n\n"; gpt)
	else (print_error (string_of_int student) (string_of_int ta); 0.0);;

let test_check_poly x y z t = 
	Printf.printf "Test Case %d\n" t;
	Printf.printf "x:%d y:%d z:%d\n" x y z;
	let student = check_poly x y z in
	let ta = model_check_poly x y z in
	if student = ta then (print_string "Correct Answer...\n\n"; gpt)
	else (print_error (string_of_bool student) (string_of_bool ta); 0.0);;



print_string "Testing poly.ml file...\n\n";;

print_string "Testing: function check_poly...\n";;
let grade = grade +. test_check_poly (-1) 2 3 1;;
let grade = grade +. test_check_poly 4 5 6 2;;
let grade = grade +. test_check_poly (-7) 8 (-9) 3;;
let grade = grade +. test_check_poly 1 2 4 4;;
let grade = grade +. test_check_poly (1) (-5) (9) 5;;

print_string "Testing: function poly...\n";;
let grade = grade +. test_poly 1 	2 	3 	1;;
let grade = grade +. test_poly (-4) 5 	6 	2;;
let grade = grade +. test_poly 7  	8 	9 	3;;
let grade = grade +. test_poly 2	8 	(-3)4;;
let grade = grade +. test_poly 1  	(-4)6 	5;;


Printf.printf "Score in poly.ml: %f/25\n\n" grade;;

let file = "result.txt";;
let () =
  (* Write message to file *)
  let oc = open_out_gen [Open_creat; Open_text; Open_append] 0o640 file in  (* create or truncate file, return channel *)
  fprintf oc "%f\n" grade;   (* write something *)   
  close_out oc;;




