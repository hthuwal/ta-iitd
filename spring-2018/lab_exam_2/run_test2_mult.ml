open Array
open Printf

let gpt = 0.03;;

let test2_runner mat r1 c = 
	let student = List.map Model.apply (Test2.mult mat r1 c) in
	let ta = List.map Model.apply (Model.mult mat r1 c) in
	if student = ta then (print_string "CORRECT ANSWER"; gpt)
	else
	(
		print_string "INCORRECT ANSWER\n"; 
        Printf.printf "i: %d, c: %g\n" r1 c;
		print_string "\nMATRIX\n";
		Model.print_mat (List.map Model.apply mat); 
		print_string "\nEXPECTED ANSWER\n";
		Model.print_mat ta; 
		print_string "\nYOUR ANSWER\n"; 
		Model.print_mat student; 
		print_string "";0.0
    );;


let rec remove_last l ans= match l with
[] -> []
|x::y::[] -> ans @ [x]
|x::tl -> remove_last tl (ans @ [x]);;

let mat = Model.read_mat_from_carg;;

let b = List.nth mat ((List.length mat) - 1);;
let r1 = int_of_float (List.nth b 0);;
let c = List.nth b 1;;

let mat = remove_last mat [];;

let file = "result.txt";;
let () =
  (* Write message to file *)
  let oc = open_out_gen [Open_creat; Open_text; Open_append] 0o640 file in  (* create or truncate file, return channel *)
  fprintf oc "%f\n" (test2_runner mat r1 c);   (* write something *)   
  close_out oc;;