#! /bin/bash

function deleteFromTable(){
    echo "Enter Table name you want to delete from."
    read -e tableName
    if test -f dbms/$dbname/$tableName
        then
            tablerows=$(cat dbms/$dbname/$tableName | wc -l )
            if test $tablerows -gt 0
                then
                    echo "Total number of rows: $tablerows ."
                    echo "Enter row number you want to delete"
                    read -e rowNumber
                    
                    while ! [[ $rowNumber =~ ^[1-9]+$ ]]
                        do
                            echo "please enter a vaild number";
                            read -e rowNumber
                        done

                    if test $rowNumber -gt $tablerows
                        then
                            echo "your number is out of table boundry"
                    else
                        sed -i "${rowNumber}d" dbms/$dbname/$tableName
                        echo "row deleted successfuly"
                    fi

                else
                    echo "Table is empty"
            fi
        else
            echo "Table does not exist."
    fi

}

# deleteFromTable
