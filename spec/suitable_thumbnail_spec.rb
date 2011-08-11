require 'spec_helper'
require 'thwomp'

describe Thwomp::SuitableThumbnail do
  it 'finds a suitable preview image' do
    renderer = Thwomp::Renderer.new("#{File.dirname(__FILE__)}/fixtures/test.swf")
    subject = Thwomp::SuitableThumbnail.new(renderer, :max_width => 128, :max_height => 128)

    subject.png_data.should == get_contents("#{File.dirname(__FILE__)}/fixtures/frame5_thumbnail.png")
  end
end
