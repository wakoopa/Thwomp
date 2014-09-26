require 'spec_helper'
require 'thwomp'

module Thwomp

  describe Renderers::SWF do

    let(:input) { "./some/path/to/test.swf" }

    it "shells out to 'gnash' to extract frames from an SWF movie" do
      renderer = Renderers::SWF.new(input)
      allow(renderer).to receive(:generate_uuid).and_return("abc")

      output_file = "#{Dir.tmpdir}/frame_abc_%f.png"
      cmd = "gnash-dump -s1 --screenshot=last,10,9,8,7,6,5,4,3,2,1,0 --screenshot-file=#{output_file} -1 -r1 --timeout 200 #{input} -j 500 -k 500".split(" ")
      expect(Command).to receive(:exec).with(*cmd)
      renderer.frames
    end

  end

end
