require 'rubygems'
case RUBY_PLATFORM
when 'linux'
  require 'ruby-growl'
  NOTIFY = Growl
else
  require 'ruby-notify'
  NOTIFY = Notify
end
require 'pp'

$g_host ||= "localhost"
$g_priority ||= 0
$g_sticky ||= true

module Kernel
  def g(*args, &block)
    growl = NOTIFY.new $g_host, $0, ["Kernel.g"]

    args.push(block) if block

    messages =
      if args.empty?
        [nil.pretty_inspect]
      else
        args.map { |i| i.pretty_inspect }
      end

    messages.each { |i| growl.notify "Kernel.g", $0, i, $g_priority, $g_sticky }

    if args.empty?
      nil
    elsif args.size == 1
      args.first
    else
      args
    end
  end
end
