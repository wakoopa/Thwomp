require 'spec_helper'
require 'thwomp'

describe Thwomp::Renderer do
  describe 'extracting frames from flash' do

    subject { Thwomp::Renderer.new("#{File.dirname(__FILE__)}/fixtures/test.swf") }

    it 'extracts frame 1' do
      subject.png_data(0).should == get_contents("#{File.dirname(__FILE__)}/fixtures/frame0.png")
    end

    it 'extracts frame 2' do
      subject.png_data(1).should == get_contents("#{File.dirname(__FILE__)}/fixtures/frame1.png")
    end

    it 'extracts frame 3' do
      subject.png_data(2).should == get_contents("#{File.dirname(__FILE__)}/fixtures/frame2.png")
    end

  end
end
