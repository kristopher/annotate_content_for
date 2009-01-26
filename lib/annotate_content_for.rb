module ActionView::Helpers::CaptureHelper

  def content_for_with_annotation(name, content = nil, &block)
    content = capture(&block) if block_given?
    file = caller.detect do |file| 
      file =~ /\/app\/views\// || file =~ /\/app\/helpers\//
    end
    if file
      content_for_annotation = "content_for(#{name.inspect}) from: #{file.gsub(/:in\s+`.*/, '')}"
      content = %Q{
        <!-- START #{content_for_annotation} -->
          #{content}
        <!-- END #{content_for_annotation} -->
       }      
    end
    content_for_without_annotation(name, content)
  end

  if (ENV['RAILS_ENV'] == 'development' || TEST_ANNOTATE_CONTENT_FOR)
    alias_method_chain :content_for, :annotation
  else
    alias_method :content_for_without_annotation, :content_for
  end

end




