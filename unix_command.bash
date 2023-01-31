#Z. Roth
#Purpose of program: Create menu with several options, common UNIX commands

#!/bin/bash     # hash-bang (required)  

#FUCNTION LIST

# press any key to continue function
press_to_continue() {
echo -ne "Press any key to continue..."
read -n 1 # read user pressing one key on keyboard 
clear # clear screen of all displayed output
}

# press any key to return to MAIN MENU function 
press_any_key_return_to_menu() {
	echo -n "Press any key to return to MAIN MENU..." # prompts user to press any key on keyboard to return to main menu
        read -n 1
        clear
}

#calendar directions function
calendar_directions(){
        echo -ne "\n\nDIRECTIONS:"  # directions of user input entry to prevent user error 
        sleep 1.2s     # pauses using sleep command for a set amount of seconds before executing next line
        echo -ne "\n\n1. When entering the month, please specify by entering a number between 1-12." # notifies user of month entry requirements
        sleep 2s
        echo -ne "\n\nFor example:" # display examples to prevent input error 
        sleep 1s
        echo -ne "\n\nJAN = 1  FEB = 2  MAR = 3"
        sleep 1.2s
        echo -ne "\nAPR = 4  MAY = 5  JUN = 6"
        sleep 1.2s
        echo -ne "\nJUL = 7  AUG = 8  SEP = 9"
        sleep 1.2s
        echo -ne "\nOCT =10  NOV =11  DEC =12\n"
        sleep 2s
        echo -ne "\n2. When entering the year, keep it between 1900-2030!"  # notifies user of year entry requirements
        sleep 3s
        echo
        echo
}

# calendar month entry function
calendar_month(){
        echo -ne "\nPlease enter the month: "
        read month  # user enters desired month

        until [[ "$month" -le 12 && "$month" -ge 1 ]] # until user entere month between 1-12
        do
            error_message # error message function called
            echo -ne "\nI'm sorry, that's an invalid response, please try again..." # notifies user of invalid response 
            sleep 2s
            clear
            echo -ne "\nPlease enter the month: " # user prompted to reattempt input
            read month # if first attempt fails, user asked to reenter valid month 
        done
        clear
}

# calendar year entry function
calendar_year(){
        echo -ne "\nPlease enter the year: "
        read year  # user inputs desired year
        until [[ "$year" -le 2030 && "$year" -ge 1900 ]] # until 1900 - 2030 condition is met...
        do
            error_message
            echo -ne "\nI'm sorry, that's an invalid response, please try again..."
            sleep 2s
            clear
            echo -ne "\nPlease enter the year: " 
            read year  # if first attempt fails,  user again asked to enter  desired year
        done
        clear
}

# change directory function
change_directory(){
	echo -ne "\nType the name of the directory you'd like to go to: " # print statement asking user to for directory name
	read newdirectory # user enters directory name 
	if [ -d "$newdirectory" ]    # check to see if user input is directory
            then
                cd "$newdirectory"   # change to new directory  
        elif [ "$newdirectory" = "$HOME" ] # if user enters $HOME, changes to home directory
            then
                cd
        elif [ "$newdirectory" = "~" ]  # if user enters tilde symbol, changes to home directory
            then
                cd
	elif [ -z "$newdirectory" ] # if user input is empty, changes to home directory 
	    then
		cd
        else
            echo -e "$newdirectory could not be found.\n"  # if user input is invalid, prints to notify user             
	    cd     # changes to home directory 
	fi  # signifies end of if/elif/else statements
}

# error message function
error_message() {
clear
for (( i = 0; i < 3; i++ ))  # for loop repeating printed error message three times
    do
	echo -e "\n!!!!!!!!!!!!"
        echo "!!!!!!!!!!!!"
        echo "!!!!!!!!!!!!"
        sleep 0.4s # pauses 
        clear
        sleep 0.4s
        done # for loop finished  
}

# while loop whose condition is if user enters anything other than the number 9 (quit option) it will continue to execute
while [[ "$selection_answer" != "9" ]]  

do # if while loop condtition is true, continue to exectute the statements below                                                  
clear
# command menu which displays options available to user (numbers 1-9) 
echo -e "\n    *********************************"
echo -e "    * WELCOME TO ZACH'S MAIN MENU *"
echo -e "    ********************************\n"
echo " 1.  Who is logged in?"
echo " 2.  Display calendar for a specific month and year"
echo " 3.  Current directory path"
echo " 4.  Change directory"
echo " 5.  Listing of visible files in current directory"
echo " 6.  Display current time/date and calendar "
echo " 7.  Open vi editor"
echo " 8.  Email a file to a user"
echo -e " 9.  Quit\n"
read -p "  Make your selection: " selection_answer # user enters desired option from menu options (1-9)
clear 

