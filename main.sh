#! /bin/bash

function setdbms(){ #usage: create the parent directory "dbms" 
	mkdir -p dbms  #create directory only if not exists
}

function createDB(){ #usage: create a database inside /dbms
	dbaseNameValid
	test -d dbms/$dbname && echo "DataBase already exists!" || (mkdir dbms/$dbname  && printf "Database %s created successfully.\n" $dbname)

	clickEnter
}

function dbaseNameValid { #usage: check if dbname is valid according to a regex
    read -ep "Enter the database name: " dbname

    regex='^[]0-9a-zA-Z,!^`@{}=();/~_|[-]+$'
    if [[ $dbname =~ $regex ]]
    then
    return
    else
        echo "Please enter a valid name";
        dbaseNameValid;
    fi
}

function listDB(){ #usage: list all available dbs in /dbms .. "show databases in mysql"
	local dbNum;
	dbNum=$( ls dbms | wc -l );
	if test $dbNum -eq 0
		then
			echo "There are no databases";
			clickEnter
		else
			echo "Databases are: "
			ls dbms
			clickEnter
	fi
}

function connectDB(){ #usage: connect to a selected db .. "use db in mysql"
	read -ep "Enter the database name you wanna connect to: " dbname
	 
	local regex='^[]0-9a-zA-Z,!^`@{}=().;/~_|[-]+$'
	if [[ $dbname =~ $regex ]]
        then
			test ! -d dbms/$dbname && printf "Database %s does not exist.\n" $dbname && clickEnter || . tablesMenu.sh $dbname;
        else
			printf "Database does not exist.\n" 
    fi
	
}

function currLocation(){
	pwd
	clickEnter
}

function clickEnter(){
	read -p "Press [Enter] key to continue..." 
}

function dropDatabase { #usage: drop a selected db
	read -ep "Enter the database name to drop: " dbname
	local regex='^[]0-9a-zA-Z,!^`@{}=().;/~_|[-]+$'
	if [[ $dbname =~ $regex ]]
        then
				if [ -d dbms/$dbname ]
				then
				rm -r  dbms/$dbname ;
				echo "Database $dbname dropped successfully";
				else
				echo "Database $dbname does not exist";
				fi
        else
				echo "Database $dbname does not exist";
    fi
	
}

function readInput(){
	echo -n "Choose an option: "
	read choice
	case $choice in
		1) createDB ;;
		2) listDB ;;
		3) connectDB;;
		4) dropDatabase ;;
		5) echo "bye"; exit;;
		*) echo "$(tput setaf 1)Sorry, invalid option !$(tput setaf 3)"; clickEnter;;
	esac
}

function showDBMenu(){
    tput setaf 6; #change color to lightblue
	echo "====== Simple Bash DBMS ====="
	echo "+---------------------------+"
    echo "| 1 - Create Database       |"
    echo "| 2 - List Databases        |"
    echo "| 3 - Connect Database      |"
    echo "| 4 - Drop Database         |"
    echo "| 5 - Exit                  |"
    echo "+---------------------------+"
    tput setaf 3; #change color to green
}


setdbms

while :
do 
	showDBMenu
	readInput
done

