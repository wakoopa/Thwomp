require 'tmpdir'
require 'oily_png'

module Thwomp

  class Thumbnail

    def self.generate!(path, options={})
      width = options.fetch(:width, 128)
      height = options.fetch(:height, 128)

      filename = path.gsub(/frame/, 'thumbnail')

      begin
        thumbnail = ChunkyPNG::Image.from_file(path)
        thumbnail.resample_bilinear!(width, height)
        thumbnail.save(filename)

        filename
      rescue ChunkyPNG::Exception, RangeError, NoMethodError
        false
      end
    end

  end

end
