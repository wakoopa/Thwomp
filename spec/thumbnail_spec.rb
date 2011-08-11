require 'spec_helper'
require 'thwomp'

describe Thwomp::Thumbnail do
  it 'finds a suitable preview image' do
    renderer = Thwomp::Renderer.new("#{File.dirname(__FILE__)}/fixtures/test.swf")
    subject = Thwomp::Thumbnail.new(renderer)
    subject.png_data.should == get_contents("#{File.dirname(__FILE__)}/fixtures/frame4.png")
  end
end
