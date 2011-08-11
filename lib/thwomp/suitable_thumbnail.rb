module Thwomp

  # Creates thumbnail of SWF movie and finds the most interesting frame in the movie
  class SuitableThumbnail < Thumbnail

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
    def suitable_frame
      unless @suitable_frame
        current_frame = renderer.max_frames

        while !suitable_frame?(current_frame) && current_frame > 0
          current_frame -= 1
        end

        @suitable_frame = current_frame
      end

      @suitable_frame
    end

    # tests if the given frame no. is suitable for a thumbnail
    # tests if the frame doesn't contain a too high concentration of one color
    def suitable_frame?(frame)
      renderer.frame_exists?(frame) && ColorCounter.new(renderer.frame_filename(frame)).present?
    end

    def suitable_frame_filename
      @suitable_frame_filename ||= renderer.frame_filename(suitable_frame)
    end

    def generate_thumbnail!
      super(suitable_frame)
    end

  end

end
