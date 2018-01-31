let count = ref 0;;
while !count < 100000
do 
	print_int !count; print_newline();
	count:=!count + 1
done