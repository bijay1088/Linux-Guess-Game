#!/bin/bash
username=$1 #taking username from user
userid=$2 #taking userid from user
extraoption=$3 #third parameter to check if user is giving additional value

#password for running program
secret="bijay1088"


#colours for text
RED='\033[0;31m'
NC='\033[0m'
LR='\033[1;31m'
GRE='\033[1;32m'
BLU='\033[1;34m'


#checking if user has given wrong value
if [ -z $extraoption ] #checking if third parameter is empty
then
	if [ -z "$username" ] || [ -z "$userid" ] #checking if username and userid is empty
	then
		echo -e "\n${LR}!!!ERROR!!!${NC}\nPlease Input your Name and ID after file name before executing it."
		echo -e "Example -----> Filename [UserName] [UserID]\n\n"
		exit #exiting if username and id is empty
	fi
else #if third parameter is empty
	echo -e "\n${LR}!!!ERROR!!!${NC}\nPlease Input only Name and ID after file name before executing it."
	echo -e "Example -----> Filename [UserName] [UserID]\n\n"
	exit #exiting if there is third parameter
fi 


echo "
__        _______ _     ____ ___  __  __ _____                                                              
\ \      / / ____| |   / ___/ _ \|  \/  | ____|
 \ \ /\ / /|  _| | |  | |  | | | | |\/| |  _|  
  \ V  V / | |___| |__| |__| |_| | |  | | |___ 
   \_/\_/  |_____|_____\____\___/|_|  |_|_____|

         
"

finalMembername(){

	echo
	echo
	#making select case with user input
	PS3="Please select any of these three band member (1-3): "
	select i in $mem1 $mem2 $mem3
	do
		case $i in
		
		FM | AY | KC) #if user input is FM, AY and KC
			echo -e "\n${BLU}Congrats, you guessed it right :)${NC}\n"
			cat $i #displaying user input file
			echo
			echo
			break
			;;
		$mem1 | $mem2 | $mem3) #if user guessed it wrong
			echo -e "\n${GRE}You guessed it wrong. Try again :(${NC}\n"
			bandname #calling bandname function 
			;;
		*) #if there is anything else input
			echo -e "\n${LR}!!!ERROR!!!${NC}\nPlease input correct number (1-3) only.\n"
			;;
			
		esac
	done
	while true #creating loop until user decides to play again or not
	echo -n "Would you like to play again [Y/N]?: "
	read again #taking user Y/N answer 
	do
		if [ -z $again ] #if user input is empty
		then
			echo "Please input valid answer"
			continue
		elif [ $again == "Y" ] || [ $again == "YES" ] #if user says Y
		then
			bandname
		elif [ $again == "N" ] || [ $again == "NO" ] #if user says N
		then
			echo "Bye :("
			exit
			break
		else #if there is anything else other than Y/N
			echo "Please input valid answer (YES/Y or NO/N)"
			continue
		fi
	done


}

selectmember(){
	echo -n "Please select any three members: "
	read mem1 mem2 mem3 mem4 #taking four value from user
	if [ -z $mem4 ] #if user doesn't give fourth value
	then
		if [ -z $mem1 ] || [ -z $mem2 ] || [ -z $mem3 ] #if first, second and third value is empty
		then
			echo -e "\n${LR}!!!ERROR!!!${NC}\nPlease Input any three code before executing it.\n"
			selectmember #calling selectmember function
		else
			#declaring values to check if given value are correct or not
			a=0
			b=1
			#declaring members name in array to compare with value
			for var in {"JL","AY","FM","DH","KC"}
			do
				if [ $mem1 == $var ] || [ $mem2 == $var ] || [ $mem3 == $var ] #comparing user input with correct value from array
				then
					a=$(( $a + $b )) #if value given by user is unique and correct, value increases in a
				fi
			done
			if [ $a == "3" ] #if user input is uniqe and correct, value of a will be 3, so program will continue
			then
				finalMembername #calling finalMembername function
			else #if user input is not correct
				echo -e "\n${LR}!!!ERROR!!!${NC}\nPlease select the codes from given option only and don't use same code multiple times.\n\n"
				selectmember #calling selectmember function
			
			fi
			
		fi
	else #if user gives fourth value
		echo -e "\n${LR}!!!ERROR!!!${NC}\nPlease select only three options.\n"
		selectmember #calling selectmember function
	fi
	
	
	
	
}

membername(){
	echo #listing members
	echo "
					-----------------------
					|   List of members   |
					-----------------------
					|JL | John Lennon     |
					|AY | Angus Young     |
					|FM | Freddie Mercury |
					|DH | Debbie Harry    |
					|KC | Kurt Cobain     |
					-----------------------
					"
	selectmember #calling selectmember function
}


selectband(){
	
	echo -n "Please select which of these bands is best music band: "
	read bestband #taking band name from user
	
	case $bestband in
		BEA | AD | BLO | NIR) #if band is not correct
			echo -e "\n${GRE}You guess it wrong. Try again :(${NC}\n"
			selectband #calling selectband function
			;;
		QUE) #if band is correct
			echo -e "\n${BLU}Congrats, you guessed it right :)${NC}\n"
			echo -e "About Queen\nQueen are a British rock band formed in London in 1970.\nQueen have record sales range from 170 million to 300 million, making them one of the world's best-selling music artists."
			echo
			membername #calling membername function
			;;
		*) #if there is anything else 
			echo -e "\n${LR}!!!ERROR!!!${NC}\nPlease type correct band code. Example: BEA\n"
			selectband #calling selectband function
			;;
	esac
	
	 
}


bandname(){
	#listing band names
	echo "
					-----------------
					|List of bands  |
					-----------------
					|BEA | Beatles  |
					|AD  | AC/DC    |
					|QUE | Queen    |
					|BLO | Blondie  |
					|NIR | Nirvana  |
					-----------------
					"
	selectband #calling selectband funcition
		

}


welcome(){
	#welcoming user
	echo ----------------------------------------------------------------------------
	echo Hello $username
	echo Your ID is $userid
	echo
	#showing date
	echo Current Date : $(date +%F)
	echo Current Time : $(date +%T)
	echo ----------------------------------------------------------------------------
	bandname #calling bandname function
	

}


#loop for secret key
for var in {1..3} #running loop 3 times
do
	echo -n "Enter the secret key: "
	read -s pass
	if [ $pass == $secret ] #if password is correct
	then
		echo "Correct Password"
		echo
		echo
		welcome #calling welcome function
		break
	else #if password is incorrect
		echo "Incorrect Password"
		continue 
	fi
done