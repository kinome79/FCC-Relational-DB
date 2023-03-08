#!/bin/bash

# Script to fill in type_id column 
# based on type column for properties table

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

#types=  1/metal, 2/nonmetal, 3/metalliod

ENTRIES=$($PSQL "SELECT atomic_number, type FROM properties;")

echo -e "\n --- STARTING CONVERSION --- \n"

# Read each entry, and depending on type, set the type ID
echo "$ENTRIES" | while IFS="|" read AN TYPE
do
  case $TYPE in
  "metal") TYPE_ID=1 ;;
  "nonmetal") TYPE_ID=2 ;;
  "metalloid") TYPE_ID=3 ;;
  *) echo "Type Not found!" ;;
  esac

  RESPONSE=$($PSQL "UPDATE properties SET type_id=$TYPE_ID WHERE atomic_number=$AN")
  if [[ $RESPONSE == "UPDATE 1" ]]
  then
    echo "Changed $TYPE to $TYPE_ID"
  else
    echo "Something when wrong: $RESPONSE"
  fi
done

echo -e "\n --- CONVERSION COMPLETE --- \n"
