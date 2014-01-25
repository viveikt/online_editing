SVN Online Editing
==============

Description:

Online editing can be used to edit a specific file in a SVN repository by your default editor and on save it will be pushed back to the server.

Plugin Dependencies:

1. Windows
2. ruby 1.9.3
3. Tortoise svn command line ticked in installer. If this is not installed none of the command line arguments will work
4. Tortoise git 

Installation Procedure:

1. Tortoise GIT to download code:
   -- Install tortoise git if its not available in your pc from -> http://msysgit.github.io/
   -- Right click and select git Gui -> clone existing repository 
   -- Source location - https://github.com/viveikt/online_editing.git
   -- Target location - C:/Users/username/Desktop/online_editing (or your desired location ) -> Clone 
   -- Once cloned exit and then open the folder where you cloned
   	
2. Setting up:
   -- Right click on the podium.reg file -> edit
   -- Edit the last line which looks like @="C:\\Users\\invith\\Desktop\\test\\online_editing\\start.bat %1 %2 %3" to "your_cloned_location\\start.bat %1 %2 %3""
   -- Run podium.reg file -> Click ok when promted. This will successfully add the registery.

3. Ready to Online Edit:
   -- Click on the edit button on your instance and you can edit it online 
