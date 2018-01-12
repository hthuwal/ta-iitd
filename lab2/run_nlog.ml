#use "nlog.ml";;
open Printf
let grade = 0.0;;
let gpt = 2.5;;

let model_check_nlog x = true ;;
(* model solution for natural logarithm *)

let model_nlog x:float = if model_check_nlog x then 
	log (x +. sqrt(x *. x +. 1.0))
    else -1.0;;

let print_error student ta = 
	Printf.printf("ERROR: Wrong answer...\n");
	Printf.printf "Your answer: %s\n" student;
	Printf.printf "Expected answer: %s\n" ta;
	print_string "\n";;

let test_nlog x t = 
	Printf.printf "Test Case %d\n" t;
	Printf.printf "x:%f \n" x ;
	let student = nlog x  in
	let ta = model_nlog x in
    if student = ta  then (print_string "Correct Answer...\n\n"; gpt) 
	else (print_error (string_of_float student) (string_of_float ta); 0.0);;

let test_check_nlog x t = 
	Printf.printf "Test Case %d\n" t;
	Printf.printf "x:%f \n" x ;
	let student = check_nlog x  in
	let ta = model_check_nlog x in
	if student = ta then (print_string "Correct Answer...\n\n"; gpt) 
	else (print_error (string_of_bool student) (string_of_bool ta); 0.0);;

print_string "Testing nlog.ml file...\n\n";;

print_string "Testing function: check_nlog...\n";;
let grade = grade +. test_check_nlog 100.0 1;;
let grade = grade +. test_check_nlog (-2.0) 2;;
let grade = grade +. test_check_nlog 17.0 3;;
let grade = grade +. test_check_nlog (-27.0) 4;;
let grade = grade +. test_check_nlog (-55.0) 5;;

print_string "Testing function: nlog...\n";;
let grade = grade +. test_nlog 14.0  1;;
let grade = grade +. test_nlog (-55.0)  2;;
let grade = grade +. test_nlog (-93.0)  3;;
let grade = grade +. test_nlog (17.0)  4;;
let grade = grade +. test_nlog (193.0)  5;;


let file = "result.txt";;
let () =
  (* Write message to file *)
  let oc = open_out_gen [Open_creat; Open_text; Open_append] 0o640 file in  (* create or truncate file, return channel *)
  fprintf oc "%f\n" grade;   (* write something *)   
  close_out oc;;