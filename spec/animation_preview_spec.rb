require 'spec_helper'

describe Thwomp::AnimationPreview do

  let(:renderer) { Thwomp::Renderer.new("#{File.dirname(__FILE__)}/fixtures/test.swf") }

  it 'generates a gif animation' do
    animation = Thwomp::AnimationPreview.new(renderer, :max_width => 60, :max_height => 60)
    animation.gif_data.should == get_contents("#{File.dirname(__FILE__)}/fixtures/frames.gif")
  end

end
