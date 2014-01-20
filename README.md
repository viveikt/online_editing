Online Editing
==============

Description:

Online editing can be used to edit a specific file in a SVN repository by your default editor and on save it will be pushed back to the server.

Plugin Dependencies:

1. Windows
2. ruby 1.9.3
3. Tortoise svn command line ticked in installer. If this is not installed none of the command line arguments will work

NOTES:

How to Add the URL handler:

Start -> Run -> regedit
New -> key ->
podiumonlineedit -> Default -> Podium URI
shell
open
command -> Default -> path_to_your_repository\online_editing\start.bat %1 %2 %3 %4

Different ways to run file (For Development and Production)

Development:

init = OnlineEdit.new('https://tstpd.pdprojects.prevas.com/svn/aef012.documents','README.txt','aef012.documents')
init.create_tmp_folder

Production:
podiumonlineedit:?url=https://tstpd.pdprojects.prevas.com/svn/aef012.documents=README.txt=aef012.documents
podiumonlineedit:?url=https://oe.dev1.prevas.com/svn/t2811p.documents=test.doc=t2811p.documents
podiumonlineedit:?url=https://oe.dev1.prevas.com/svn/t2811p.documents=/trunk/G%20-%20Administration/t2811pg001%20Checklist%20Completion%20meeting.doc=t2811p.documents


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


