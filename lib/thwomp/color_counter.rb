require 'oily_png'

module Thwomp
  # Flattens all colors in given image file and calculates the diversity in used colors
  # We can asume that if the image contains more than 2 colors, we have an interesting image
  class ColorCounter < Struct.new(:image_filename)

    FLATTEN_FACTOR = 4.0

    # returns the number of different colors
    def diversity
      color_count.keys
    end

    # tests if the image is empty
    def empty?
      diversity.size < 2
    end

    # tests if the image contains an photo
    def present?
      !empty?
    end

    private

    def png
      @png ||= ChunkyPNG::Image.from_file(image_filename)
    end

    def width
      @width ||= png.width
    end

    def height
      @height ||= png.height
    end

    # start counting mofo!
    def color_count
      unless @color_count
        @color_count = {}

        height.times do |y|
          width.times do |x|
            @color_count[flattened_color_at(x, y)] ||= 0
            @color_count[flattened_color_at(x, y)] += 1
          end
        end
      end

      @color_count
    end

    # simplifies the given color
    def flattened_color(color)
      r = ChunkyPNG::Color.r(color)
      g = ChunkyPNG::Color.g(color)
      b = ChunkyPNG::Color.b(color)

      ChunkyPNG::Color.rgb(flatten_color(r), flatten_color(g), flatten_color(b))
    end

    # flattens a color value
    def flatten_color(color)
      ((((color.to_f / 255.0) * flattened_max_color.to_i).to_i / flattened_max_color) * 255.0).to_i
    end

    def flattened_max_color
      255.0 / FLATTEN_FACTOR
    end

    # returns the color at pixel X,Y
    def color_at(x,y)
      png[y, x]
    end

    def flattened_color_at(x,y)
      flattened_color color_at(x,y)
    end

  end
end
