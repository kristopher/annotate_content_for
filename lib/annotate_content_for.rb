module ActionView

  class Base        
    def content_for_callers
      @content_for_callers ||= []
    end  
  end

  module Helpers::CaptureHelper
  
    def content_for_with_annotation(name, content = nil, &block)
      content = capture(&block) if block_given?
      file = caller.first.gsub(/\s`.*/, '')
      content_for_annotation = "content_for(#{name.inspect}) from: #{file}"
      content = %Q{
        <!-- START #{content_for_annotation} -->
          #{content}
        <!-- END #{content_for_annotation} -->
       }      
       content_for_callers << { :content_for_name => name, :file => file }
      content_for_without_annotation(name, content)
    end

    if (ENV['RAILS_ENV'] == 'development' || TEST_ANNOTATE_CONTENT_FOR)
      alias_method_chain :content_for, :annotation
    else
      alias_method :content_for_without_annotation, :content_for
    end
  end
end




