require 'tmpdir'
require 'oily_png'

module Thwomp

  # Creates thumbnail of SWF movies
  class Thumbnail

    attr_accessor :renderer, :max_width, :max_height

    DEFAULT_OPTIONS = { :max_width => 128,
                        :max_height => 128 }

    #
    # Intializes thumbnail renderer
    #
    # Options
    #   :max_width      Maximum width of thumbnail
    #   :max_height     Maximum height of thumbnail
    #
    def initialize(renderer, options = {})
      DEFAULT_OPTIONS.merge(options).each { |k,v| send(:"#{k}=", v) if v }
      @renderer = renderer
    end

    # returns the png binary data of the generated thumbnail
    def png_data(frame)
      File.open(filename(frame), 'rb') { |f| f.read } if renderer.frame_exists?(frame)
    end

    # returns the temp filename of the generated thumbnail
    def filename(frame)
      @filename ||= {}
      @filename[frame] ||= generate_thumbnail!(frame) if renderer.frame_exists?(frame)
    end

    private

    def generate_thumbnail!(frame)
      filename = "#{Dir.tmpdir}/thumbnail_#{Time.now.to_i}_#{frame}.png"

      thumbnail = ChunkyPNG::Image.from_file(renderer.frame_filename(frame))
      thumbnail.resample_bilinear!(max_width, max_height)
      thumbnail.save(filename)

      filename
    end

  end
end
