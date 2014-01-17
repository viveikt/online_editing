require 'rubygems'
require 'win32/service'
include Win32

Service.create({
                   service_name: 'onlineediting',
                   host: nil,
                   service_type: Service::WIN32_OWN_PROCESS,
                   description: 'Online Editing',
                   start_type: Service::AUTO_START,
                   error_control: Service::ERROR_NORMAL,
                   binary_path_name: "#{`where ruby`.chomp} -C #{`echo %cd%`.chomp} oe.rb",
                   load_order_group: 'Network',
                   dependencies: nil,
                   display_name: 'Online Editing'
               })

Service.start("onlineediting")
