module Ifestor
		class << self 

				def interfaces
					# split the output on newlines, shove all the different interfaces into an array
					interfaces = []
					last_interface = []
					lines = ifconfig_output.split("\n")
					while line = lines.shift
							if line.strip.length == 0
									interfaces.push last_interface
									last_interface = []
							else
									last_interface.push line
							end
					end
					interfaces.push last_interface
					interfaces.collect { |x| parse_interface x }
				end

				def ifconfig_output 
						(`ifconfig`)
				end

				def parse_interface interface
						mac_match = (interface[0].match /HWaddr ([:0-9a-f]*)/)
						ip_match = (interface[1].match /inet addr:([0-9\.]*)/)
						{ :name => (interface[0].match /([a-z0-9]*)/)[1],
								:mac => !mac_match.nil? ? mac_match[1] : nil,
								:ip => !ip_match.nil? ? ip_match[1] : nil }
				end
			
		end

end
