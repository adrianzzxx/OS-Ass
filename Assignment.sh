#!/bin/bash

# Author1:  Yong Wei Yuan
# Author2:  Goh Neng Fu
# Date:    14/07/2023
# Course:  BACS2093 Operating Systems
# Purpose: University Venue Management Menu




# Author1:  Yong Wei Yuan
# Task: Add New Patron
# Description:Adding new Patron into text file

# Function to check if the email is valid
is_valid_email() {
    local email=$1
    local regex='^[A-Za-z0-9._%+-]+@student\.tarc\.edu\.my$'
    if [[ $email =~ $regex ]]; then
        return 0  # Valid email format
    else
        return 1  # Invalid email format
    fi
}

# Function to handle the A option (Register New Patron)
register_patron() {
    clear
    echo "Patron Registration"
    echo "=================="

    # Validate Patron ID (7-digit number)
    while true; do
        read -p "Patron ID (As per TAR UMT format - 7-digit number): " patron_id
        if [[ $patron_id =~ ^[0-9]{7}$ ]]; then
            break
        else
            echo "Invalid Patron ID format. Please enter a 7-digit number."
        fi
    done
    
    read -p "Patron Full Name (As per NRIC): " full_name
    read -p "Contact Number: " contact_number

    # Validate the email address
    while true; do
        read -p "Email Address (As per TAR UMT format): " email_address
        if is_valid_email "$email_address"; then
            break
        else
            echo "Invalid email format. Please enter a valid email address."
        fi
    done

    # Store patron details in the patron.txt file
    echo "$patron_id:$full_name:$contact_number:$email_address" >> patron.txt

    echo

    read -p "Register Another Patron? (y)es or (q)uit: " choice
    if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
        register_patron
    else
        main_menu
    fi
}

# Function to handle the B option (Search Patron Details)
search_patron() {
    clear
    echo -e "\e[1;4;49;37m Search Patron Details \e[0m"
    echo

    read -p "Enter Patron ID: " search_id

    echo

    # Search for patron details in the patron.txt file
    patron_details=$(grep "^$search_id:" patron.txt)

    if [[ -n "$patron_details" ]]; then
        patron_name=$(echo "$patron_details" | cut -d: -f2)
        contact_number=$(echo "$patron_details" | cut -d: -f3)
        email_address=$(echo "$patron_details" | cut -d: -f4)

        echo "Full Name (auto display): $patron_name"
        echo "Contact Number (auto display): $contact_number"
        echo "Email Address (auto display): $email_address"
        echo
    else
        echo "Patron ID not found."
    fi

    read -p "Search Another Patron? (y)es or (q)uit: " choice
    if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
        search_patron
    else
        main_menu
    fi
}

# Author2       : Goh Neng Fu
# Task          : Add New Venue
# Description   : Adding new venue into text file
# Parameters    : (e.g. array  - a list of integers )
# Return        : (e.g. the newly sorted array) 

# Function to handle the C option (Add New Venue)
add_new_venue() {
    clear
    echo "Add New Venue"
    echo "=============="

    # Input validation for Block Name
    while true; do
        read -p "Block Name (alphabet only): " block_name
        if [[ $block_name =~ ^[[:alpha:]]+$ ]]; then
            break
        else
            echo "Invalid input. Block Name should contain alphabets only."
        fi
    done

    # Input validation for Room Number
    while true; do
        read -p "Room Number (e.g., AB123): " room_number
        if [[ $room_number =~ ^[[:alpha:]]{2}[0-9]+$ ]]; then
            break
        else
            echo "Invalid input. Room Number should start with 2 alphabets followed by numbers."
        fi
    done

    # Input validation for Room Type
    while true; do
        read -p "Room Type (alphabet only): " room_type
        if [[ $room_type =~ ^[[:alpha:]]+$ ]]; then
            break
        else
            echo "Invalid input. Room Type should contain alphabets only."
        fi
    done

    # Input validation for Capacity
    while true; do
        read -p "Capacity (numeric only): " capacity
        if [[ $capacity =~ ^[0-9]+$ ]]; then
            break
        else
            echo "Invalid input. Capacity should contain numeric digits only."
        fi
    done

    # Input validation for Remarks
    while true; do
        read -p "Remarks (non-numeric): " remarks
        if [[ $remarks =~ ^[[:alpha:][:space:]]+$ ]]; then
            break
        else
            echo "Invalid input. Remarks should not contain all numeric characters."
        fi
    done

    # Store venue details in the venue.txt file
    echo "$block_name:$room_number:$room_type:$capacity:$remarks:Available" >> venue.txt

    echo
    read -p "Add Another New Venue? (y)es or (q)uit: " choice
    if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
        add_new_venue
    else
        main_menu
    fi
}

# Function to handle the D option (List Venue)
list_venue_details() {
    clear
    echo "List Venue Details"
    echo

    read -p "Enter Block Name: " search_block
    echo "--------------------------------------------------------------------------------------------"

    # Filter and display venue details based on the block name
    echo -e "Room Number\tRoom Type\tCapacity\tRemarks\t\t\tStatus"
    echo

    grep "^$search_block:" venue.txt | while IFS=':' read -r block_name room_number room_type capacity remarks status; do
        echo -e "$room_number\t\t$room_type\t\t$capacity\t\t$remarks\t\t\t$status"
    done

    echo
    echo "--------------------------------------------------------------------------------------------"
    read -p "Search Another Block Venue? (y)es or (q)uit: " choice
    if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
        list_venue_details
    else
        main_menu
    fi
}

# ... (Previous code for other functions)

# Call the main menu function to start the program
main_menu


# Function to handle the E option (Book Venue)
# ... (Add your implementation for option E here)

# Main menu function
main_menu() {
    clear
    echo "University Venue Management Menu"
    echo
    echo "A – Register New Patron"
    echo "B – Search Patron Details"
    echo "C – Add New Venue"
    echo "D – List Venue"
    echo "E – Book Venue"
    echo
    echo "Q – Exit from Program"
    echo
    read -p "Please select a choice: " choice

    case $choice in
        A|a)
            register_patron
            ;;
        B|b)
            search_patron
            ;;
        C|c)
            add_new_venue
            ;;
        D|d)
            list_venue_details
            ;;
        E|e)
            # Call the function to handle option E
            # book_venue
            ;;
        Q|q)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please select a valid option."
            read -p "Press Enter to continue..."
            main_menu
            ;;
    esac
}

# Call the main menu function to start the program
main_menu
