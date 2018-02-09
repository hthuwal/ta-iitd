open Bonus
open Printf
let gpt = 0.01;;

(* Solution to part (b) -- best way to combine coins a, b, c, d to create amount amt.
'best' is defined by a weight function which is a parameter to  the main cost function*)

let weight x = int_of_float ((float_of_int 2)** (float_of_int x));;
let weightI x = 100 - x;;

let print_error student ta = 
	Printf.printf("ERROR: Wrong answer...\n");
	Printf.printf "Your answer: %s\n" student;
	Printf.printf "Expected answer: %s\n" ta;
	print_string "\n";;

let rec cost_helper amt a b c d k f = 
	if amt = 0 then 0
	else if amt < 0 then max_int
	else match k with
	| 1 -> let temp = (cost_helper (amt-a) a b c d k f) in 
				if temp != max_int then min ((f a) + temp) (cost_helper amt a b c d (k+1) f)
				else min (max_int) (cost_helper amt a b c d (k+1) f)

	| 2 -> let temp = (cost_helper (amt-b) a b c d k f) in 
				if temp != max_int then min ((f b) + temp) (cost_helper amt a b c d (k+1) f)
				else min (max_int) (cost_helper amt a b c d (k+1) f)

	| 3 -> let temp = (cost_helper (amt-c) a b c d k f) in 
				if temp != max_int then min ((f c) + temp) (cost_helper amt a b c d (k+1) f)
				else min (max_int) (cost_helper amt a b c d (k+1) f)

	| 4 -> let temp = (cost_helper (amt-d) a b c d k f) in 
				if temp != max_int then (f d) + temp
				else max_int
	| _ -> 0 ;;

let cost amt a b c d f = 
	if amt <=0 || a<=0 || b<=0 || c<=0 || d<=0 || a = b || a = c || a = d || b = c || b = d || c = d 
	then -1 
	else
	cost_helper amt a b c d 1 f ;;

let test_coinChanger_cost amt a b c d f = 
	let student = Bonus.coinChanger_cost amt a b c d f in
	let ta = cost amt a b c d f in
	if student == ta then (print_string "Correct Answer...\n\n"; gpt) 
	else (print_error (string_of_int student) (string_of_int ta); 0.0);;

let n,a,b,c,d,f = 
	int_of_string(Sys.argv.(1)),
	int_of_string(Sys.argv.(2)),
	int_of_string(Sys.argv.(3)),
	int_of_string(Sys.argv.(4)),
	int_of_string(Sys.argv.(5)),
	int_of_string(Sys.argv.(6));;

let file = "result.txt";;
let () =
  (* Write message to file *)
  let oc = open_out_gen [Open_creat; Open_text; Open_append] 0o640 file in  (* create or truncate file, return channel *)
  if f = 0 then
  (
  	fprintf oc "%f\n" (test_coinChanger_cost n a b c d weight);   (* write something *)   
	close_out oc
  )
  else
  (
  	fprintf oc "%f\n" (test_coinChanger_cost n a b c d weightI);   (* write something *)   
  	close_out oc
  );;
