#!/bin/bash

# Script to truncate atomic_mass numbers to remove
# trailing 0's (datatype already changed to non-precision)

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

#types=  1/metal, 2/nonmetal, 3/metalliod

ENTRIES=$($PSQL "SELECT atomic_number, atomic_mass::REAL FROM properties ORDER BY atomic_number;")

echo -e "\n --- STARTING CONVERSION --- \n"

# Read each entry, and remove any preceding 0's
echo "$ENTRIES" | while IFS="|" read AN AM
do
  
  RESULT=$($PSQL "UPDATE properties SET atomic_mass=$AM WHERE atomic_number=$AN")

  if [[ $RESULT == "UPDATE 1" ]]
  then
    echo "Successfully changed element with atomic_number of $AN to an atomic mass of $AM"
  else
    echo "Something when wrong: $RESULT"
  fi
done

echo -e "\n --- CONVERSION COMPLETE --- \n"
