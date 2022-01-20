. createTable.sh
. listTables.sh
. dropTable.sh
. insertIntoTable.sh
. updateTable.sh
. selectAllFromTable.sh
. deleteFromTable.sh

function tablesMenu {
    tput setaf 6;
    echo "+---------------------------+"
    echo "    $dbname Database Menu    "
	echo "+---------------------------+"
    echo "| 1 - Create Table          |"
    echo "| 2 - List Tables           |"
    echo "| 3 - Drop Table            |"
    echo "| 4 - Insert into Table     |"
    echo "| 5 - Update Table          |"
    echo "| 6 - Select From Table     |"
    echo "| 7 - Delete From Table     |"
    echo "| 8 - Back to Main Menu     |"
    echo "+---------------------------+"
    tput setaf 3;

	read -ep "Choose an option: " choice
	case $choice in
		1) createTable $dbname ;;
		2) listTables $dbname ;;
        3) dropTable $dbname ;;
		4) insertIntoTable $dbname ;;
        5) updateTable $dbname;;
        6) selectAllFromTable $dbname ;;
		7) deleteFromTable $dbname ;;
        8) ./main.sh ;;
		*) echo "Sorry invalid option";;
	esac
    }

while :
	do 
		tablesMenu 
done