### Evaluate Q1

`./evaluate-q1.sh <path-to-data-folder> <path-to-sandbox-folder> <entry-number> <path-to-submissions-folder>`

- Data_folder must contain three things.
    + devnagri_train.csv
    + devnagri_test.csv
    + target_labels

- Submissions-folder must contain
    + entry-number.zip

#### Multiple Simultaneous Evaluation

To run multiple instances of above evaluation on different submission
- Create a file with list of parameters seperated by space.
- Each Line must contain four parameters corresponding to one submissions

e.g submissions.txt
```
data/set1 sandbox/set1 entry_number1 submissions
data/set1 sandbox/set1 entry_number2 submissions
.
.
.
```

Then Run the following command:

```bash
parallel --colsep --verbose -j 6 -a submissions.txt ./evaluate_q1.sh
```

- This will max 6 threads at a time. 
- Each line of the file submissions.txt will be treated as a list of (space seperated) parameters to a thread.