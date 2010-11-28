spec = Gem::Specification.new do |s|
		s.name = 'ifestor'
		s.version = '0.1'
		s.summary = "It spits out information on your network interfaces, inspired by Ara T. Howard's macaddr gem"
		s.author = "Clarke Brunsdon"
		s.email = "clarke@freerunningtechnologies.com"
		s.homepage = "http://clarkebrunsdon.com"

		s.test_files = ["test/interface_test.rb"]

		s.files = ["lib/ifestor.rb", "README.md", "LICENSE.txt"]
end
