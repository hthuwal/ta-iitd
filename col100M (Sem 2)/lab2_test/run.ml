#use "fact.ml";;

let rec fact_model_solution n = if n = 0 then 1 else n*(fact_model_solution(n-1));;

let print_error n = 
	Printf.printf("ERROR: Wrong answer...\n");
	Printf.printf "Your answer: %d\n" (fact n);
	Printf.printf "Correct answer: %d\n" (fact_model_solution n);
	print_string "\n";;

let check n t = 
	Printf.printf "Checking Test Case %d\n" t;
	Printf.printf "%d!\n" n;
	if (fact n) = (fact_model_solution n) then print_string "Correct Answer...\n\n" else print_error n;;

check 4 1;;
check 5 2;;
check 7 3;;





