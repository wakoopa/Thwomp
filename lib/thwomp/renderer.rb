require 'tmpdir'

module Thwomp

  # Renders SWF files
  class Renderer

    attr_accessor :url, :max_width, :max_height, :max_frames

    DEFAULT_OPTIONS = { :max_width => 500,
                        :max_height => 500,
                        :max_frames => 10 }

    # Initializer the Thwomp renderer
    #
    # Options:
    #   :max_width        Maximum width of renderer
    #   :max_height       Maximum height of renderer
    #   :max_frames       Maximum number of frames the renderer can handle
    def initialize(url, options = {})
      DEFAULT_OPTIONS.merge(options).each { |k,v| send(:"#{k}=", v) if v }
      @url = url
    end

    # returns filename of frame
    def frame_filename(frame)
      frame_exists?(frame) ? @frame_filename[frame] : nil
    end

    # returns PNG data from given frame
    def png_data(frame)
      frame_exists?(frame) ? frame_data(frame) : nil
    end

    def frame_exists?(frame)
      render_frame!(frame)
      File.exists?(@frame_filename[frame])
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

    def frame_data(frame)
      File.open(@frame_filename[frame], 'rb') { |f| f.read }
    end

    # renders all the frames from the SWF file and dump them to a RAW file
    def render_frame!(frame)
      @frame_filename ||= {}

      unless @frame_filename[frame]
        @frame_filename[frame] = frame_output_filename(frame)

        clean_frame!(frame)

        `#{self.class.gnash_binary} -s1 --screenshot=#{frame} --screenshot-file #{@frame_filename[frame]} -1 -r1 --timeout 200 #{filename} -j #{max_width} -k #{max_height} --max-advances #{max_frames}`
      end

      @frame_filename[frame]
    end

    def clean_frame!(frame)
      File.unlink(@frame_filename[frame]) if File.exists?(@frame_filename[frame])
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
