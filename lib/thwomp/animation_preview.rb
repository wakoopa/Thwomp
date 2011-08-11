require 'tmpdir'

module Thwomp
  class AnimationPreview < Struct.new(:renderer)

    attr_accessor :renderer, :max_width, :max_height, :max_frames

    DEFAULT_OPTIONS = { :max_width => 128,
                        :max_height => 128,
                        :max_frames => 10 }

    #
    # Creates an GIF animation from a given SWF
    #
    # Options
    #   :max_width    Maximum width of GIF
    #   :max_height   Maximum height of GIF
    #
    def initialize(renderer, options = {})
      DEFAULT_OPTIONS.merge(options).each { |k,v| send(:"#{k}=", v) if v }
      @renderer = renderer
    end

    # returns the gif binary data of generated animation
    def gif_data
      File.open(filename, 'rb') { |f| f.read }
    end

    # returns temp filename of generated animation
    def filename
      @filename ||= generate_gif!
    end

    private

    def thumbnail
      @thumbnail ||= Thumbnail.new(renderer, :max_width => max_width, :max_height => max_height)
    end

    # returns all filenames of the seperate frames in the flash animation
    def frame_filenames
      @frame_filenames ||= (0..max_frames).map { |frame| thumbnail.filename(frame) }.compact
    end

    def generate_gif!
      filename = "#{Dir.tmpdir}/animation_#{Time.now.to_i}.gif"
      `convert #{frame_filenames.join(' ')} #{filename}`
      filename
    end

  end
end
