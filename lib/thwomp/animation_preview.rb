require 'tmpdir'

module Thwomp
  class AnimationPreview

    # TODO: (optional) use Thumbnail class to make png's from the
    # rendered frames, instead of passing the frames directly to 'convert'

    attr_reader :frames

    def initialize(frames, options={})
      @frames = frames
      @options = options
    end

    def generate!
      filename = "#{Dir.tmpdir}/animation_#{Time.now.to_i}.gif"
      extent = "-extent #{max_width}X#{max_height}"
      Command.exec("convert #{extent} #{frames.join(' ')} #{filename}")
      filename
    end

    def max_width
      @options.fetch(:max_width) { 128 }
    end

    def max_height
      @options.fetch(:max_height) { 128 }
    end

    # returns the gif binary data of generated animation
    def gif_data
      File.open(generate!, 'rb') { |f| f.read }
    end

  end
end
