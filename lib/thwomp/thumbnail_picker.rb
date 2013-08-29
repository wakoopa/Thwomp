module Thwomp

  class ThumbnailPicker

    def self.pick(image_paths)
      path = image_paths.find do |path|
        counter = ColorCounter.new(path)
        counter.valid_png? && counter.present?
      end

      raise NoSuitableFramesFoundError unless path

      Thumbnail.generate!(path)
    end

  end

end
