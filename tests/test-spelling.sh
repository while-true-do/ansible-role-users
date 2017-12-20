#!/bin/bash

FILES=(README.md)

for FILE in "${FILES[@]}"; do
    BADWORDS=$(sed '/^```/,/^```/d' $FILE | aspell --lang=en --encoding=utf-8 --personal=./.aspell.en.pws list)
    NB_BADWORDS=$(echo "$BADWORDS" | wc -w)
    
    if [[ $NB_BADWORDS -gt 0 ]]; then
        echo -e "Found $NB_BADWORDS bad word(s) in $FILE"
        echo -e "----"
        echo -e "$BADWORDS"
        echo -e "---- \n"
	FAIL="1"
    fi
done

if [[ $FAIL -eq "1" ]]; then
    exit 1;
else
    exit 0;
fi
