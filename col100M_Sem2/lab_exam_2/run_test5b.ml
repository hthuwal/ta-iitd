open Test5
open Model
open Array
open Printf
(* open Printexc *)
(* open String *)

let gpt = 0.02;;

(*let test5_runner mat b=  
	let student = 
		try List.map Model.apply (Test5.solve mat b)
		with e -> List.tl (String.split_on_char '.' (to_string e))
	in 
	let ta = 
		try List.map Model.apply (Model.solve mat b)	
		with e -> List.tl (String.split_on_char '.' (to_string e)) 
	in
	if student = ta then gpt
	else 0.0;;
*)

let test5_runner mat b=  
	let student = 
		try Model.apply (Test5.solve mat b)
		with 
			Test5.Dimension_mismatch -> ["Dimension_mismatch"]
		|   Test5.No_solutions -> ["No_solutions"]
		|   Test5.Infinite_solutions -> ["Infinite_solutions"]
		|   _ -> ["Something weird"]
	in 
	let ta = 
		try Model.apply (Model.solve mat b)
		with 
			Model.Dimension_mismatch -> ["Dimension_mismatch"]
		|   Model.No_solutions -> ["No_solutions"]
		|   Model.Infinite_solutions -> ["Infinite_solutions"]
		|   _ -> ["Something weird"]
	in
    if student = ta then (print_string "CORRECT ANSWER\n"; gpt)
	else
	(
		print_string "INCORRECT ANSWER\n"; 
		print_string "MATRIX\n";
		Model.print_mat (List.map Model.apply mat); 
        print_string "VECTOR b: ";
        Model.print_list (Model.apply b);
		print_string "\n\nEXPECTED ANSWER\n";
		Model.print_list ta; 
		print_string "\n\nYOUR ANSWER\n"; 
		Model.print_list student; 
		print_string "\n\n";0.0
    );;

let rec remove_last l ans= match l with
[] -> []
|x::y::[] -> ans @ [x]
|x::tl -> remove_last tl (ans @ [x]);;

let mat = Model.read_mat_from_carg;;

let b = List.nth mat ((List.length mat) - 1);;
let mat = remove_last mat [];;

let file = "result.txt";;
let () =
  (* Write message to file *)
  let oc = open_out_gen [Open_creat; Open_text; Open_append] 0o640 file in  (* create or truncate file, return channel *)
  fprintf oc "%f\n" (test5_runner mat b);   (* write something *)   
  close_out oc;;