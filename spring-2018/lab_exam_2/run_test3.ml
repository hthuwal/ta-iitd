open Array
open Printf

let gpt = 0.0225;;

let test3_runner mat = 
	let student = List.map Model.apply (Test3.rowEchelon mat) in
	let ta = List.map Model.apply (Model.rowEchelon mat) in
	if student = ta then (print_string "CORRECT ANSWER\n"; gpt)
	else
	(
		print_string "INCORRECT ANSWER\n"; 
		print_string "MATRIX\n";
		Model.print_mat (List.map Model.apply mat); 
		print_string "\nEXPECTED ANSWER\n";
		Model.print_mat ta; 
		print_string "\nYOUR ANSWER\n"; 
		Model.print_mat student; 
		print_string "\n\n";0.0
    );;

let mat = Model.read_mat_from_carg;;

let file = "result.txt";;
let () =
  (* Write message to file *)
  let oc = open_out_gen [Open_creat; Open_text; Open_append] 0o640 file in  (* create or truncate file, return channel *)
  fprintf oc "%f\n" (test3_runner mat);   (* write something *)   
  close_out oc;;