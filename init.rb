require File.join(File.dirname(__FILE__), 'lib', 'annotate_content_for')

if defined?(Footnotes) && ENV['RAILS_ENV'] == 'development'
  require File.join(File.dirname(__FILE__), 'lib', 'content_for_note')
end