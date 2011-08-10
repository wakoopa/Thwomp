require 'tmpdir'

module Thwomp
  # Renders SWF files
  class Renderer

    attr_accessor :url, :max_width, :max_height

    # Initializer the Thwomp renderer
    #
    # Options:
    #   :max_width   Maximum width of renderer
    #   :max_height  Maximum height of renderer
    def initialize(url, options = {})
      default_options.merge(options).each { |k,v| send(:"#{k}=", v) if v }
      @url = url
    end

    def default_options
      { :max_width => 500,
        :max_height => 500 }
    end

    # returns filename of frame
    def frame_filename(frame)
      render_frame!(frame) && @frame_filename[frame]
    end

    # returns PNG data from given frame
    def png_data(frame)
      render_frame!(frame) && File.open(frame_filename(frame), 'rb') { |f| f.read }
    end

    # returns the current set gnash binary
    def self.gnash_binary
      @gnash_binary ||= 'gnash-dump'
    end

    # sets the path to the gnash binary
    def self.gnash_binary=(binary)
      @gnash_binary = binary
    end

    private

    # renders all the frames from the SWF file and dump them to a RAW file
    def render_frame!(frame)
      @frame_filename ||= {}

      unless @frame_filename[frame]
        @frame_filename[frame] = frame_output_filename(frame)
        `#{self.class.gnash_binary} -s1 --screenshot=#{frame} --screenshot-file #{@frame_filename[frame]} -1 -r1 --timeout 200 #{filename} -j #{max_width} -k #{max_height}`
      end

      @frame_filename[frame]
    end

    def filename
      downloader.filename
    end

    # returns the downloader
    def downloader
      @downloader ||= Downloader.new(url)
    end

    # returns temp filename for given frame no.
    def frame_output_filename(frame)
      "#{Dir.tmpdir}/frame_#{Time.now.to_i}_#{frame}.png"
    end

  end
end