# case numbers with associated commands for each number option user can choose (1-9) 
case "$selection_answer" in 
    1)
	# displays users currently logged onto system, returns to COMMAND MENU when user quits who command
	echo -ne "\nUsers currently logged on:" 
	sleep 1.5s
	echo -ne "\n\nNOTE:" # important program instructions 
	sleep 1s
	echo -ne "\n\n1. To scroll through results, use the space bar or up and down arrow keys"
	sleep 2s 
	echo -e "\n2. To exit results, simply press q on your keyboard" 
	echo -ne  "   to return back to the main menu.\n\n"
	sleep 2.5s
	press_to_continue  # function is called, in this case the press_to_continue function (found at top of bash script) 
	who -H | column -t | less  # who command including column headings, piped into column command with table option,  
	clear                      # then piped into less to allow easier reading of results
	;;  # signifies termination of each clause (or menu option) 
    2)
	# diplays calandar month and year of users choosing 
	echo -ne "\nDisplay a calendar for a specific month and year of your choosing."
        sleep 2s
        calendar_directions
	echo
	echo
	press_to_continue 
	calendar_month
	calendar_year
	# prints requested output of month and calendar year user entered
	echo -e "\nHere is the calendar you requested:\n "
	cal "$month" "$year" # cal command including user month and year input
	sleep 2.5s
	echo
        press_any_key_return_to_menu
	;;
    3)
	# displays current directory path
	echo -e "\nYour current working path is:\n" 
	pwd  # command to print working directory
	echo
	sleep 1.5s
        press_any_key_return_to_menu
	;;
    4) 
	# allows users to change directories
	change_directory 	
	echo
	press_any_key_return_to_menu
	;;
    5)	
	# displays a long listing of files in users working directory
	echo -ne "\nHere is a long listing of the visible files in your current directory:"
	sleep 2s
	echo -ne "\n\nPERMISSIONS  USERNAME   GROUP    SIZE  DATE  TIME  NAME     "  # print out catagories, lined up with columns 
	echo
	ls -lh | more # long listing (human-readable) piped into more for readability if needed
	sleep 2s		   
	echo
	press_any_key_return_to_menu
	;;
    6)	
	# displays the current date and calendar
	echo -e "\nThe date is: `date`" # display date, single quotes around date command in order to properly display output 
	echo
	echo "The current calendar is: "
	echo
	cal  # calander command 
	sleep 2s
	press_any_key_return_to_menu
        ;;
    7)
	# vi editor program 
	echo -ne "\nWhat is the name of the file you'd like to edit? (leave blank for new file): " # program instructions
	read file_name  # user enters name of new vi file

	if [ -f "$file_name" ] && file --mime $file_name | grep -q 'text'  # verify file is valid (text, not binary/directory) grep with quiet option for keyword 'text'
	    then                                                           
		vi "$file_name"  # open vi file with name user entered 
	elif file --mime $file_name | grep -q "binary\|directory"  # if file name is binary OR (\|) directory, grep with quiet option for keywords
	    then
		echo -ne "\nBinary files or directories are not allowed." # notifies user inputted files are not allowed
		sleep 1s
		echo
		echo
		press_any_key_return_to_menu
	else  #if no input is entered, opens up new vi file 
	    vi
	fi
	;;
    8)
	# emailer program
	echo -n "Enter the subject: "
	read subject # user enters subject of email message
	
        echo -n "Please enter recipient name (ex: first.last1): "
        read recipient # user enters recipient address 
        if grep -c $recipient /etc/passwd > 0  # check to see if match found in /etc/passwd file
            then
                echo -e "Match was found."  # successful match
        else
            echo -e "\nUnable to find user..."  # search couldn't find reciipient address user entered 
        fi

        echo -n "Please enter a file to attach: "
        read file_attachment # user enters file to attach to new message

        if [ -f $file_attachment ] && file --mime-type $file_attachment | grep -q 'text' # checks to see if file is valid type (same command as in vi editor #7)
            then                                                                    # and searches till  match is found 
                mail -s "$subject" "$recipient" < "$file_attachment"  # mail command with user input included 
                echo -ne "\nMessage sent!"  # user notified that message was sent 
#        elif file --mime $file_name | grep -q "binary\|directory"   # if file type isn't valid (same command as in vi editor #7)
	elif [ -e $file_attachment ]
            then
                echo -ne "\nNot a valid file type."
        else
            echo -ne "\nFile was not found..."  # else statement if unable to locate file requested
        fi	
	sleep 1s
	echo
	echo
	press_any_key_return_to_menu
	;;
    9)
	# thanks user for using the program, returns to shell prompt
        echo -ne  "^_^ Thanks for using my program! ^_^  "
	sleep 1s
	clear
 	;;
    *)
	# catch all if user enters numbers that are not available options on the main menu
	# notifies user that what they selected is not an available option on MAIN MENU
	# redirects erorr messages to /dev/null so they won't displayed to standard output 
	error_message
	echo -ne "\nThere is no selection: $selection_answer" 2>/dev/null
	sleep 2s
	clear
	# asks user to attempt again, then returns to COMMAND MENU
	echo -ne "\nPlease try again..."
	sleep 2s
	clear 
	;;                                               
# esac ends the case statement, much like "fi" would indicate the end of a "if-else" statement 
esac
 
# while loop has finished executing; program terminates back to shell prompt 