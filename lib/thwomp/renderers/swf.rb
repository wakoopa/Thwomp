require 'tmpdir'

module Thwomp

  # Renders SWF files
  module Renderers

    class SWF

      include Renderers::Helper

      attr_reader :filename, :frame_count, :width, :height

      def initialize(filename, options={})
        @filename = filename
        @frame_count = options.fetch(:frame_count) { 10 }
        @width = options.fetch(:width) { 500 }
        @height = options.fetch(:height) { 500 }
      end

      def frames
        uuid = generate_uuid

        Command.exec(
          executable,
          "-s1",
          "--screenshot=#{frame_batch}",
          "--screenshot-file=#{output_file(uuid)}",
          "-1",
          "-r1",
          "--timeout", "200",
          filename,
          "-j", width.to_s,
          "-k", height.to_s
        )

        sort Dir.glob("#{Dir.tmpdir}/frame_#{uuid}_*.png")
      end

      def frame_batch
        batch = ['last'] + (0..frame_count).to_a.reverse
        batch.join(',')
      end

      def output_file(uuid)
        "#{Dir.tmpdir}/frame_#{uuid}_%f.png"
      end

      def executable
        Thwomp.gnash_path || "gnash-dump"
      end

    end

  end
end
