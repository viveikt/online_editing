Online Editing
==============

Description:

Online editing can be used to edit a specific file in a SVN repository by your default editor and on save it will be pushed back to the server.

Plugin Dependencies:

1. Windows
2. ruby 1.9.3
3. Tortoise svn command line ticked in installer. If this is not installed none of the command line arguments will work

NOTES:

How to Add the URL handler:(mention here)

Requirements:

1. create a tmp folder some where
2. checkout a file from a repository to that location
3. create a process
4. open the file with its default editor
5. If response code received and file is not altered then exit
else commit the file back to the server with a default commit message
6. Remove tmp folder.

Register and start windows service : (Not Used)

1. register.rb has all the necessary things to register & start a windows service.
2. The above file runs a file called oe.rb in the same folder.
3. There is a folder called stop inside which the unregister.rb will unregister the windows service.

Steps:

1. There are 2 ways to start the service both gives me the same error.
$ ruby register.rb
OR
$ sc start testservice


