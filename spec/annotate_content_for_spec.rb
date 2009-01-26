require File.join(File.dirname(__FILE__), 'spec_helper')

describe "AnnotateContentFor" do  
  
  before(:each) do
    @action_view = ActionView::Base.new
  end
  
  it "should define content_for_without_annotation" do
    @action_view.method(:content_for_without_annotation).should_not be(nil)
  end
  
  describe 'content_for_with_annotation' do    
    describe 'when in the development environment' do

      it "should define content_for_with_annotation" do
        @action_view.method(:content_for_with_annotation).should_not be(nil)
      end

      it "should call content_for_without_annotation" do
        @action_view.should_receive(:content_for_without_annotation)
        @action_view.content_for(:test, 'test')
      end
      
      it "should add annotations when passed a string" do
        @action_view.content_for(:test, 'test')
        @action_view.instance_variable_get(:@content_for_test).should match(/<!-- START/)
      end
      
      it "should add annotation when passed a block" do
        @action_view.content_for(:test) { 'test' }
        @action_view.instance_variable_get(:@content_for_test).should match(/<!-- START/)
      end
      
      it "should add an end of annotation comment" do
        @action_view.content_for(:test, 'test')
        @action_view.instance_variable_get(:@content_for_test).should match(/<!-- END/)      
      end
      
      it "should add the content_for name to the annotation" do
        @action_view.content_for(:test, 'test')
        @action_view.instance_variable_get(:@content_for_test).should match(/content_for\(:test\)/)      
      end
    
      it "should add the file and path to the annotation" do
        @action_view.content_for(:test, 'test')
        @action_view.instance_variable_get(:@content_for_test).should match(/#{__FILE__}/)      
      end
    end
    
  end
end
