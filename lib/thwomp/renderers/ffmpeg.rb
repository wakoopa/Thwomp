module Thwomp

  module Renderers

    class FFMPEG
      include Renderers::Helper

      attr_reader :filename

      def initialize(filename)
        @filename = filename
      end

      def frames
        uuid = generate_uuid
        output_file_name = "#{Dir.tmpdir}/frame_#{uuid}_%d.png"

        Command.exec(
          executable,
          "-i", filename,
          "-f", "image2",
          "-r", "1",
          "-vf", "scale=640:-1",
          output_file_name
        )

        sort Dir.glob("#{Dir.tmpdir}/frame_#{uuid}_*.png")
      end

      def executable
        Thwomp.ffmpeg_path || "ffmpeg"
      end

    end

  end

end
