require 'spec_helper'

module Thwomp

  describe AnimationPreview do

    it "shells out to 'convert' to create an animated gif" do
      frames = %w(a.png b.png c.png)
      now = Time.now
      output_file = "#{Dir.tmpdir}/animation_#{now.to_i}.gif"

      cmd = "convert #{frames.join(' ')} #{output_file}"
      expect(Command).to receive(:exec).with(cmd)

      allow(Time).to receive(:now).and_return(now)
      preview = AnimationPreview.new(frames)
      expect(preview.generate!).to eq(output_file)
    end

  end

end
