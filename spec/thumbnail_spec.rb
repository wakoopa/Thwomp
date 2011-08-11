require 'spec_helper'
require 'thwomp'

describe Thwomp::Thumbnail do
  describe 'creating thumbnails from frames' do

    let(:renderer) { Thwomp::Renderer.new("#{File.dirname(__FILE__)}/fixtures/test.swf") }
    subject { Thwomp::Thumbnail.new(renderer, :max_width => 128, :max_height => 128) }

    it 'creates thumbnail from frame 1' do
      subject.png_data(0).should == get_contents("#{File.dirname(__FILE__)}/fixtures/frame0_thumbnail.png")
    end

    it 'creates thumbnail from frame 2' do
      subject.png_data(1).should == get_contents("#{File.dirname(__FILE__)}/fixtures/frame1_thumbnail.png")
    end

    it 'creates thumbnail from frame 3' do
      subject.png_data(2).should == get_contents("#{File.dirname(__FILE__)}/fixtures/frame2_thumbnail.png")
    end

    it 'creates thumbnail from frame 4' do
      subject.png_data(3).should == get_contents("#{File.dirname(__FILE__)}/fixtures/frame3_thumbnail.png")
    end

    it 'creates thumbnail from frame 5' do
      subject.png_data(4).should == get_contents("#{File.dirname(__FILE__)}/fixtures/frame4_thumbnail.png")
    end

  end
end
