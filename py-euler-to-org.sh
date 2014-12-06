#!/usr/bin/env bash

backup_all() {
    letters=(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)

    cd bak
    for f in *.py
    do
        letter_count=$(echo $f | awk 'BEGIN { FS = "."}; { printf "%01d", $1}')
        count=$(expr $(expr $letter_count % 26) - 1)
        newfile=$(echo $(echo $f"."${letters[$count]}) | awk 'BEGIN { FS = "."}; { printf "%03d.%s.%03d.%s\n", $1+1, $2, $3, $4}')
        mv "$f" "${newfile}"
    done

    for f in *.org
    do
        letter_count=$(echo $f | awk 'BEGIN { FS = "."}; { printf "%01d", $1}')
        count=$(expr $(expr $letter_count % 26) - 1)
        newfile=$(echo $f | awk 'BEGIN { FS = "."}; { printf "%03d.%s.%s\n", $1+1, $2, $3}')
        mv "$f" "${newfile}"
    done

    cd ..
    for f in *.py
    do
        letter_count=$(echo $f | awk 'BEGIN { FS = "."}; { printf "%01d", $1}')
        count=$(expr $(expr $letter_count % 26) - 1)
        newfile=$(echo $(echo $f"."${letters[$count]}) | awk 'BEGIN { FS = "."}; { printf "%03d.%s.%03d.%s\n", $4+1, $3, $1, $2}')
        mv "$f" "bak/${newfile}"
    done

    for f in *.org
    do
        letter_count=$(echo $f | awk 'BEGIN { FS = "."}; { printf "%01d", $1}')
        count=$(expr $(expr $letter_count % 26) - 1)
        newfile=$(echo $f | awk 'BEGIN { FS = "."}; { printf "%03d.%s.%s\n", $4+1, $2, $3}')
        mv "$f" "bak/${newfile}"
    done

}

get_all_eulers() {
    for problem in {1..300}
    do
        echo "Y" | euler --generate ${problem}
    done
}

convert_all_eulers() {
    echo "#+TITLE: Literate Euler in OrgMode\n" > py_euler.org
    for pyFile in *.py
    do
        pyFileNoZeroes=$(echo $pyFile | sed 's/^0*//')
        if [ ! -f ${pyFile} ]
        then
            echo "File Not Found: " "${pyFile}"
        else
            echo "File Found: " "${pyFile}"
            echo "Adding File to py_euler.org"
            echo "Babel Block Settings: "
            echo "\tPython"
            echo "\t:tangle tangled/${pyFile}"
            echo "\t:results output value :session"
            echo "\t:mkdirp yes "
            echo "========================================"

            echo "* TODO Problem ${pyFileNoZeroes/.py/} " >> py_euler.org
            echo "#+begin_src python :tangle tangled/${pyFile} :results output value :session :mkdirp yes" >> py_euler.org
            cat ${pyFile} | awk '{print $0}' >> py_euler.org
            echo "#+end_src\n" >> py_euler.org
        fi
    done
    rm *.py
}

info () {
  printf "$1"
}

infoLF () {
  info "$1"
  echo ""
}

print_help() {
    info "EulerPy to OrgMode Converter"; echo ""
    info " "; echo ""
    info "Optional Arguments: "; echo ""
    info "  [help\t-h]  Print This Help Message"; echo ""
    info "  [get\t-g]  Get all Euler Files"; echo ""
    info "  [conv\t-c]  Convert to .org Files"; echo ""
    info "  [all\t-a]  Get and Convert"; echo ""
    info "  [bak\t-b]  TODO: Hacky Backup"; echo ""
}

if [[ $# -eq 0 ]]
then
    print_help
    exit 0
fi

for i in "$@"; do
    case $i in
        -h|help)
            print_help
            exit 0
            ;;
        -c|convert)
            convert_all_eulers
            exit 0
            ;;
        -g|get)
            get_all_eulers
            exit 0
            ;;
        -b|backup)
            backup_all
            exit 0
            ;;
        -a|all)
            get_all_eulers
            convert_all_eulers
            exit 0
            ;;
        *)
            break
            ;;
    esac
done
