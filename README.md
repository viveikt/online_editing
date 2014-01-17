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

* svn export url_to_repo is used to checkout a single file
  ex: svn export https://tstpd.pdprojects.prevas.com/svn/aef012.documents/README.txt