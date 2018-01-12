#use "degrees_to_radians.ml";;
open Printf

let grade = 0.0;;
let gpt = 2.5;;

let  model_check_degrees_to_radians deg = if deg<0.0 then deg+.360.0 else (if deg>=360.0 then deg-.360.0 else deg);; 

(* model solution for degrees_to_radians *)
let model_degrees_to_radians angle:float = 
	let pi = 4.0 *. (atan 1.0) in
		((pi) /. (180.0)) *. (model_check_degrees_to_radians angle);;

 

let print_error student ta = 
	Printf.printf("ERROR: Wrong answer...\n");
	Printf.printf "Your answer: %s\n" student;
	Printf.printf "Expected answer: %s\n" ta;
	print_string "\n";;


let test_degree x t = 
	Printf.printf "Test Case %d\n" t;
	Printf.printf "x:%f \n" x ;
	let student = degrees_to_radians x  in
	let ta = model_degrees_to_radians x in
	if student = ta then (print_string "Correct Answer...\n\n"; gpt)
	else (print_error (string_of_float student) (string_of_float ta); 0.0);;

let test_check_degree x t = 
	Printf.printf "Test Case %d\n" t;
	Printf.printf "x:%f \n" x ;
	let student = check_degrees_to_radians x  in
	let ta = model_check_degrees_to_radians x in
	if student = ta then (print_string "Correct Answer...\n\n"; gpt)
	else (print_error (string_of_float student) (string_of_float ta); 0.0);;


print_string "Testing nlog.ml file...\n\n";;

print_string "Testing function: check_degrees_to_radians...\n";;
let grade = grade +. test_check_degree 388.0 1;;
let grade = grade +. test_check_degree (-94.0) 2;;
let grade = grade +. test_check_degree 150.0 3;;
let grade = grade +. test_check_degree 453.0 4;;
let grade = grade +. test_check_degree (-129.0) 5;;


print_string "Testing function: degrees_to_radians...\n";;
let grade = grade +. test_degree 37.0  1;;
let grade = grade +. test_degree 409.0  2;;
let grade = grade +. test_degree (-45.0)  3;;
let grade = grade +. test_degree 378.0  4;;
let grade = grade +. test_degree (-250.0)  5;;


let file = "result.txt";;
let () =
  (* Write message to file *)
  let oc = open_out_gen [Open_creat; Open_text; Open_append] 0o640 file in  (* create or truncate file, return channel *)
  fprintf oc "%f\n" grade;   (* write something *)   
  close_out oc;;