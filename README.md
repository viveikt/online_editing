Online Editing
==============

Hi, 

Here is the description: 

1. register.rb has all the necessary things to register & start a windows service.
2. The above file runs a file called service.rb in the same folder. 
3. There is a folder called stop inside which the unregister.rb will unregister the windows service. 

Steps I followed:

1. There are 2 ways to start the service both gives me the same error. 

$ ruby register.rb

C:/Ruby193/lib/ruby/gems/1.9.1/gems/win32-service-0.8.3/lib/win32/windows/helper.rb:36:in 
`raise_windows_error': The service did not respond to the start or control request in a timely fashion. 
- StartService: The service did not respond to the start or control request in a timely fashion. (SystemCallError)
from C:/Ruby193/lib/ruby/gems/1.9.1/gems/win32-service-0.8.3/lib/win32/service.rb:723:in `start'
from register.rb:18:in `<main>'

OR 

$ sc start testservice

[SC] StartService FAILED 1053:

The service did not respond to the start or control request in a timely fashion.

_________________________________________________________________________________________________________________________________________________________________________________________________________________

I can see a service named testservice in my task manager -> services. Right click and start service also gives me the same error. 

Question: What does the error mean? I tried googling but I don't understand the reason. Is this a problem with win32 gem?