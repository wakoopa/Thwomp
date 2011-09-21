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

    def render_batch!(frames)

    end

    private

    def generate_thumbnail!(frame)
      filename = "#{Dir.tmpdir}/thumbnail_#{Time.now.to_i}_#{frame}.png"

      frame_filename = renderer.frame_filename(frame)
      return false unless frame_filename && !frame_filename.empty?

      begin
        thumbnail = ChunkyPNG::Image.from_file(frame_filename)
        thumbnail.resample_bilinear!(max_width, max_height)
        thumbnail.save(filename)

        filename
      rescue ChunkyPNG::Exception
        false
      end
    end

  end
end
