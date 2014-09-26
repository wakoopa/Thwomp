require 'spec_helper'
require 'thwomp'

module Thwomp

  describe Renderer do

    it "instantiates the ffmpeg renderer for flv" do
      path = "/some/path/test.flv"
      expect(Renderers::FFMPEG).to receive(:new).with(path)
      renderer = Renderer.new(path)
    end

    it "instantiates the gnash renderer for swf" do
      path = "/some/path/test.swf"
      expect(Renderers::SWF).to receive(:new).with(path)
      renderer = Renderer.new(path)
    end

    it "passes all arguments to the renderer" do
      path = "/some/path/test.swf"
      options = { :width => 200, :height => 200 }
      expect(Renderers::SWF).to receive(:new).with(path, options)
      renderer = Renderer.new(path, options)
    end

  end

end
