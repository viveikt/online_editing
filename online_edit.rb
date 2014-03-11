#!/usr/bin/env ruby
require 'rubygems'
require 'open-uri'
require 'securerandom'
require 'tmpdir.rb'
require 'uri'
require 'open3'
require 'fox16'
include Fox

require 'debugger'

class DialogBox < FXMainWindow
  def initialize(app)
    super(app, "Podium Online Editing", :opts => DECOR_ALL, :width => 1200, :height => 100)
    # Tooltip
    FXToolTip.new(getApp())
    # Contents
    contents = FXHorizontalFrame.new(self,
      LAYOUT_SIDE_TOP|FRAME_NONE|LAYOUT_FILL_X|LAYOUT_FILL_Y|PACK_UNIFORM_WIDTH)
    FXLabel.new(contents, "The file you are trying to edit is locked by a different user, what would you like to do?", nil, LAYOUT_SIDE_TOP | JUSTIFY_LEFT)
    # Open as read only button
    open_as_read_only = FXButton.new(contents,
      "&Open as read only\tOpen the file as read only, the file will not be committed",
      :opts => FRAME_RAISED|FRAME_THICK|LAYOUT_BOTTOM |LAYOUT_FIX_WIDTH|LAYOUT_FIX_HEIGHT,
      :width => 150, :height => 50)
    open_as_read_only.connect(SEL_COMMAND, method(:read_only))
    # Force Unlock button
    force_unlock = FXButton.new(contents,
      "&Force Unlock\tForce unlock file by breaking the lock and taking control",
       :opts => FRAME_RAISED|FRAME_THICK|LAYOUT_BOTTOM |LAYOUT_FIX_WIDTH|LAYOUT_FIX_HEIGHT,
      :width => 150, :height => 50)
    force_unlock.connect(SEL_COMMAND, method(:force_unlock))
    # Cancel button
    cancel_button = FXButton.new(contents,
      "&Cancel\tExit process",
       :opts => FRAME_RAISED|FRAME_THICK|LAYOUT_BOTTOM |LAYOUT_FIX_WIDTH|LAYOUT_FIX_HEIGHT,
      :width => 150, :height => 50)
    cancel_button.connect(SEL_COMMAND, method(:cancel_button))
    # Respond to window close
    self.connect(SEL_CLOSE) { method(:cancel_button) }
  end

  # Open the file as read only
  def read_only(sender, sel, ptr)
    construct('read_only')
  end

  # Open file by unlocking first
  def force_unlock(sender, sel, ptr)
    construct('force_unlock')
  end

  # Cancel button which terminates the program
  def cancel_button(sender, sel, ptr)
    construct('cancel_button')
  end

  # Build class
  def construct(args)
    self.close
    init = OnlineEdit.new(ARGV[1].to_s,ARGV[2].to_s)
    if args == 'read_only'
      init.read_only_checkout
    elsif args == 'force_unlock'
      init.unlock_force
    elsif args == 'cancel_button'
      init.remove_tmp_dir        
    end
    exit
  end

  # Start execution
  def create
    super
    show(PLACEMENT_SCREEN)
  end
end


class OnlineEdit

  def start
    create_tmp_dir
  end

  # Initialize the class from the arguments received from podium web application
  def initialize(svn_path,file)
    $svn_path = svn_path
    $file = URI.decode(file)
    $encoded_file = file.gsub(' ','%20')
  end;

  # Check if the user is online. Not currently used
  def online?
    begin
      true if open("http://www.google.com/")
    rescue
    false
    end
  end

  # Create a temp directory and checkout the file
  def create_tmp_dir
    $local_path = File.expand_path "#{Dir.tmpdir}/#{Time.now.to_i}#{rand(1000)}/"
    FileUtils.mkdir_p $local_path
    checkout
  end

  # SVN / Console commands
  def svn_command(cmd)
    case cmd
      when 'svn_checkout'
        system ( "svn co --depth=empty #{$svn_path} #{$nav} & cd #{$nav} & svn up \"#{$file}\"" )
      when 'start_file_exit'
        system( "start \"\" \"#{$local_path}/#{$nav}/#{$file}\"" )  
      when 'start_file_wait'
        system( "start \"\" /wait \"#{$local_path}/#{$nav}/#{$file}\"" )
      when 'svn_lock'
        system ( "svn lock #{$svn_path}/#{$encoded_file}")
      when 'svn_unlock'
        system ( "svn unlock #{$svn_path}/#{$encoded_file}") 
      when 'svn_unlock_force'
        system ( "svn unlock --force #{$svn_path}/#{$encoded_file}")
      when 'svn_commit'
        commit_message = 'Edited online using podium editor'
        system( "svn commit -m \"#{commit_message}\" \"#{$local_path}/#{$nav}/#{$file}\"" )
    end    
  end

  # Checkout the svn file and move to edit method
  def checkout
    $nav = SecureRandom.random_number
    Dir.chdir("#{$local_path}") do
      svn_command('svn_checkout')
      lock
    end
    edit_file
  end

  # This method is used only if the user selects read only if the file was locked
  def read_only_checkout
    $nav = SecureRandom.random_number
    Dir.chdir("#{$local_path}") do
      svn_command('svn_checkout')
    end
    svn_command('start_file_exit')
    exit
  end

  # Edit the file by opening the file in the default editor and check for changes in the file
  def edit_file
    before = File.mtime("#{$local_path}/#{$nav}/#{$file}")
    svn_command('start_file_wait')
    after = File.mtime("#{$local_path}/#{$nav}/#{$file}")
    unlock
    if before != after
      commit
    else
      puts "File was not modified"
    end
    remove_tmp_dir
  end

  # Initially check if the file is locked. If locked then open the UI with 3 options else lock the file 
  def lock
    check_locked = %x(svn status -u "#{$local_path}/#{$nav}/#{$file}\" 2>&1).split(' ').first
    if check_locked == "O" #File already locked 
      run_options
    else
      svn_command('svn_lock')
    end
  end

  # Unlock file method, used after users input. This will run at the end of the program at any cost 
  def unlock
    svn_command('svn_unlock')
  end

  # Used only if the user selects force unlock from the UI and then it locks again for further editing
  def unlock_force
    svn_command('svn_unlock_force')
    lock_again
  end

  # Used only when force unlock is selected. Locks the file again and edits the file
  def lock_again
    svn_command('svn_lock')
    edit_file
  end

  # After changes found in the file the file is committed with a default message
  def commit
    svn_command('svn_commit')
  end

  # Temp folder and file should be deleted on program exit
  def remove_tmp_dir
    FileUtils.rm_rf( $local_path ) if File.exists?( $local_path )
  end

  # Dialogbox method
  def run_options
    # Make an application
    application = FXApp.new("Dialog", "OnlineEditing")
    # Construct the application's main window
    DialogBox.new(application)
    # Create the application
    application.create
    # Run the application
    application.run
  end

  private :create_tmp_dir, :checkout , :edit_file , :lock , :unlock , :lock_again , :commit, :run_options
end

init = OnlineEdit.new(ARGV[1].to_s,ARGV[2].to_s)
init.start unless defined?(Ocra)

# TO DO: 
# Add ensure for all the methods which needs to be executed during the program exit
# DRY the code 
# Fix read only checkout it is checking out twice
