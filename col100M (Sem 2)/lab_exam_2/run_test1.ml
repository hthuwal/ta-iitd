(* open Test1 *)
open Model
open Array
open Printf

let gpt = 0.1;;

let test1_runner = 
	let student = Test1.coinChanger amt a b c d in
	let ta = ways amt a b c d in
	if student == ta then (print_string "Correct Answer...\n\n"; gpt) 
	else (print_error (string_of_int student) (string_of_int ta); 0.0);;;;

let rec print_list l = match l with
[] -> ()
|x::xs -> print_float(x);print_string " " ;print_list xs;;

let rec print_mat m = match m with
[] -> ()
|row::xs -> print_list row; print_newline();print_mat xs;;

