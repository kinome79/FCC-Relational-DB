#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# This script will import data from a games.csv file into the worldcup database

echo -e "\n~~ Read games.cvs Bash Script - Build Database ~~\n"


# Removed option to optionally clear table as it might interfere with tests
# echo -e "\nWould you like to clear the database first (Y/N)? "
# read CLEAR

# if [[ $CLEAR == "Y" ]]
# then
 VAL=$($PSQL "TRUNCATE games,teams;")
 echo "-- DATABASE TABLES teams AND games CLEARED --"
#fi

echo -e "\nReading Data from games.csv...\n"

TEAMCOUNT=0
GAMECOUNT=0

#TEAM_ID function takes 1 arg, returns team_id, and adds to database if not present
TEAM_ID () {
  local ID=$($PSQL "SELECT team_id FROM teams WHERE name='$1';")
  if [[ -z $ID ]]
  then
   local ADDED=$($PSQL "INSERT INTO teams (name) VALUES ('$1');")
   if [[ $ADDED == "INSERT 0 1" ]]
   then
    echo "Team '$1' added to database 'teams'"
    (( TEAMCOUNT++ ))
    return $($PSQL "SELECT team_id FROM teams WHERE name='$1';")
   else 
    echo "Error attempting to add team '$1' to database 'teams'" 
    return $ID
   fi
  else 
   return $ID
  fi
}

#Loop through games.csv taking data and adding to teams/games databases
shopt -s lastpipe #Required to keep my counting variables working
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
 if [[ $YEAR != "year" ]] #Indicating its the header, ignore it
  then
  #Get the team ids and add teams to DB using the TEAM_ID function
   TEAM_ID "$WINNER"
   WINNER_ID=$?
   TEAM_ID "$OPPONENT"
   OPPONENT_ID=$?
  
  #Add the game to the games database using the aquired team IDs
   RESULT=$($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES ($YEAR,'$ROUND',$WINNER_ID,$OPPONENT_ID,$WINNER_GOALS,$OPPONENT_GOALS);")
   if [[ $RESULT == "INSERT 0 1" ]]
    then 
     echo "'$YEAR $ROUND' added to database 'games'"
     (( GAMECOUNT++ ))
    else echo "Error occurred adding '$YEAR $ROUND' to database 'games'"
   fi
 fi  
done

echo -e "\n ~~ IMPORT COMPLETE: Imported $TEAMCOUNT new teams and $GAMECOUNT new games!"
