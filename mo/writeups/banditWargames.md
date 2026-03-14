Bandit Wargames

Level0
establish connection using `ssh -p 2220 bandit0@bandit.labs.overthewire.org`
`cat readme` to see the contents of the file and get the password for the next level.
Password: ZjLjTmM6FvvyRnrb2rfNWOZOTa6ip5If

Level1
Since this is a dashed file, we have to indicate that the "-" is not for an option of the cat command. So, `cat ./-` to get the next password.
Password: 263JGJPfgU6LtdEvgfWU1XP5yac29mFx

Level2
This is a dashed file and also has spaces in between. To manage the spaces, each of the spaces has to be escaped using backslashes to indicate that it is one file name.
`cat ./--spaces\ in\ this\ filename--`
Password: MNk8KNH3Usiio41PRUEoDFPqfxLPlSmx

Level3
First go to the inhere directory using `cd inhere`. To find the hidden file use `ls -a`.
To get the password, `cat ...Hiding-From-You`
Password: 2WmrDFRmJIq3IPxneAaMGhap0pFhF3NJ

Level4
`cd inhere` and `file ./-file*` to list the file types of all the files. Only one is of the type ASCII text. Get the password from that file.
Password: 4oQYVPkxZOOEOO5pTW81FB8j8lxXGUQw

Level5
`cd inhere`. `find -size 1033c ! -executable`. The -size option allows to specify the size and -executable finds only executable files. By adding "!" before -executable, the effect is reversed and only files which aren't executable are shown. These two options alone narrow done the search to a single file and looking for human readable is not needed. Get the password from the file.
Password: HWasnPhtq9AVKe0dmk45nxy20cvUa6EG

Level6
`cd /` to go to the root directory. Find command has options for each of the requirements. Do `find -user bandit7 -group bandit6 -size 33c` to get a list of files. All files in the list except one have "permission denied". Find the password in the one file which is accessible. `cat ./var/lib/dpkg/info/bandit7.password`
Password: morbNTDkSW6jIlUc0ymOdMaLnOlFVAaj

Level7
Use the grep command to find specific string in file. `grep "millionth" data.txt`
Password: dfwvzFQi4mU0wfNbFOe9RoWskMLg7eEc

Level8
`sort data.txt | uniq -u`. `sort` command outputs all the lines in order and as a result identical lines occur next to each other. This output is then piped to `uniq -u` which shows only the line with no identical neighbours.
Password: 4CKMh1JI91bUIZZPXDqGanal4xvAg0JM

Level9
All the human readable strings in the file can be listed using `strings data.txt`. Password can be found in the output, preceeded by several "=".
Password: FGUW5ilLVJrxX9kMYMmlN4MgbpfMiqey

Level10
The file can be decoded using `base64 -d data.txt`
Password: dtR173fZKb0RRsDFSGsg2RWnpNVj3qRr

Level11
This rotation of letters by 13 positions is called the Rot13 cipher. It can be decoded using the `tr` command, by defining the Rot13 conversion.
`cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'`
`cat` to output the contents of the file and pipe it to use as the input for `tr`
Password: 7x16WNeHIi5YkIhWsfFIqoognUTyj9Q4

Level12
This exercise requires multiple files to be made. So, cd to /tmp, create a new directory there and copy the given file to this location using `cp /home/bandit12/data.txt data.txt`.
It is given that the file is a hex dump of a file compressed multiple times.
So, we must work in reverse order. 
First decode the hexdump into a new file using
`xxd -r data.txt file1`
Check the file type of this file using `file file1`. It is a gzip compressed file. 
Since the gzip utility expects a .gz extension rename the file using `mv file1 file1.gz`. 
Then decompress using `gzip -d file1.gz`. Check its file type again using `file file1`. It is a bzip2 compressed file. 
Rename to give appropriate extension `mv file file1.bz2`. Decompress using `bzip2 -d file1.bz2`. 
Check file type again using `file file1`. Now, it is a gzip compressed file again.
 Again, rename and decompress using gzip. Check file type now. It is a POSIX tar archive. 
`tar -xf file1` to extract its contents. `ls` to see that a new file "data5.bin" is present in the directory. 
Check its type to find that it is also a POSIX tar archive. extract from it too to find a "data6.bin". Check its type. 
It is a bzip2 compressed file. Rename and decompress as before. Check type of resultant "data6". It is a POSIX tar archive. 
Extract from it to get "data8.bin". Check type. It is a gzip compressed file. Rename and decompress. 
Check the file type to find that "data8" is ASCII text (finally). `cat data8` to get the password.
Password: FO5dwFsc0cbaIiH0h8J2eUks2vdTDwAn

