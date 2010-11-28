require 'rubygems'
gem 'mocha'
require 'mocha'
require 'test/unit'
require 'ifestor'

class InterfaceTest < Test::Unit::TestCase
		def test_should_get_all_interfaces_for_my_computer
				interfaces = <<-EOS 
eth0      Link encap:Ethernet  HWaddr 00:26:2d:fa:c6:d6  
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
          Interrupt:20 Memory:f2600000-f2620000 

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:57742 errors:0 dropped:0 overruns:0 frame:0
          TX packets:57742 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:11070082 (11.0 MB)  TX bytes:11070082 (11.0 MB)

wlan0     Link encap:Ethernet  HWaddr 00:24:d7:04:f1:50  
          inet addr:192.168.1.119  Bcast:192.168.1.255  Mask:255.255.255.0
          inet6 addr: fe80::224:d7ff:fe04:f150/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:56266 errors:0 dropped:0 overruns:0 frame:0
          TX packets:44953 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:24251169 (24.2 MB)  TX bytes:7086610 (7.0 MB)
				EOS


				Ifestor.expects(:ifconfig_output).returns(interfaces)

				interfaces = Ifestor.interfaces
				assert_equal interfaces.length, 3
				assert interfaces.any? { |x| x[:ip] == "192.168.1.119" }
				assert interfaces.any? { |x| x[:mac] == "00:24:d7:04:f1:50" }
				assert interfaces.any? { |x| x[:mac] == "00:26:2d:fa:c6:d6" }
				assert interfaces.any? { |x| x[:name] == "wlan0" }
		end
end

