#!/usr/bin/env ruby

# Add hostmap library folder to path
base = __FILE__
$:.unshift(File.join(File.expand_path(File.dirname(base)), 'lib'))
$:.unshift(File.join(File.expand_path(File.dirname(base)), 'extlib'))
$:.unshift(File.join(File.expand_path(File.dirname(base)), 'extlib/net-dns-0.4/lib'))

require 'core'
require 'ui/cli/console'
require 'options'


#
# Prints hostmap banner and credits
#
def banner
  puts "hostmap #{HostMap::VERSION} codename #{HostMap::CODENAME}"
  puts "Coded by Alessandro `jekil` Tanasi <alessandro@tanasi.it>"
  puts
end

# Show banner
banner
# Load options
options = HostMap::Options.defaults
options = options.merge(HostMap::Options.load)
options = options.merge(HostMap::Options.parse(ARGV))

if !options['target']
  puts 'No target selected. You must select a target with -t option.'
  exit
end

# Start hostmap
begin
  HostMap::Ui::Cli.new(options).run
rescue Interrupt
  puts "\nExecution aborted by user."
rescue Exception => e
  puts "Unhandled exception. Please report this bug sending an email to alessandro@tanasi.it attaching the following text:"
  puts "Message:\n #{e.message}"
  puts "Backtrace of the exception:\n #{e.backtrace.join("\n ")}"
end