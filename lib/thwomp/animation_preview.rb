module Thwomp
  class AnimationPreview < Struct.new(:renderer)

    attr_accessor :renderer, :max_width, :max_height

    DEFAULT_OPTIONS = { :max_width => 128,
                        :max_height => 128 }

    #
    # Creates an GIF animation from a given SWF
    #
    # Options
    #   :max_width    Maximum width of GIF
    #   :max_height   Maximum height of GIF
    #
    def initialize(renderer, options = {})
      DEFAULT_OPTIONS.merge(options).each { |k,v| send(:"#{k}=", v) if v }
    end

    # returns the gif binary data of generated animation
    def gif_data
    end

    # returns temp filename of generated animation
    def filename
    end

    private

    # returns all filenames of the seperate frames in the flash animation
    def frame_filenames
      @frame_filenames ||= (0..renderer.max_frames).map { |frame| renderer.frame_filename(frame) }.compact
    end

  end
end
