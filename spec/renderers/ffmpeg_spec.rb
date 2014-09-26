require 'spec_helper'
require 'thwomp'

module Thwomp

  describe Renderers::FFMPEG do

    let(:path) { File.expand_path("./spec/fixtures/test.flv") }

    it "creates a screenshot every second" do
      renderer = Renderers::FFMPEG.new(path)
      allow(renderer).to receive(:generate_uuid).and_return("abc")

      output_file = "#{Dir.tmpdir}/frame_abc_%d.png"
      cmd = "ffmpeg -i #{path} -f image2 -r 1 -vf scale=640:-1 #{output_file}".split(" ")

      expect(Command).to receive(:exec).with(*cmd)
      renderer.frames
    end

  end

end
