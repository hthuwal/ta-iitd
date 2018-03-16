ocamlc -o out model.ml gen_ref.ml
while IFS= read line
do
    arr=($line) #splitting line into elements
    ./out ${arr[*]}
    printf "\n"
done <"in.txt"