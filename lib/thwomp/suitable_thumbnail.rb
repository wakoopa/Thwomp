module Thwomp

  # Creates thumbnail of SWF movie and finds the most interesting frame in the movie
  class SuitableThumbnail < Thumbnail

    # returns the png binary data of the generated thumbnail
    def png_data
      filename && File.open(filename, 'rb') { |f| f.read }
    end

    # returns the temp filename of the generated thumbnail
    def filename
      @filename ||= generate_thumbnail!
    end

    private

    # loop till we find the most suitable frame
    def suitable_frame
      unless @suitable_frame
        frames = ['last'] + (0..renderer.max_frames).to_a.reverse

        # render a batch of frames to speed up the process
        renderer.render_batch!(frames)

        frames.each do |frame|
          @suitable_frame = frame if !@suitable_frame && suitable_frame?(frame)
        end

        @suitable_frame ||= 'last'
      end

      @suitable_frame
    end

    # tests if the given frame no. is suitable for a thumbnail
    # tests if the frame doesn't contain a too high concentration of one color
    def suitable_frame?(frame)
      renderer.frame_exists?(frame) && suitable_frame_by_colors?(frame)
    end

    def suitable_frame_by_colors?(frame)
      cc = ColorCounter.new(renderer.frame_filename(frame))
      cc.valid_png? && cc.present?
    end

    def suitable_frame_filename
      @suitable_frame_filename ||= renderer.frame_filename(suitable_frame)
    end

    def generate_thumbnail!
      super(suitable_frame)
    end

  end

end
