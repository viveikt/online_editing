require 'rubygems'
#require 'debugger'

#1. create a tmp folder some where
#2. checkout a file from a repository to that location
#3. create a process
#4. open the file with its default editor
#5. check for the below commands
#def load_notepad
#pid = Process.spawn("notepad.exe")
#puts "before wait"
#Process.wait pid
#puts "after wait"
#end
#6. If response code received and file is not altered then exit
#else commit the file back to the server with a default commit message

class OnlineEdit

  def initialize(path,file)
    @path = path
    @file = file
  end

  def create_tmp_folder
    create = system( "mkdir tmp" ) #Not so effecient check auto temp folder creation and deletion after process completes. (http://ruby-doc.org/stdlib-2.1.0/libdoc/tmpdir/rdoc/index.html)
    unless false
      checkout
    end
  end

  def checkout
      clone = system( "svn export #{@path} tmp/" )
      create_process unless false
  end

  def create_process
    file_time_before_opening = File.mtime("tmp/#{@file}")
    puts file_time_before_opening
    open_file = system( "start tmp/#{@file}" )
    file_time_before_closing = File.mtime("tmp/#{@file}")
    puts file_time_before_closing
    # This doesn't work. create Process as planned
  end

end

init = OnlineEdit.new("https://tstpd.pdprojects.prevas.com/svn/aef012.documents/README.txt","README.txt")
init.create_tmp_folder

