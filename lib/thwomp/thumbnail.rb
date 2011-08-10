module Thwomp
  class ThumbnailGenerator < Struct.new(:renderer)

    private

    def find_suitable_frame
    end

    # tests if the given frame no. is suitable for a thumbnail
    # tests if the frame doesn't contain a too high concentration of one color
    def suitable_frame?(frame)
    end

  end
end
