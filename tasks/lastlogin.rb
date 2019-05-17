#!/opt/puppetlabs/puppet/bin/ruby

# we're assuming this is being run in puppet ruby

require 'open3'
require 'json'
require 'date'

login = {}
stdout, stderr, status = Open3.capture3("/bin/last -n 10 -i")
output = stdout.split(/\n+/)
output[0..9].each do |line|
  event = line.split
  dt =  event[4] +'-'+ event[5] +'-'+ event[6]
  # Mon-Apr-22-22:10
  datetime = dt
  if event[7] == 'still'
    logged_in = "true"
  else
    logged_in = "false"
  end
  login[dt] = { 'user' => event[0], 'logged_in' => logged_in }
end
puts login.to_json