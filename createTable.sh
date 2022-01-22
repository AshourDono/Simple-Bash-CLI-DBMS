#!/usr/bin/bash

function createTable {
    tableNameValid
    if ( test -f dbms/$1/$tableName )
    then
        echo "Table already Exists!"
    else {
        metaData="";

        read -ep "Enter number of columns: " columnsNumber
         
        while ! [[ $columnsNumber =~ ^[1-9]+$ ]]
        do
            echo "please enter columns number as an Integer!";
            read -e columnsNumber
        done

        for ((i = 0; i < $columnsNumber ; i++))
        do
            read -ep "Enter column name: " columnName
             

            regex='^[]0-9a-zA-Z,!^`@{}=().;/~_[:space:]|[-]+$'
            while ! [[ $columnName =~ $regex ]]
                do
                    read -ep "Enter a valid name: " columnName
                done

            # validation on column name to avoid duplication
            val=$(echo -e $metaData | awk -F: '{print $1}' | grep -w $columnName)
            while [ $val ]
            do 
            read -ep "The column $columnName you entered is a duplicate, please enter another name: " columnName;
            val=$(echo -e $metaData | awk -F: '{print $1}' | grep -w $columnName);
            done

            echo "Enter type for column $columnName";
            chooseColumnType

            
            metaData+="$columnName:$columnType\n"
        done 

        touch dbms/$1/.$tableName;
        touch dbms/$1/${tableName};
        echo "$tableName created successfully"
        echo -e $metaData | sed '$d'  >> dbms/$1/.$tableName
    }
    fi
}

function chooseColumnType {
    select choice in "int" "string"
    do
        case $choice in
        int)
            columnType="int";
            break;;
        string)
            columnType="string";
            break;;
        *)
            echo "Sorry, invalid type" ;;
        esac
    done
}

function tableNameValid {
    read -ep "Enter table name: " tableName
     
    regex='^[]0-9a-zA-Z,!^`@{}=();/~_|[-]+$'

    if [[ $tableName =~ $regex ]]
    then
    return
    else
        echo "Please enter a valid name";
        tableNameValid;
    fi
}