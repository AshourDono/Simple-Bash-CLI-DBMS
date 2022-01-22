function updateTable {
  echo -e "Enter Table Name: \c"
  read tableName
  metaTable="."
  echo -e "Enter Condition Column name: \c"
  read field
  metaTable="$metaTable$tableName"
  fid=$(awk -F: '{if($1=="'$field'") print NR}'  dbms/$dbname/$metaTable)
  
  if [[ $fid == "" ]]
  then
    echo "Not Found"
    tablesMenu
  else
    echo -e "Enter Condition Value: \c"
    read value
    resultrow=$(awk -F: '{if ($'$fid'=="'$value'") print NR}'  dbms/$dbname/$tableName)
    if [[ $resultrow == "" ]]
    then
      echo "Value Not Found"
      tablesMenu
    else
      echo -e "Enter FIELD name to set: \c"
      read setField
      setFieldNumber=$(awk -F: '{if($1=="'$setField'") print NR}'  dbms/$dbname/$metaTable)
    
      if [[ $setField == "" ]]
      then
        echo "Not Found"
        tablesMenu
      else
        echo -e "Enter new Value to set: \c"
        read newValue
        oldValue=$(awk -F: '{if(NR=='$resultrow')print $'$setFieldNumber'}'  dbms/$dbname/$tableName)
        echo $oldValue
        sed -i 's/'$oldValue'/'$newValue'/g' dbms/$dbname/$tableName 
        echo "Row Updated Successfully"
        tablesMenu
      fi
    fi
  fi
}