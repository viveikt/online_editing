SVN Online Editing
==================

Description:

Online editing can be used to edit a specific file in a SVN repository by your default editor and on save it will be pushed back to the server.

Plugin Dependencies:

1. Windows
2. ruby 1.9.3
3. Tortoise svn command line ticked in installer. If this is not installed none of the command line arguments will work
4. Tortoise git 

Installation Procedure:

1. Install ruby
   -- Download Ruby 1.9.3-p484 from http://rubyinstaller.org/downloads/ and install it. 
   -- To verify if ruby was installed open command prompt and type $ ruby -v. If this returns a version of ruby then it is installed.
   
2. Install TortoiseSVN command line client
   -- If you have installed by ticking the command land client to be installed with the package during the TortoiseSVN installation then move to STEP 3.
   -- Uninstall TortoiseSVN before you go to the below step.
   -- Download http://tortoisesvn.net/downloads.html and select the installation (32/64 Bit)
   -- Once downloaded don't forget to click the command line client during the middle of the installation when it prompts to ask you what packages you would want to install.   
   -- Complete setup.

3. Download GIT client to clone code:
   -- Install tortoise git if its not available in your pc from -> http://msysgit.github.io/
   -- Right click and select git Gui -> clone existing repository 
   -- Source location - https://github.com/viveikt/online_editing.git
   -- Target location - C:/Users/username/Desktop/online_editing (or your desired location ) -> Clone 
   -- Once cloned exit and then open the folder where you cloned
   	
4. Setting up:
   -- Right click on the podium.reg file -> edit
   -- Edit the last line which looks like @="C:\\Users\\invith\\Desktop\\test\\online_editing\\start.bat %1 %2 %3" to "your_cloned_location\\start.bat %1 %2 %3""
   -- Run podium.reg file -> Click ok when promted. This will successfully add the registery.

5. Ready to Online Edit:
   -- Click on the edit button on your instance and you can edit it online 
