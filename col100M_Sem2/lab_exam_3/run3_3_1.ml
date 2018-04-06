open Test
open Model
open Cell
open Array
open Printf


let sudoku_student = Array.make_matrix size size (PossibleValues (getList size []));;
let sudoku_teacher = Array.make_matrix size size (PossibleValues (getList size []));;
let sudoku_original = Array.make_matrix size size (PossibleValues (getList size []));;

let inpfile = Sys.argv.(1);;
let value = int_of_string Sys.argv.(2);;
let row = int_of_string Sys.argv.(3);;
Model.readInput inpfile sudoku_student;;
Model.readInput inpfile sudoku_teacher;;
Model.readInput inpfile sudoku_original;;

let gpt = 0.2;;

let print_bool b = if b = true then print_string "True\n" else print_string "False\n";;

let print_error row value student ta = 
    print_string "INCORRECT ANSWER: \n"; 
    Printf.printf "Row: %d, Value: %d\n" row value;
    print_string "Expected Answer: ";
    Model.printTupleList ta;
    print_string "Your Answer: ";
    Model.printTupleList student;
    print_string "\n";;

let runner sudoku_stud sudoku_ta row value = 
    let student = Test.getCellsRow sudoku_stud row value in
    let ta = Model.getCellsRow sudoku_ta row value in
    if Model.compareTupleLists student ta then (gpt)
    else (print_error row value student ta; 0.0);;


let file = "result.txt";;
let () =
  (* Write message to file *)
  let oc = open_out_gen [Open_creat; Open_text; Open_append] 0o640 file in  (* create or truncate file, return channel *)
  fprintf oc "%f\n" (runner sudoku_student sudoku_teacher row value);   (* write something *)   
  close_out oc;;
