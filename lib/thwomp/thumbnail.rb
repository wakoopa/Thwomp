require 'tmpdir'

module Thwomp

  # Creates thumbnail of SWF movies
  class Thumbnail

    attr_accessor :renderer, :max_width, :max_height

    DEFAULT_OPTIONS = { :max_width => 128,
                        :max_height => 128 }

    # Intializes thumbnail renderer
    #
    # Options
    #   :max_width      Maximum width of thumbnail
    #   :max_height     Maximum height of thumbnail
    def initialize(renderer, options = {})
      DEFAULT_OPTIONS.merge(options).each { |k,v| send(:"#{k}=", v) if v }
      @renderer = renderer
    end

    # returns the png binary data of the generated thumbnail
    def png_data
      File.open(filename, 'rb') { |f| f.read }
    end

    # returns the temp filename of the generated thumbnail
    def filename
      @filename ||= generate_thumbnail!
    end

    private

    # loop till we find the most suitable frame
    def most_suitable_frame
      unless @most_suitable_frame
        current_frame = renderer.max_frames

        while !most_suitable_frame?(current_frame) && current_frame > 0
          current_frame -= 1
        end

        @most_suitable_frame = current_frame
      end

      @most_suitable_frame
    end

    # tests if the given frame no. is suitable for a thumbnail
    # tests if the frame doesn't contain a too high concentration of one color
    def most_suitable_frame?(frame)
      renderer.frame_exists?(frame) && ColorCounter.new(renderer.frame_filename(frame)).present?
    end

    def most_suitable_frame_filename
      @most_suitable_frame_filename ||= renderer.frame_filename(most_suitable_frame)
    end

    def generate_thumbnail!
      filename = "#{Dir.tmpdir}/thumbnail_#{Time.now.to_i}.png"

      thumbnail = ChunkyPNG::Image.from_file(renderer.frame_filename(most_suitable_frame))
      thumbnail.resample_bilinear!(max_width, max_height)
      thumbnail.save(filename)

      filename
    end

  end
end
