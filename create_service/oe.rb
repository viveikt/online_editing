require 'rubygems'
require 'win32/daemon'
include Win32

class ProcessDaemon < Daemon
  def service_main
    log 'started'
    while running?
      log 'running'
      sleep 10
      a = "test string"
      debugger
    end
  end

  def service_stop
    log 'ended'
    exit!
  end

  def log(text)
    File.open('log.txt', 'a') { |f| f.puts "#{Time.now}: #{text}" }
  end
end

ProcessDaemon.mainloop
