require 'chunky_png'

module Thwomp
  class ColorCounter < Struct.new(:image_filename)
    # returns a factor that indicates the diversity of used colors in frame
    def diversity

    end

    private

    def png
      @png ||= ChunkyPNG::Image.from_file(image_filename)
    end

    def width
      @width ||= png.metadata[:width]
    end

    def height
      @height ||= png.metadata[:height]
    end

    # start counting mofo!
    def count!
      color_count = {}
    end

  end
end