Level13
We do not have access to the password as bandit13 but the private SSH key to login as bandit14 is given.
Private SSH key:
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEAxkkOE83W2cOT7IWhFc9aPaaQmQDdgzuXCv+ppZHa++buSkN+
gg0tcr7Fw8NLGa5+Uzec2rEg0WmeevB13AIoYp0MZyETq46t+jk9puNwZwIt9XgB
ZufGtZEwWbFWw/vVLNwOXBe4UWStGRWzgPpEeSv5Tb1VjLZIBdGphTIK22Amz6Zb
ThMsiMnyJafEwJ/T8PQO3myS91vUHEuoOMAzoUID4kN0MEZ3+XahyK0HJVq68KsV
ObefXG1vvA3GAJ29kxJaqvRfgYnqZryWN7w3CHjNU4c/2Jkp+n8L0SnxaNA+WYA7
jiPyTF0is8uzMlYQ4l1Lzh/8/MpvhCQF8r22dwIDAQABAoIBAQC6dWBjhyEOzjeA
J3j/RWmap9M5zfJ/wb2bfidNpwbB8rsJ4sZIDZQ7XuIh4LfygoAQSS+bBw3RXvzE
pvJt3SmU8hIDuLsCjL1VnBY5pY7Bju8g8aR/3FyjyNAqx/TLfzlLYfOu7i9Jet67
xAh0tONG/u8FB5I3LAI2Vp6OviwvdWeC4nOxCthldpuPKNLA8rmMMVRTKQ+7T2VS
nXmwYckKUcUgzoVSpiNZaS0zUDypdpy2+tRH3MQa5kqN1YKjvF8RC47woOYCktsD
o3FFpGNFec9Taa3Msy+DfQQhHKZFKIL3bJDONtmrVvtYK40/yeU4aZ/HA2DQzwhe
ol1AfiEhAoGBAOnVjosBkm7sblK+n4IEwPxs8sOmhPnTDUy5WGrpSCrXOmsVIBUf
laL3ZGLx3xCIwtCnEucB9DvN2HZkupc/h6hTKUYLqXuyLD8njTrbRhLgbC9QrKrS
M1F2fSTxVqPtZDlDMwjNR04xHA/fKh8bXXyTMqOHNJTHHNhbh3McdURjAoGBANkU
1hqfnw7+aXncJ9bjysr1ZWbqOE5Nd8AFgfwaKuGTTVX2NsUQnCMWdOp+wFak40JH
PKWkJNdBG+ex0H9JNQsTK3X5PBMAS8AfX0GrKeuwKWA6erytVTqjOfLYcdp5+z9s
8DtVCxDuVsM+i4X8UqIGOlvGbtKEVokHPFXP1q/dAoGAcHg5YX7WEehCgCYTzpO+
xysX8ScM2qS6xuZ3MqUWAxUWkh7NGZvhe0sGy9iOdANzwKw7mUUFViaCMR/t54W1
GC83sOs3D7n5Mj8x3NdO8xFit7dT9a245TvaoYQ7KgmqpSg/ScKCw4c3eiLava+J
3btnJeSIU+8ZXq9XjPRpKwUCgYA7z6LiOQKxNeXH3qHXcnHok855maUj5fJNpPbY
iDkyZ8ySF8GlcFsky8Yw6fWCqfG3zDrohJ5l9JmEsBh7SadkwsZhvecQcS9t4vby
9/8X4jS0P8ibfcKS4nBP+dT81kkkg5Z5MohXBORA7VWx+ACohcDEkprsQ+w32xeD
qT1EvQKBgQDKm8ws2ByvSUVs9GjTilCajFqLJ0eVYzRPaY6f++Gv/UVfAPV4c+S0
kAWpXbv5tbkkzbS0eaLPTKgLzavXtQoTtKwrjpolHKIHUz6Wu+n4abfAIRFubOdN
/+aLoRQ0yBDRbdXMsZN/jvY44eM+xRLdRVyMmdPtP8belRi2E2aEzA==
-----END RSA PRIVATE KEY-----
Log out
Create a file locally and copy this key into the file. Since ssh private key files are required to be secure, do `chmod 600 key` (Read write permission to owner)
This file can now be used to login as bandit14
`ssh -i ./key -p 2220 bandit14@bandit.labs.overthewire.org`
To get the password, `cat /etc/bandit_pass/bandit14`
Password: MU4VWeTyJk8ROof1qqmcBPaLh7lDCPvS

Level14
To connect to the given port do `nc localhost 30000`. Enter the password of this level to get the password for the next level as output.
Password: 8xCjnmgoKbGLhHFAZlGE5Tmu4M2tKJQo

Level15
Establish connection using `openssl s_client -connect localhost:30001`
Type the password for this level to get password for next level.
Password: kSkvUpMQ7lBYyCM4GBPvCvT1BfWRy0Dx

