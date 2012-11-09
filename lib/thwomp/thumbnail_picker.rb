module Thwomp

  class ThumbnailPicker

    def self.pick(image_paths)
      path = image_paths.find do |path|
        counter = ColorCounter.new(path)
        counter.valid_png? && counter.present?
      end

      Thumbnail.generate!(path)
    end

  end

end
