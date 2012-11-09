require 'tmpdir'

module Thwomp

  # Renders SWF files
  module Renderers

    class SWF

      include Renderers::Helper

      attr_reader :filename, :frame_count, :width, :height

      def initialize(url, options={})
        @filename = Downloader.new(url).filename
        @frame_count = options.fetch(:frame_count) { 10 }
        @width = options.fetch(:width) { 500 }
        @height = options.fetch(:height) { 500 }
      end

      def frames
        timestamp = Time.now.to_i

        Command.exec(
          "gnash -s1 --screenshot=#{frame_batch}" \
          " --screenshot-file=#{output_file(timestamp)}" \
          " -1 -r1 --timeout 200 #{filename} -j #{width}" \
          " -k #{height} > /dev/null 2>&1"
        )

        sort Dir.glob("#{Dir.tmpdir}/frame_#{timestamp}_*.png")
      end

      def frame(number)
        # TODO: return single frame
      end

      def frame_batch
        batch = ['last'] + (0..frame_count).to_a.reverse
        batch.join(',')
      end

      def output_file(timestamp)
        "#{Dir.tmpdir}/frame_#{timestamp}_%f.png"
      end

    end

  end
end
