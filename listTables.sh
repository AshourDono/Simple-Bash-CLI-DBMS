function listTables {
    tablesnum=$(ls dbms/$dbname/ | wc -l );
    if test $tablesnum -eq 0
        then
            echo "There are no tables available"
        else 
            echo "Tables are: "
			ls dbms/$dbname/
    fi
    clickEnter
}
