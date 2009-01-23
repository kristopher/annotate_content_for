module ActionView::Helpers::CaptureHelper
  
  def content_for_with_annotation(name, content = nil, &block)
    content = capture(&block) if block_given?
    if ::RAILS_ENV == 'development'
      content_for_annotation = "content_for(#{name.inspect}) from: #{caller.first}"
      content = %Q{
        <!-- START #{content_for_annotation} -->
          #{content}
        <!-- END #{content_for_annotation} -->
       }      
     end
     content_for_without_annotation(name, content)
  end
  
  alias_method_chain :content_for, :annotation
end