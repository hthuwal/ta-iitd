open Test
open Model
open Cell
open Array
open Printf


let gpt = 0.2;;

let runner sudoku_stud sudoku_ta id func_num = 
    let student = 
      (match func_num with 
      1 -> Test.loneRanger sudoku_stud id Test.getCellsRow
      |2 -> Test.loneRanger sudoku_stud id Test.getCellsCol
      |3 -> Test.loneRanger sudoku_stud id Test.getCellsBox
      |_-> (print_string "something went wrong"; false))
    in
    let ta = 
      (match func_num with 
      1 -> Model.loneRanger sudoku_ta id Model.getCellsRow
      |2 -> Model.loneRanger sudoku_ta id Model.getCellsCol
      |3 -> Model.loneRanger sudoku_ta id Model.getCellsBox
      |_-> (print_string "something went wrong"; false))
    in
    if (student = ta) && (Model.compareSudokus sudoku_stud sudoku_ta) then (gpt)
    else (0.0);;
    (* if student = ta then (print_string "CORRECT ANSWER\n"; gpt)
    else(print_string "INCORRECT ANSWER: \nMATRIX A\n";Model.print_mat (List.map Model.apply mat); print_string "\nVECTOR b: "; Model.print_list (Model.apply b); print_string "\n\nEXPECTED ANSWER: ";print_bool ta; print_string "\n\nYOUR ANSWER: "; print_bool student; print_string "\n";0.0);;
 *)

let sudoku_student = Array.make_matrix size size (PossibleValues (getList size []));;
let sudoku_teacher = Array.make_matrix size size (PossibleValues (getList size []));;

let inpfile = Sys.argv.(1);;
let id = int_of_string Sys.argv.(2);;
let func_num = int_of_string Sys.argv.(3);;

Model.readInput inpfile sudoku_student;;
Model.readInput inpfile sudoku_teacher;;

let file = "result.txt";;
let () =
  (* Write message to file *)
  let oc = open_out_gen [Open_creat; Open_text; Open_append] 0o640 file in  (* create or truncate file, return channel *)
  fprintf oc "%f\n" (runner sudoku_student sudoku_teacher id func_num);   (* write something *)   
  close_out oc;;
