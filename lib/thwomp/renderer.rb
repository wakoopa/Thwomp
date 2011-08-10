require 'tmpdir'

module Thwomp
  # Renders SWF files
  class Renderer

    attr_accessor :swf_url, :max_width, :max_height

    # Initializer the Thwomp renderer
    #
    # Options:
    #   :max_width   Maximum width of renderer
    #   :max_height  Maximum height of renderer
    def initialize(swf_url, options = {})
      options.each { |k,v| send(:"k=", v) if v }
      @swf_url = swf_url
    end

    # returns filename of frame
    def frame_filename(frame)
      render_frame!(frame)

      @frame_filename ||= {}
      @frame_filename[frame] ||= frame_output_filename(frame)
      @frame_filename
    end

    # returns PNG data from given frame
    def png_data(frame)
      File.open(frame_filename(frame), 'rb') { |f| f.read }
    end

    # returns the current set gnash binary
    def self.gnash_binary
      @gnash_binary ||= '/usr/local/gnash-dump/bin/dump-gnash'
    end

    # sets the path to the gnash binary
    def self.gnash_binary=(binary)
      @gnash_binary = binary
    end

    private

    # renders all the frames from the SWF file and dump them to a RAW file
    def render_frame!(frame)
      @render_frames ||= {}
      @render_frames[frame] ||= `dump-gnash -s1 --screenshot=#{frame} --screenshot-file #{filename} -1 -r1 --timeout 200 input.swf -j #{max_width} -k #{max_height}`
    end

    # returns the downloader
    def downloader
      @downloader ||= Downloader.new(swf_url)
    end

    # returns temp filename for given frame no.
    def frame_output_filename(frame)
      "#{Dir.tmpdir}/frame_#{Time.now.to_i}_#{frame}.png"
    end

  end
end
