module Thwomp
  # Renders SWF files
  class Renderer

    attr_accessor :swf_url, :max_width, :max_height

    # Initializer the Thwomp renderer
    #
    # options:
    #   :max_width   Maximum width of renderer
    #   :max_height  Maximum height of renderer
    def initialize(swf_url, options = {})
      options.each { |k,v| send(:"k=", v) if v }
      @swf_url = swf_url
    end

    # extracts one frame from dump
    def extract_frame(frame)
      file = File.open('r', temp_filename)
      file.seek(frame_offset(frame))
    end

    # returns the current set gnash binary
    def self.gnash_binary
      @gnash_binary ||= 'dump-gnash'
    end

    # sets the path to the gnash binary
    def self.gnash_binary=(binary)
      @gnash_binary = binary
    end

    private

    # calculates offset of given frame
    def frame_offset(frame)
      frame_size * frame
    end

    # calculates size of frame
    def frame_size
      max_width * max_height * 4
    end

    # renders all the frames from the SWF file and dump them to a RAW file
    def render_frames!
      `#{gnash_binary} #{downloader.filename}`
    end

    # returns the downloader
    def downloader
      @downloader ||= Downloader.new(swf_url)
    end

  end
end
