#!/bin/bash

# Script to output information about elements from a database

# echo -e "\n ~~~ PERIODIC TABLE APPLICATION ~~~ \n"

PSQL="psql --username freecodecamp --dbname=periodic_table -t --no-align -c"


if [[ $1 ]]
then
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    DATA=$($PSQL "SELECT atomic_number, symbol, name, atomic_mass, melting_point_celsius AS mpc, boiling_point_celsius AS bpc, type FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number=$1")
  elif [[ $1 =~ ^[A-Z|a-z][A-Z|a-z]?$ ]]
  then
    DATA=$($PSQL "SELECT atomic_number, symbol, name, atomic_mass, melting_point_celsius AS mpc, boiling_point_celsius AS bpc, type FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE symbol='$1'")
  else
    DATA=$($PSQL "SELECT atomic_number, symbol, name, atomic_mass, melting_point_celsius AS mpc, boiling_point_celsius AS bpc, type FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE name='$1'")
  fi

  if [[ -z $DATA ]] 
  then
    echo "I could not find that element in the database."
  else
    IFS="|" read AN SYMBOL NAME AM MPC BPC TYPE <<< "$DATA"
    echo "The element with atomic number $AN is $NAME ($SYMBOL). It's a $TYPE, with a mass of $AM amu. $NAME has a melting point of $MPC celsius and a boiling point of $BPC celsius."
  fi
  
else
  echo "Please provide an element as an argument."
fi
