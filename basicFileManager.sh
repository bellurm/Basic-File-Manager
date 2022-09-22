#! /bin/bash

#FILE OPERATIONS

# Is file exists?
function isFileExists() {

	if [ -f $fileName ]
	then

		echo -e "$fileName is exists. What do you want?\n"
		
		select existOperations in "Write into the file" "Delete the file"
		do
			if [[ $existOperations == "Write into the file" ]]
			then
				writeIntoFile
				break
				
			elif [[ $existOperations == "Delete the file" ]]
			then
				deleteFile
				break
			else
				echo "Please, follow the list."
			fi
			
		done
	else
		createNewFile
	fi
}


# Write someting into the file.
function writeIntoFile() {
	read -p "File name: " fileName
	read -p "Your text: " text
	if [ -f $fileName ]
	then
	
		echo >> $fileName $text
		echo -e "Done\n"
	else
		touch $fileName
		echo >> $fileName $text
		echo "File not found but created and wrote."
	fi
}


# Create a new file.
function createNewFile() {
	read -p "The file is not exitst. Do you want to create a new file? (y/n)" createFile
	
	if [ $createFile == "y" -o $createFile == "Y" ]
	then
		touch $fileName
		echo -e "Done.\n"
		
		read -p "The file has been created. Do you want to write into the file something? (y/n)" write
		
		if [ $write == 'y' -o $write == 'Y' ]
		then
			writeIntoFile
		elif [ $write == 'n' -o $write == 'N' ]
		then
			echo "Good Luck!"
			
		else
			echo "Please, 'y' or 'n'."
		fi
		
	elif [ $createFile == "n" -o $createFile == "N" ]
	then
		echo "Good Luck!"
		
	else
		echo "Please, 'y' or 'n'."
	fi
}


# Delete the exists file.
function deleteFile() {
	read -p "Dou you want to delete the file? (y/n)" deleteFile
	
	if [ $deleteFile == "y" -o $deleteFile == "Y" ]
	then
		read -p "File name: " fileName
		
		rm -rf $fileName
		echo -e "Done.\n"
		
	elif [ $deleteFile == "n" -o $deleteFile == "N" ]
	then
		echo "Good Luck!"
		
	else
		echo "Please, 'y' or 'n'."
	fi
}


#DIRECTORY OPERATIONS

# Is directory exists?
function isDirExists() {

	
	if [ -d $dirName ]
	then
		echo "$dirName is exists."
		
		select existsOperations in "Delete the directory" "Create file into the directory" "Write into the exists file"
		do
			
			if [[ $existsOperations == "Delete the directory" ]]
			then
				deleteDir
			elif [[ $existsOperations == "Create file into the directory" ]]
			then
				cd $dirName
				read -p "File name: " fileName
				createNewFile
			elif [[ $existsOperations == "Write into the exists file" ]]
			then
				cd $dirName
				writeIntoFile
			else
				echo "Please, follow the list."
			fi
		
		done
		
	else
		echo "'$dirName' is not exists."
		createNewDir
	fi

}

# Create a new directory.
function createNewDir() {
	read -p "Do you want to create the directory? (y/n)" createDir
	if [ $createDir == "y" -o $createDir == "Y" ]
	then
		mkdir $dirName
		echo -e "Done.\n"
		
	elif [ $createDir == "n" -o $createDir == "N" ]
	then
		echo "Good Luck!"
		
	else
		echo "Please, 'y' or 'no'."
	fi
}


# Delete the exists directory.
function deleteDir() {
	
	read -p "Do you want to delete the directory? (y/n)" deleteTheDir
	if [ $deleteTheDir == "y" -o $deleteTheDir == "Y" ]
	then
		cd
		cd $dirLocation
		rm -rf $dirName
		echo -e "Done.\n"
	elif [ $deleteTheDir == "n" -o $deleteTheDir == "N" ]
	then
		echo "Good Luck!"
	else
		echo "Please, 'y' or 'n'."
	fi
}

# Main menu and the script starts with this.
select operations in "Control a file" "Control a directory"
do
	cd
	
	if [[ $operations == "Control a file" ]]
	then
		read -p "File's location: " fileLocation
		cd $fileLocation
		read -p "File's name: " fileName
		isFileExists
		
	elif [[ $operations == "Control a directory" ]]
	then
		read -p "Directory's location: " dirLocation
		cd $dirLocation
		read -p "Directory's name: " dirName
		isDirExists
		
	else
		echo "Please, follow the list."
	fi
done
