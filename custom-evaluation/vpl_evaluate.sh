#!/bin/bash

. common_script.sh

if [ "$VPL_GRADEMIN" = "" ] ; then
    export VPL_GRADEMIN=0
    export VPL_GRADEMAX=10
fi

# Prepare run

# This compiles the source.c file and creates the vpl_execution object file
./vpl_run.sh >>vpl_compilation_error.txt 2>&1
cat vpl_compilation_error.txt

# Compilation was succesful
if [ -f vpl_execution ] ; then

    # Rename it because vpl_execution will be our tester!
    mv vpl_execution vpl_test

    # v3?
    check_program python

    echo "#! /bin/bash" > vpl_execution
    echo "python tester.py">> vpl_execution

# Compilation failed
else
    echo "#!/bin/bash" >> vpl_execution
    echo "echo" >> vpl_execution
    echo "echo '<|--'" >> vpl_execution
    echo "echo 'The compilation or preparation of execution has failed.'" >> vpl_execution
    echo "echo '--|>'" >> vpl_execution
    echo "echo" >> vpl_execution
    echo "echo 'Grade :=>>$VPL_GRADEMIN'" >> vpl_execution
fi

chmod +x vpl_execution
