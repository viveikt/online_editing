require 'rubygems'
require 'win32/service'
include Win32

SERVICE = 'onlineediting'

begin
  Service.stop(SERVICE) if Service.status(SERVICE).controls_accepted.include? "stop"
rescue
end

Service.delete(SERVICE)
