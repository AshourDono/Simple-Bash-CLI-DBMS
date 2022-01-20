function dropTable {

	read -ep "Enter the table name to drop: " tableName

    regex='^[]0-9a-zA-Z,!^`@{}=().;/~_|[-]+$'
    if [[ $tableName =~ $regex ]]
            then
                if ( test -f dbms/$1/$tableName )
                then
                    rm dbms/$1/$tableName ;
                    rm dbms/$1/.$tableName ;
                    echo "$tableName dropped successfully";
                else {
                    echo "Table $tableName does not exist";
                }
                fi
            else
                echo "Not a valid table name";
            fi
    clickEnter
}