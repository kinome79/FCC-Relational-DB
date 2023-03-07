#!/bin/bash

# Salon Application: Used to display and manage appointments for services

PSQL="psql -X --username=freecodecamp --dbname=salon --no-align --tuples-only -c"

echo -e "\n\n ~~~~ Salon Appointment Scheduler ~~~~\n"

# This function displays the main menue of services, and any messages supplied
PRIMARY_MENU () {
  if [[ $1 ]]
  then
    echo -e "\n --- $1 --- "
  fi
  
  SERVICE_LIST=$($PSQL "SELECT service_id, name, cost FROM services ORDER BY service_id")

  echo -e "\nHow may we help you today?\n-----------------------------------------"
  echo "$SERVICE_LIST" | while IFS="|" read ID NAME COST 
  do
    printf '%2s) %-20s $ %-7s\n' $ID "$NAME" $COST
  done  
  echo -e "\n 97) Review Current Appointments\n 98) Cancel An Appointment\n 99) Exit Scheduler\n"
  echo "Please select a service:"
  read SERVICE_ID_SELECTED

  case $SERVICE_ID_SELECTED in
    97) REVIEW ;;
    98) CANCEL ;;
    99) EXIT ;;
    *) SCHEDULE ;;
  esac
}

# This function collects user information to schedule a service, adding user to database if needed
SCHEDULE () {
  
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")

  if [[ -z $SERVICE_NAME ]]
  then
    PRIMARY_MENU "Invalid service option selected. Please try again!"
  else
    echo -e "\nA $SERVICE_NAME huh? ... Great Choice!\n"
    echo "Please enter your phone number:"
    read CUSTOMER_PHONE
    if [[ -z $CUSTOMER_PHONE ]]
    then
      PRIMARY_MENU "Your phone number cannot be blank. Please start over!"
    else
      IFS="|" read CUSTOMER_ID CUSTOMER_NAME <<< "$($PSQL "SELECT customer_id, name FROM customers WHERE phone='$CUSTOMER_PHONE'")" 
      if [[ -z $CUSTOMER_ID ]]
      then
        echo -e "\nWelcome! You appear to be a new customer!!!\n"
        echo "Please enter your name:"
        read CUSTOMER_NAME
        if [[ -z $CUSTOMER_NAME ]]
        then
          PRIMARY_MENU "Your name cannot be blank. Please start over!"
        else
          RESPONSE=$($PSQL "INSERT INTO customers(name, phone) VALUES ('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
          CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
          if [[ -z CUSTOMER_ID ]]
          then
            PRIMARY_MENU "An error occurred while creating your account. Please start over!"
          else
            echo -e "\nThanks for supplying your information $CUSTOMER_NAME!"
            ENTER_TIME
          fi
        fi 
      else
        echo -e "\nWelcome back $CUSTOMER_NAME!"
        ENTER_TIME
      fi  
    fi
  fi
}

# This function is called to prompt for a service time, and create an appointment entry
ENTER_TIME () {
  SERVICE_TIME=""
  while [[ -z $SERVICE_TIME ]]
  do
    echo -e "\nPlease enter the time for your service: "
    read SERVICE_TIME
    echo " "
  done

  RESPONSE=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES ($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
  if [[ $RESPONSE == "INSERT 0 1" ]]
  then
    echo -e "I have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME.\n"
  else
    echo -e "An unknown error occurred while creating your appointment! Sorry :("
  fi
}

# this function is used to get customer phone and display appointments currently scheduled
REVIEW () {
  echo -e "\nWe can show you any appointments you have!\n"
  read -p "Please enter your phone number: " CUSTOMER_PHONE
  if [[ -z $CUSTOMER_PHONE ]]
  then
    PRIMARY_MENU "Your phone number cannot be blank. Please start over!"
  else
    IFS="|" read CUSTOMER_ID CUSTOMER_NAME <<< "$($PSQL "SELECT customer_id, name FROM customers WHERE phone='$CUSTOMER_PHONE'")" 
    if [[ -z $CUSTOMER_ID ]]
    then
      echo -e "\nNo account for that phone number found.\n"
    else
      echo -e "\nWelcome Back $CUSTOMER_NAME. Below are your appointments.\n-------------------------------------------------"
      APPOINTMENTS=$($PSQL "SELECT appointment_id, time, name, cost FROM appointments JOIN services USING(service_id) WHERE customer_id=$CUSTOMER_ID")
      TOTAL_COST=$($PSQL "SELECT SUM(cost) FROM appointments JOIN services USING(service_id) WHERE customer_id=$CUSTOMER_ID")
      printf "%3s |  %-10s|  %-20s|  %-7s" "Id" "Time" "Service" "cost"
      echo -e "\n-------------------------------------------------"
      if [[ -z $APPOINTMENTS ]] 
      then
        echo  "         --- No Appointments Scheduled ---"
        echo -e "-------------------------------------------------"
      else
        echo "$APPOINTMENTS" | while IFS="|" read ID TIME SERVICE COST; do
          printf "%3s |  %-10s|  %-20s| $%-7s\n" $ID "$TIME" "$SERVICE" $COST
        done
        echo -e "-------------------------------------------------"
        printf "%39s | $%-2s\n\n" "Total Cost Of Services:" $TOTAL_COST
      fi
     fi
  fi    
}

#this function gets a customer phone number, shows appointments, and deletes the one selected
CANCEL () {
  echo -e "\nWe can assist you with cancelling your appointment!\n"
  read -p "Please enter your phone number: " CUSTOMER_PHONE
  if [[ -z $CUSTOMER_PHONE ]]
  then
    PRIMARY_MENU "Your phone number cannot be blank. Please start over!"
  else
    IFS="|" read CUSTOMER_ID CUSTOMER_NAME <<< "$($PSQL "SELECT customer_id, name FROM customers WHERE phone='$CUSTOMER_PHONE'")" 
    if [[ -z $CUSTOMER_ID ]]
    then
      echo -e "\nNo account for that phone number found.\n"
    else
      echo -e "\nWelcome Back $CUSTOMER_NAME. Below are your appointments.\n-----------------------------------------------"
      APPOINTMENTS=$($PSQL "SELECT appointment_id, time, name, cost FROM appointments JOIN services USING(service_id) WHERE customer_id=$CUSTOMER_ID")
      
      if [[ -z $APPOINTMENTS ]] 
      then
        echo -e "        --- No Appointments Scheduled ---\n"
      else
        echo "$APPOINTMENTS" | while IFS="|" read ID TIME SERVICE COST; do
          printf "%3s)  %-10s %-20s $%-7s\n" $ID "$TIME" "$SERVICE" $COST
        done
        echo " "
        read -p "Please enter the number for the appointment to cancel: " APPT_ID_SELECTED
        if [[ -z $APPT_ID_SELECTED ]]
        then
          echo -e "\nNo appointment ID was entered!\n"
        else
          APPT_ID=$($PSQL "SELECT appointment_id FROM appointments WHERE customer_id=$CUSTOMER_ID AND appointment_id=$APPT_ID_SELECTED")
          if [[ -z $APPT_ID ]] 
          then
            echo -e "\nThat appointment ID was not listed!\n"
          else
            RESULT=$($PSQL "DELETE FROM appointments WHERE appointment_id=$APPT_ID")

            if [[ $RESULT == "DELETE 1" ]]
            then
              echo -e "\nAppointment Deleted.\n"
            else
              echo -e "\nAn error occurred while deleting appointment!\n"
            fi
          fi
        fi
      fi
     fi
  fi    
}


EXIT () {
  echo -e "\n---  Thanks for visiting and have a great day!!!  ---\n"
  exit 0
}

PRIMARY_MENU 
