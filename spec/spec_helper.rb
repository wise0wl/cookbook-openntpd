require 'chefspec'
require 'chefspec/berkshelf'
$LOAD_PATH << '../lib'
require 'busser/rubygems'

# Required to output XML output for Bamboo
Busser::RubyGems.install_gem('yarjuf', '>= 2.0.0')

require 'serverspec'
require 'yarjuf'

# Required by serverspec
set :backend, :exec

RSpec.configure do |c|
  c.path = '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin'
  c.output_stream = File.open('/tmp/serverspec-result.xml', 'w')
  c.formatter = 'JUnit'
end
