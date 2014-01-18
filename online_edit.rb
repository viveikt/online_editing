# remove all unnecessary variables.
# add dynamic tmp folder creation, navigation & deletion after end.
# check using svn bindings for ruby if it can help.
# organize code it looks to messy now

require 'rubygems'

class OnlineEdit

  def initialize(path,file,repo_name)
    @path = path
    @file = file
    @repo_name = repo_name
  end

  def create_tmp_folder
    create = system( 'mkdir tmp' ) #Not so efficient check auto temp folder creation and deletion after process completes. (http://ruby-doc.org/stdlib-2.1.0/libdoc/tmpdir/rdoc/index.html)
    unless false
      checkout
    end
  end

  def checkout
    clone = system( "cd tmp & svn co --depth=empty #{@path} & cd #{@repo_name} & svn up #{@file}" )
    edit_file unless false
  end

  def edit_file
    before = File.mtime("tmp/#{@repo_name}/#{@file}")
    open_file = system( "start /wait tmp/#{@repo_name}/#{@file}" )
    after = File.mtime("tmp/#{@repo_name}/#{@file}")
    if before != after
      commit
    else
      exit
    end
    # Are you sure you want to create a process for this?
  end

  def commit
    default_message = 'default message'
    commit_file = system( "svn commit -m \"#{default_message}\" tmp\\#{@repo_name}\\#{@file}" )
    remove_tmp_folder
  end

  def remove_tmp_folder
    remove_dir = system( 'rmdir tmp /s /q' )
  end

  def exit
    puts 'exit'
  end

end

init = OnlineEdit.new('https://tstpd.pdprojects.prevas.com/svn/aef012.documents','README.txt','aef012.documents')
init.create_tmp_folder

