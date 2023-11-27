CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

if [[ -f student-submission/ListExamples.java ]]
then
    echo 'Found ListExamples.java in given submission'
    echo 'Will now start grading your submission'
else
    echo 'Could not find file ListExamples.java in the given submission'
    echo 'Score: 0/4'
    exit 1
fi

cp student-submission/ListExamples.java ./grading-area

javac -cp $CPATH *.java
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > junit-output.txt

FAILURES=`grep -c FAILURES!!! junit-output.txt`

if [[ $FAILURES -eq 0 ]]
then
    echo 'All of your tests passed, nice job!'
    echo 'Score: 4/4'
else
    RESULT_LINE=`grep "Tests run:" junit-output.txt`

    # The ${VAR:N:M} syntax gets a substring of length M starting at index N
    COUNT=${RESULT_LINE:25:1}

    echo "JUnit output was:"
    cat junit-output.txt
    echo "Score: $COUNT/4"
fi