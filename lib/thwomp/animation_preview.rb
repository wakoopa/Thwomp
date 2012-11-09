require 'tmpdir'

module Thwomp
  class AnimationPreview

    # TODO: (optional) use Thumbnail class to make png's from the
    # rendered frames, instead of passing the frames directly to 'convert'

    attr_reader :frames

    def initialize(frames)
      @frames = frames
    end

    def generate!
      filename = "#{Dir.tmpdir}/animation_#{Time.now.to_i}.gif"
      Command.exec("convert #{frames.join(' ')} #{filename}")
      filename
    end

    # returns the gif binary data of generated animation
    def gif_data
      File.open(generate!, 'rb') { |f| f.read }
    end

  end
end
