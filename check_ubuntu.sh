#!/bin/bash

# some tips on if statements
# https://linuxize.com/post/bash-if-else-statement/

VAR=`dpkg-query --list | grep -Ei "Password guessing program|cracker|netct"`
if [[ -n $VAR ]]
then
  echo "*** - Nasty program installed"
  echo "*** - $VAR"
else
  echo "OK - no nasty installed programs found"
fi


# some more info on loops
# https://www.cyberciti.biz/faq/bash-for-loop/

for value in `getent passwd | cut -d ":" -f 1`
do
  VAR=`sudo -l -U $value | grep "may run the following commands"`
  if [[ -n $VAR ]]
  then
    echo "user $value can run privileged commands"
  fi
done
