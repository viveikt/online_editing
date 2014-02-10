require 'rubygems'
require 'open-uri'
require 'securerandom'
require 'tmpdir.rb'
require 'uri'
#!/usr/bin/env ruby

class OnlineEdit
  def initialize(svn_path,file)
    @svn_path = svn_path
    @file = URI.decode(file)
    @encoded_file = file.gsub(' ','%20')
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
      system ( "svn co --depth=empty #{@svn_path} #{@nav} & cd #{@nav} & svn up \"#{@file}\"" ) 
      lock
    end
    edit_file
  end

  def edit_file
    before = File.mtime("#{@local_path}/#{@nav}/#{@file}") 
    system( "start \"\" /wait \"#{@local_path}/#{@nav}/#{@file}\"" ) 
    after = File.mtime("#{@local_path}/#{@nav}/#{@file}") 
    if before != after
      unlock
      commit
    else
      unlock
      abort("File was not modified")
    end
  end
  
  def lock
    system ( "svn lock #{@svn_path}/#{@encoded_file}")   
  end
  
  def unlock
    system ( "svn unlock #{@svn_path}/#{@encoded_file}")   
  end

  def commit
    system ( "svn unlock #{@svn_path}/#{@file}") 
    default_message = 'default message'
    system( "svn commit -m \"#{default_message}\" \"#{@local_path}/#{@nav}/#{@file}\"" ) 
    remove_tmp_dir
  end

  def remove_tmp_dir
    FileUtils.rm_rf( @local_path ) if File.exists?( @local_path ) 
  end

end

init = OnlineEdit.new(ARGV[1].to_s,ARGV[2].to_s)
init.create_tmp_dir unless defined?(Ocra)
