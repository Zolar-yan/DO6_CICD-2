#!/bin/bash

SUCCESS=0
FAIL=0
VERDICT=""

for condition in -e -i -v -c -l -n -h -s -o
do
  ./s21_grep $condition "print" test.txt test.txt > s21_grep.txt
  grep $condition "print" test.txt test.txt > grep.txt
  VERDICT="$(diff -s s21_grep.txt grep.txt)"
  if [ "$VERDICT" == "Files s21_grep.txt and grep.txt are identical" ]
          then
            (( SUCCESS++ ))
          else
            echo "[-] flags -$condition not passed"
            (( FAIL++ ))
        fi
  rm s21_grep.txt grep.txt
done

for condition in -i -v -n -h -s -c
do
  for condition2 in -i -v -n -h -s -c
  do
    if [ $condition != $condition2 ]   
      then
      ./s21_grep $condition $condition2 "print" test.txt > s21_grep.txt
      grep $condition $condition2 "print" test.txt > grep.txt
      RESULT="$(diff -s s21_grep.txt grep.txt)"
      if [ "$RESULT" == "Files s21_grep.txt and grep.txt are identical" ]
              then
                (( SUCCESS++ ))
              else
                echo "[-] flags $condition $condition2 not passed"
                (( FAIL++ ))
              fi
      rm s21_grep.txt grep.txt
          fi
  done
done

for condition in -i -n -h -s -o -l
do
  for condition2 in -i -n -h -s -o -l
  do
    if [ $condition != $condition2 ]   
      then
      ./s21_grep $condition $condition2 "print" test.txt > s21_grep.txt
      grep $condition $condition2 "print" test.txt > grep.txt
      RESULT="$(diff -s s21_grep.txt grep.txt)"
      if [ "$RESULT" == "Files s21_grep.txt and grep.txt are identical" ]
              then
                (( SUCCESS++ ))
              else
                echo "[-] flags $condition $condition2 not passed"
                (( FAIL++ ))
              fi
      rm s21_grep.txt grep.txt
          fi
  done
done

for condition in -i -c -n -h -s -o
do
  for condition2 in -i -c -n -h -s -o
  do
    if [ $condition != $condition2 ]   
      then
      ./s21_grep $condition $condition2 "print" test.txt > s21_grep.txt
      grep $condition $condition2 "print" test.txt > grep.txt
      RESULT="$(diff -s s21_grep.txt grep.txt)"
      if [ "$RESULT" == "Files s21_grep.txt and grep.txt are identical" ]
              then
                (( SUCCESS++ ))
              else
                echo "[-] flags $condition $condition2 not passed"
                (( FAIL++ ))
              fi
      rm s21_grep.txt grep.txt
          fi
  done
done

for condition in -i -l -n -h -s -v
do
  for condition2 in -i -l -n -h -s -v 
  do
    if [ $condition != $condition2 ]   
      then
      ./s21_grep $condition $condition2 "print" test.txt > s21_grep.txt
      grep $condition $condition2 "print" test.txt > grep.txt
      RESULT="$(diff -s s21_grep.txt grep.txt)"
      if [ "$RESULT" == "Files s21_grep.txt and grep.txt are identical" ]
              then
                (( SUCCESS++ ))
              else
                echo "[-] flags $condition $condition2 not passed"
                (( FAIL++ ))
              fi
      rm s21_grep.txt grep.txt
          fi
  done
done


echo "passed $SUCCESS tests"
echo "failed $FAIL tests"