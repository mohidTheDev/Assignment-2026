# Bandit Wargames
1. ## Level0
* Establish connection. 
```
ssh -p 2220 bandit0@bandit.labs.overthewire.org
```
2. ## Level0 -> Level1
* View the contents of the file to get the password for the next level.
```
cat readme
```

`Password: ZjLjTmM6FvvyRnrb2rfNWOZOTa6ip5If`

3. ## Level1 -> Level2
* Since this is a dashed file, we have to indicate that the "-" is not for an option of the cat command. 
```
cat ./-
```

`Password: 263JGJPfgU6LtdEvgfWU1XP5yac29mFx`

4. ## Level2 -> Level3
* This is a dashed file and also has spaces in between. 
* To manage the spaces, each of the spaces has to be escaped using backslashes to indicate that it is one file name.
```
cat ./--spaces\ in\ this\ filename--
```
`Password: MNk8KNH3Usiio41PRUEoDFPqfxLPlSmx`

5. ## Level3 -> Level4
* Go to the "inhere" directory. 
* List all files to find the file with the password.
* Read the file.
```
cd inhere
ls -a
cat ...Hiding-From-You
```
`Password: 2WmrDFRmJIq3IPxneAaMGhap0pFhF3NJ`

6. ## Level4 -> Level5
* Go to the "inhere" directory.
* List the file type of all files.
* Only one file is of type "ASCII text". Read it to get the password.
```
cd inhere
file ./-file*
cat ./-file07
```
`Password: 4oQYVPkxZOOEOO5pTW81FB8j8lxXGUQw`

7. ## Level5 -> Level6
* The -size option allows to specify the size and -executable finds only executable files. 
* By adding "!" before -executable, the effect is reversed and only files which aren't executable are shown. 
* These two options alone narrow done the search to a single file and looking for human readable is not needed. 
* Get the password from the file.
```
cd inhere
find -size 1033c ! -executable
cat maybehere07/.file2
```
`Password: HWasnPhtq9AVKe0dmk45nxy20cvUa6EG`

8. ## Level6 -> Level7
* Go to the root directory. 
* Find command has options for each of the requirements.
* All files in the list except one have "permission denied". 
* Find the password in the one file which is accessible. 
```
cd /
find -user bandit7 -group bandit6 -size 33c
cat ./var/lib/dpkg/info/bandit7.password
```
`Password: morbNTDkSW6jIlUc0ymOdMaLnOlFVAaj`

9. ## Level7 -> Level8
* Use the grep command to find specific string in file. 
```
grep "millionth" data.txt
```
`Password: dfwvzFQi4mU0wfNbFOe9RoWskMLg7eEc`

10. ## Level8 -> Level9
* `sort` command outputs all the lines in order and as a result identical lines occur next to each other. 
* Then pipe this output to `uniq -u` which shows only the line with no identical neighbours.
```
sort data.txt | uniq -u
```
`Password: 4CKMh1JI91bUIZZPXDqGanal4xvAg0JM`

11. ## Level9 -> Level10
* List all the human readable strings in the file.
* Password can be found in the output, preceeded by several "=".
```
strings data.txt
```
`Password: FGUW5ilLVJrxX9kMYMmlN4MgbpfMiqey`

12. ## Level10 -> Level11
* Decode the file.
```
base64 -d data.txt
```
`Password: dtR173fZKb0RRsDFSGsg2RWnpNVj3qRr`

13. ## Level11 -> Level12
* This rotation of letters by 13 positions is called the Rot13 cipher. 
* It can be decoded using the `tr` command, by defining the Rot13 conversion.
* `cat` to output the contents of the file and pipe it to use as the input for `tr`.
```
cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'
```
`Password: 7x16WNeHIi5YkIhWsfFIqoognUTyj9Q4`

14. ## Level12 -> Level13
* This exercise requires multiple files to be made. 
* So, go to /tmp, create a new directory there and copy the given file to this location 
* It is given that the file is a hex dump of a file compressed multiple times. So, we must work in reverse order.
* First decode the hexdump into a new file.
* Check the file type of this file. It is a gzip compressed file.
* Since the gzip utility expects a .gz extension rename the file, adding the extension.
* Then decompress the file. Check its file type again using `file file1`. It is a bzip2 compressed file.
* Rename to give appropriate extension. Decompress.
* Check file type again. Now, it is a gzip compressed file again.
*  Again, rename and decompress using gzip. Check file type now. It is a POSIX tar archive.
* Extract its contents. `ls` to see that a new file "data5.bin" is present in the directory.
* Check its type to find that it is also a POSIX tar archive. Extract from it too to find a "data6.bin". 
* Check its type. It is a bzip2 compressed file. Rename and decompress as before. 
* Check type of resultant "data6". It is a POSIX tar archive.
* Extract from it to get "data8.bin". Check type. It is a gzip compressed file. Rename and decompress.
* Check the file type to find that "data8" is ASCII text (finally). Read it to get the password.
```
cd /tmp
cp /home/bandit12/data.txt data.txt
xxd -r data.txt file1
file file1
mv file1 file1.gz
gzip -d file1.gz
file file1
mv file file1.bz2
bzip2 -d file1.bz2
file file1
mv file1 file1.gz
gzip -d file1.gz
file file1
tar -xf file1
ls
file data5.bin
tar -xf data5.bin
ls
file data6.bin
mv data6.bin data6.bz2
bzip2 -d data6.bz2
file data6
tar -xf data6
ls
file data8.bin
mv data8.bin data8.gz
gzip -d data8.gz
file data8
cat data8
```
`Password: FO5dwFsc0cbaIiH0h8J2eUks2vdTDwAn`

