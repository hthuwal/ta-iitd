open Test1
open Printf
let gpt = 0.1;;

(* Solution to part (a) -- number of ways in which coins a, b, c, d can be used to create amount amt.
k is the parameter that controls which of a, b, c, d are available - required since they 
cannot use lists.*)

let print_error student ta = 
	Printf.printf("ERROR: Wrong answer...\n");
	Printf.printf "Your answer: %s\n" student;
	Printf.printf "Expected answer: %s\n" ta;
	print_string "\n";;

let rec ways_helper amt a b c d k = 
	if amt = 0 then 1
	else if amt < 0 then 0
	else match k with
	| 1 -> (ways_helper (amt-a) a b c d k) + (ways_helper amt a b c d (k+1))
	| 2 -> (ways_helper (amt-b) a b c d k) + (ways_helper amt a b c d (k+1))
	| 3 -> (ways_helper (amt-c) a b c d k) + (ways_helper amt a b c d (k+1))
	| 4 -> (ways_helper (amt-d) a b c d k)
	| _ -> 0 ;;

let ways amt a b c d = 
	if amt <=0 || a<=0 || b<=0 || c<=0 || d<=0 || a = b || a = c || a = d || b = c || b = d || c = d 
	then -1 
	else
	ways_helper amt a b c d 1;;

let test_coinChanger amt a b c d = 
	let student = Test1.coinChanger amt a b c d in
	let ta = ways amt a b c d in
	if student == ta then (print_string "Correct Answer...\n\n"; gpt) 
	else (print_error (string_of_int student) (string_of_int ta); 0.0);;;;

let n,a,b,c,d = 
	int_of_string(Sys.argv.(1)),
	int_of_string(Sys.argv.(2)),
	int_of_string(Sys.argv.(3)),
	int_of_string(Sys.argv.(4)),
	int_of_string(Sys.argv.(5));;


let file = "result.txt";;
let () =
  (* Write message to file *)
  let oc = open_out_gen [Open_creat; Open_text; Open_append] 0o640 file in  (* create or truncate file, return channel *)
  fprintf oc "%f\n" (test_coinChanger n a b c d);   (* write something *)   
  close_out oc;;