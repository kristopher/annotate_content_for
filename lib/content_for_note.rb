module Footnotes
  module Notes
    class ContentForNote < FilesNote
      def initialize(controller)
        @controller = controller
        @template = controller.instance_variable_get('@template')
        @files = parse_files!
      end
  
      def row
        :edit
      end
  
      def title
        "Content For (#{@files.size})"
      end

      def content
        @files.empty? ? "" : "<ul><li>#{@files.join("</li><li>")}</li></ul>"
      end

      def valid?
        prefix?
      end

      protected
        def parse_files!
          @template.content_for_callers.collect do |caller|
            %Q{<a href="#{Footnotes::Filter.prefix}#{caller[:file].gsub(/:.*/, '')}&line=#{caller[:file].match(/:(\d*):/)[1]}">content_for(:#{caller[:content_for_name]}) from: #{caller[:file].gsub(/:in$/, '')}</a>}
          end        
        end
    end
  end
end