Level16
`nmap -p 31000-32000 -sV localhost` shows a list of available ports with their service and versions. In the list most have "echo" as their service, one has "SSL/echo" and the last has "SSL/unknown". Since we do not wish to connect to the ports which simply echo the input, connect to the port with "SSL/unknown"
`openssl s_client -connect localhost:31790 -quiet`. `-quiet` option is required so that it does not mistake the "k" in the password for an interactive command.
Entering the password now gives the SSH private key for the next level.
-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEAvmOkuifmMg6HL2YPIOjon6iWfbp7c3jx34YkYWqUH57SUdyJ
imZzeyGC0gtZPGujUSxiJSWI/oTqexh+cAMTSMlOJf7+BrJObArnxd9Y7YT2bRPQ
Ja6Lzb558YW3FZl87ORiO+rW4LCDCNd2lUvLE/GL2GWyuKN0K5iCd5TbtJzEkQTu
DSt2mcNn4rhAL+JFr56o4T6z8WWAW18BR6yGrMq7Q/kALHYW3OekePQAzL0VUYbW
JGTi65CxbCnzc/w4+mqQyvmzpWtMAzJTzAzQxNbkR2MBGySxDLrjg0LWN6sK7wNX
x0YVztz/zbIkPjfkU1jHS+9EbVNj+D1XFOJuaQIDAQABAoIBABagpxpM1aoLWfvD
KHcj10nqcoBc4oE11aFYQwik7xfW+24pRNuDE6SFthOar69jp5RlLwD1NhPx3iBl
J9nOM8OJ0VToum43UOS8YxF8WwhXriYGnc1sskbwpXOUDc9uX4+UESzH22P29ovd
d8WErY0gPxun8pbJLmxkAtWNhpMvfe0050vk9TL5wqbu9AlbssgTcCXkMQnPw9nC
YNN6DDP2lbcBrvgT9YCNL6C+ZKufD52yOQ9qOkwFTEQpjtF4uNtJom+asvlpmS8A
vLY9r60wYSvmZhNqBUrj7lyCtXMIu1kkd4w7F77k+DjHoAXyxcUp1DGL51sOmama
+TOWWgECgYEA8JtPxP0GRJ+IQkX262jM3dEIkza8ky5moIwUqYdsx0NxHgRRhORT
8c8hAuRBb2G82so8vUHk/fur85OEfc9TncnCY2crpoqsghifKLxrLgtT+qDpfZnx
SatLdt8GfQ85yA7hnWWJ2MxF3NaeSDm75Lsm+tBbAiyc9P2jGRNtMSkCgYEAypHd
HCctNi/FwjulhttFx/rHYKhLidZDFYeiE/v45bN4yFm8x7R/b0iE7KaszX+Exdvt
SghaTdcG0Knyw1bpJVyusavPzpaJMjdJ6tcFhVAbAjm7enCIvGCSx+X3l5SiWg0A
R57hJglezIiVjv3aGwHwvlZvtszK6zV6oXFAu0ECgYAbjo46T4hyP5tJi93V5HDi
Ttiek7xRVxUl+iU7rWkGAXFpMLFteQEsRr7PJ/lemmEY5eTDAFMLy9FL2m9oQWCg
R8VdwSk8r9FGLS+9aKcV5PI/WEKlwgXinB3OhYimtiG2Cg5JCqIZFHxD6MjEGOiu
L8ktHMPvodBwNsSBULpG0QKBgBAplTfC1HOnWiMGOU3KPwYWt0O6CdTkmJOmL8Ni
blh9elyZ9FsGxsgtRBXRsqXuz7wtsQAgLHxbdLq/ZJQ7YfzOKU4ZxEnabvXnvWkU
YOdjHdSOoKvDQNWu6ucyLRAWFuISeXw9a/9p7ftpxm0TSgyvmfLF2MIAEwyzRqaM
77pBAoGAMmjmIJdjp+Ez8duyn3ieo36yrttF5NSsJLAbxFpdlc1gvtGCWW+9Cq0b
dxviW8+TFVEBl1O4f7HVm6EpTscdDxU+bCXWkfjuRb7Dy9GOtt9JPsX8MBTakzh3
vBgsyi/sN3RqRBcGU40fOoZyfAMT8s1m/uYv52O6IgeuZ/ujbjY=
-----END RSA PRIVATE KEY-----

Level17
`diff passwords.new passwords.old` outputs the difference between the two files.
The first line is the different line in passwords.new, this is the password we want. The second line is the different line in passwords.old.
Password: x2gLTTjFwMOhQ8oWNbMN362QKxfRqGlO

Level18
A command can be executed in the remote host instead using login shell by writing the command succeeding the ssh connecting command. So, we do not have to login to get the password. 
`sh -p 2220 bandit18@bandit.labs.overthewire.org cat readme`
We are asked the password. Once we enter, the password for the next level is shown.
Password: cGWpMaKXVwDUNgPAVJbWYuGHVn9zl3j8

Level19
`ls -l` to see that the file bandit20-do has "s" in the owner's permission block. Running this program should allow access to files bandit20 has access to.
`./bandit20-do cat /etc/bandit_pass/bandit20`. You are basically running the `cat /etc/bandit_pass/bandit20` command with the permissions of bandit20, allowing you to read the file.
Password: 0qXahG8ZjOVMN9Ghs7iOWsCfZyXOUbYO

Level20
`ls` to see what programs are available. One setuid binary is available. Run the program without options `./suconnect` to find out what it does. It connects to the specified port on localhost and waits to receive the correct password. If it does, it sends the next level password. Run the program with a random port `./suconnect 9889`.
Open another bash window and login as bandit20 again. Start listening to the same port using `nc -l -p 9889`. Now, here, enter the password for this level. In the first window, we see confirmation that the program has received the right password and is sending the next one. On the second window, the password becomes visible.
Password: EeoULMCra2q0dSkYj561DX7s1CpBuOBt
