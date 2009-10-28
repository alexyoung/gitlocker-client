require 'patron'

module Gitlocker
end

%w(http repository document).each do |file|
  require File.join(File.dirname(File.expand_path(__FILE__)), file)
end

