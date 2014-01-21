require 'rubygems'
require 'open-uri'
require 'securerandom'
require 'debugger'
require 'tmpdir.rb'
#!/usr/bin/env ruby

class OnlineEdit
  def initialize(svn_path,file)
    @svn_path = svn_path
    @file = file.gsub('%20',' ')
  end

  #Use if necessary
  def online?
    begin
      true if open("http://www.google.com/")
    rescue
      false
    end
  end

  def create_tmp_dir
    @local_path = File.expand_path "#{Dir.tmpdir}/#{Time.now.to_i}#{rand(1000)}/"
    FileUtils.mkdir_p @local_path
    checkout
  end

  def checkout
    @nav = SecureRandom.random_number
    Dir.chdir("#{@local_path}") do
      clone = system ( "svn co --depth=empty #{@svn_path} #{@nav} & cd #{@nav} & svn up \"#{@file}\"" )
    end
    edit_file
  end

  def edit_file
    before = File.mtime("#{@local_path}/#{@nav}/#{@file}")
    open_file = system( "start /wait #{@local_path}/#{@nav}/#{@file}" )
    after = File.mtime("#{@local_path}/#{@nav}/#{@file}")
    if before != after
      commit
    else
      exit
    end
    # Are you sure you want to create a process for this?
  end

  def commit
    default_message = 'default message'
    commit_file = system( "svn commit -m \"#{default_message}\" #{@local_path}/#{@nav}/#{@file}" )
    remove_tmp_folder
  end

  def remove_tmp_folder
    remove_dir = system( 'rmdir tmp /s /q' )
  end

  def exit
    #abort("exit")
    puts 'exit'
  end
end

init = OnlineEdit.new(ARGV[1].to_s,ARGV[2].to_s)
init.create_tmp_dir
