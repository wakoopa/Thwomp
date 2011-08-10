module Thwomp
  class Preview < Struct.new(:renderer)

    MAX_TRIES = 100

    def png_data
      File.open(filename, 'rb') { |f| f.read }
    end

    def filename
      @filename ||= renderer.frame_filename(suitable_frame)
    end

    private

    # loop till we find the most suitable frame
    def suitable_frame
      unless @suitable_frame
        current_frame = 0

        while !suitable_frame?(current_frame) && current_frame < MAX_TRIES
          current_frame += 1
        end

        @suitable_frame = current_frame
      end

      @suitable_frame
    end

    # tests if the given frame no. is suitable for a thumbnail
    # tests if the frame doesn't contain a too high concentration of one color
    def suitable_frame?(frame)
      ColorCounter.new(renderer.frame_filename(frame)).present?
    end

  end
end
