#!/usr/bin/env bash


inputFile="./resources/input.txt"
jackFile="./resources/jack-and-jill.txt"
problem1() {
    # print just the first two lines of the file resources/input.txt
   head -n 2 $inputFile 
}

 problem3 () {
    # print everything except the first two lines of the file resources/input.txt
    tail -n +2 $inputFile
}


problem3() {
    # print only the last three lines of the file resources/input.txt
   tail -n 3 $inputFile 
}

problem4() {
    # print everything except the last three lines of the file resources/input.txt
    head -n +3 $inputFile
    # on standard linux
    :
}

problem5() {
    # print only lines containing jack in resources/jack-and-jill.txt
    grep 'jack' $jackFile
}

problem6() {
    # replace jill with bill in resources/jack-and-jill.txt, without modifying the file,
    # print to console
    sed  "s/jill/bill/g" $jackFile
}

problem7() {
    # print the file resources/jack-and-jill.txt but without any blank lines
    # have two solutions:
    # one that doesn't consider white space on lines, and one that does.

    sed  '/^$/d' $jackFile
    
}

problem8() {
    # print the file resources/jack-and-jill.txt all on a single line
    cat $jackFile | tr -d '\n'

}

problem9() {
    # list only the directories (names only, one on each line) in the current directory
    # include hidden directories.
    # there are many solutions to this, mine is 50 characters long.
    for f in $(ls); do [[ -d $f ]] && echo  "$f"; done
}

problem10() {
    # write a command that succeeds (return status is 0) only if it is run in the afternoon/evening.
    # hint: my answer is 24 characters long.
    [ "$(date +%H)" -ge 12 ]
}

problem11() {
    # print all environment variables that contain a given text, as a JSON document.
    # the text will be provided as the first positional argument
    # if no variables are found, it should print '{}'
    # the JSON should be pretty printed, you can use jq or not.
    # make sure the last value is not followed by a comma.
    # note: this is tougher than it sounds.
    grpTxt=${1:-=}
    printCommaFlag=false
    echo '{' 
    for var in $(env | grep "$grpTxt" ) ; do

           if $printCommaFlag ; then
               echo -n ","
               echo -e '\n'
           else
               printCommaFlag=true
           fi
        cat <<< "$var" | awk -F'=' '{printf("\"%s\":\"%s\"", $1, $2)}'

    done

    echo  '}' 
}

problem12() {
    # in a directory, print the top ten files by their size, in descending order by size.  The output
    # can have <file_size> <file> in each line.  Include headers and have the output formatted nice so the columns line up.
    # you can just assume the size column width is at most 10 characters wide.
    echo -e "h1\th2"
    f=$(ls -lA ./ | grep -vE '^[d|total]' | cut --delimiter=' ' --fields=5,11 | sort -nr )
    
    cat <<< "$f"
}

problem13() {
    # print the mounted drives names, capacity, and mount directory
    # your answer may vary based on your operating system.
    df | awk '{print $1, $5, $NF}'
}

problem14() {
    # Given a family tree document, and the name of a person, print a tree of all their descendants
    # format: person <father> <mother>
    tree=$(cat << EOF
susan bill carol
rebecca bill carol
ken phillip sarah
theresa phillip sarah
bill roger mary
phillip roger mary
john gilligan theresa
EOF
)
    person="$1"
# expected output if run with "mary"
#mary
#  - bill
#    - susan
#    - rebecca
#  - phillip
#    - ken
#    - theresa
#      - john
    :
}

problem15() {
    # data munging
    fantasy_land=$(cat << EOF
City        Established Population Mascot        MedianIncome
Hoof        1903        523432     Froto         82398
Wise        1732        98234      Sorcerer      23523
Sparkle     1283        130321     Leprechaun    93951
Flying      1403        2058331    Spider        130241
Green       1932        9821573    Spider        98376
Black       1735        31251      Cat           10253
Shady       1815        652385     Cat           63523
EOF
)
    city_stats=$(cat << EOF
City        State     Country
Hoof        Unicorn   Magic
Wise        Owl       Magic
Sparkle     Unicorn   Magic
Flying      Broom     Witchcraft
Green       Broom     Witchcraft
Black       Potion    Witchcraft
Shady       Potion    Witchcraft
EOF
)
    # print all cities that were founded between 1400 and 1900 in descending order by population
    # only output the population, established, city, state, and country
    :
}

problem16() {
    # json processing with jq.
    data=$(cat << EOF
{
    "items": [
        {
            "type": "person",
            "name": {
                "first": "count",
                "last": "dracula"
            },
            "sex": "male",
            "dob": "1900-01-01"
        },
        {
            "type": "person",
            "name": {
                "first": "mister",
                "last": "frankenstein"
            },
            "sex": "male",
            "dob": "1960-01-01"
        },
        {
            "type": "person",
            "name": {
                "first": "rosy",
                "last": "pedals"
            },
            "sex": "female",
            "dob": "2000-04-01"
        },
        {
            "type": "person",
            "name": {
                "first": "princess",
                "last": "diamonds"
            },
            "sex": "female",
            "dob": "1993-09-17"
        },
        {
            "type": "place",
            "coordinates": {
                "latitude": 5,
                "longitude": -3
            },
            "id": 3
        },
        {
            "type": "person",
            "name": {
                "first": "kenny",
                "last": "dance"
            },
            "sex": "male",
            "dob": "1982-11-26"
        },
        {
            "type": "person",
            "name": {
                "first": "miss",
                "last": "tified"
            },
            "sex": "female",
            "dob": "1987-06-21"
        },
        {
            "type": "person",
            "name": {
                "first": "boogey",
                "last": "man"
            },
            "sex": "male",
            "dob": "1996-02-18"
        }
    ]
}
EOF
)
    # print the date of birth, first name, and last name of all the men, in descending order by DoB.
    # print it out as a table with a header, formatted nice.
    # use jq, don't use grep.
   cat <<< $data | jq '.items[] | select(.type=="person")  | select(.sex=="male") | [.type,.dob,.name.first + " " + .name.last,.sex]'
}
