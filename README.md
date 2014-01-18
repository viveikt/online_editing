Online Editing
==============

Hi,

Requirements:

1. ruby 1.9.3
2. Tortoise svn command line ticked in installer
Here is the description:

1. register.rb has all the necessary things to register & start a windows service.
2. The above file runs a file called oe.rb in the same folder.
3. There is a folder called stop inside which the unregister.rb will unregister the windows service.

Steps:

1. There are 2 ways to start the service both gives me the same error.

$ ruby register.rb

OR

$ sc start testservice

NOTES:

Add
  
Requirement:

1. create a tmp folder some where
2. checkout a file from a repository to that location
3. create a process
4. open the file with its default editor
5. check for the below commands
def load_notepad
pid = Process.spawn("notepad.exe")
puts "before wait"
Process.wait pid
puts "after wait"
end
6. If response code received and file is not altered then exit
else commit the file back to the server with a default commit message


