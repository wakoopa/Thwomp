require 'spec_helper'
require 'thwomp'

module Thwomp

  describe Renderers::FFMPEG do

    let(:path) { File.expand_path("./spec/fixtures/test.flv") }

    it "creates a screenshot every second" do
      renderer = Renderers::FFMPEG.new(path)
      renderer.frames.count.should == 19
    end

  end

end