15. ## Level13 -> Level14
* We do not have access to the password as bandit13 but the private SSH key to login as bandit14 is given.
* Copy the key and log out
* Create a file locally and copy this key into the file. Since ssh private key files are required to be secure, change permissions such that only owner can read and write.
* This file can now be used to login as bandit14
* Get the password from the file mentioned.
```
touch key
nano key
chmod 600 key
ssh -i ./key -p 2220 bandit14@bandit.labs.overthewire.org
cat /etc/bandit_pass/bandit14
```

`Password: MU4VWeTyJk8ROof1qqmcBPaLh7lDCPvS`

16. ## Level14 -> Level15
* Connect to the given port using `nc`. 
* Enter the password of this level to get the password for the next level as output.
```
nc localhost 30000
MU4VWeTyJk8ROof1qqmcBPaLh7lDCPvS
```
`Password: 8xCjnmgoKbGLhHFAZlGE5Tmu4M2tKJQo`

17. ## Level15 -> Level16
* Establish connection using openssl.
* Type the password for this level to get password for next level.
```
openssl s_client -connect localhost:30001
8xCjnmgoKbGLhHFAZlGE5Tmu4M2tKJQo
```
`Password: kSkvUpMQ7lBYyCM4GBPvCvT1BfWRy0Dx`

18. ## Level16 -> Level17
* `nmap` to see a list of available ports with their service and versions. 
* In the list most have "echo" as their service, one has "SSL/echo" and the last has "SSL/unknown". 
* Since we do not wish to connect to the ports which simply echo the input, connect to the port with "SSL/unknown"
* `-quiet` option is required so that it does not mistake the "k" in the password for an interactive command.
* Entering the password now gives the SSH private key for the next level.
```
nmap -p 31000-32000 -sV localhost
openssl s_client -connect localhost:31790 -quiet
kSkvUpMQ7lBYyCM4GBPvCvT1BfWRy0Dx
```

19. ## Level17 -> Level18
* Use the `diff` command to output the difference between the two files.
* The first line is the different line in passwords.new, this is the password we want. 
* The second line is the different line in passwords.old.
```
diff passwords.new passwords.old
```
`Password: x2gLTTjFwMOhQ8oWNbMN362QKxfRqGlO`

20. ## Level18 -> Level19
* A command can be executed in the remote host instead using login shell by writing the command succeeding the ssh connecting command. 
* So, we do not have to login to get the password.
* We are asked the password. Once we enter, the password for the next level is shown.
```
sh -p 2220 bandit18@bandit.labs.overthewire.org cat readme
x2gLTTjFwMOhQ8oWNbMN362QKxfRqGlO
```
`Password: cGWpMaKXVwDUNgPAVJbWYuGHVn9zl3j8`

21. ## Level19 -> Level20
* `ls -l` to see that the file bandit20-do has "s" in the owner's permission block.
* Running this program should allow access to files bandit20 has access to.
* You are basically running the `cat /etc/bandit_pass/bandit20` command with the permissions of bandit20, allowing you to read the file.
```
ls -l
./bandit20-do cat /etc/bandit_pass/bandit20
```
`Password: 0qXahG8ZjOVMN9Ghs7iOWsCfZyXOUbYO`

22. ## Level20 -> Level21
* See what programs are available. One setuid binary is available. 
* Run the program without options to find out what it does. It connects to the specified port on localhost and waits to receive the correct password. If it does, it sends the next level password. 
* Run the program with a random port.
* Open another bash window and login as bandit20 again. Start listening to the same port. 
* Now, here, enter the password for this level. 
* In the first window, we see confirmation that the program has received the right password and is sending the next one. 
* On the second window, the next password is given as output.
```
//First shell instance
ls
./suconnect
./suconnect 9889
```
```
//Second shell instance
nc -l -p 9889
0qXahG8ZjOVMN9Ghs7iOWsCfZyXOUbYO
```
`Password: EeoULMCra2q0dSkYj561DX7s1CpBuOBt`
