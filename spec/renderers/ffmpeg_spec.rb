require 'spec_helper'
require 'thwomp'

module Thwomp

  describe Renderers::FFMPEG do

    let(:path) { File.expand_path("./spec/fixtures/test.flv") }

    it "creates a screenshot every second" do
      renderer = Renderers::FFMPEG.new(path)
      now = Time.now
      output_file = "#{Dir.tmpdir}/frame_#{now.to_i}_%d.png"
      cmd = "ffmpeg -i #{path} -f image2 -r 1 -vf scale=128:-1 #{output_file} &> /dev/null"

      Time.stub(:now).and_return(now)
      Command.should_receive(:exec).with(cmd)
      renderer.frames
    end

  end

end
