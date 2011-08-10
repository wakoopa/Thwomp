require 'tmpdir'

# TODO maybe nice to use RAW files instead of screenshot files
module Thwomp
  # Renders SWF files
  class RawRenderer < Renderer

    attr_accessor :max_advances

    private

    # calculates offset of given frame
    def frame_offset(frame)
      frame_size * frame
    end

    # calculates size of frame
    def frame_size
      max_width * max_height * 4
    end

    # maximum number of captures frames
    def max_advances
      @max_advances ||= 100
    end

    # extracts one frame from dump and returns the raw data
    def extract_frame_from_raw(frame)
      #@render_frames ||= `#{gnash_binary} #{downloader.filename} -D #{raw_filename} --max-advances #{max_advances} 1 -j 500 -k 500`
      render_frame!(frame)

      File.open('rb', raw_filename) do |file|
        file.seek(frame_offset(frame))
        file.read(frame_size)
      end
    end

  end
end

