require 'spec_helper'

module Thwomp

  describe AnimationPreview do

    it "shells out to 'convert' to create an animated gif" do
      frames = %w(a.png b.png c.png)
      now = Time.now
      output_file = "#{Dir.tmpdir}/animation_#{now.to_i}.gif"

      cmd = "convert #{frames.join(' ')} #{output_file}"
      Command.should_receive(:exec).with(cmd)

      Time.stub(:now).and_return(now)
      preview = AnimationPreview.new(frames)
      preview.generate!.should == output_file
    end

  end

end
