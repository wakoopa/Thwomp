module Thwomp

  module Renderers

    class FFMPEG
      include Renderers::Helper

      attr_reader :filename

      def initialize(url)
        @filename = Downloader.new(url).filename
      end

      def frames
        timestamp = Time.now.to_i
        output_file_name = "#{Dir.tmpdir}/frame_#{timestamp}_%d.png"

        system("#{executable} -i #{filename} -f image2 -r 1 -vf scale=128:-1 #{output_file_name} &> /dev/null")

        sort Dir.glob("#{Dir.tmpdir}/frame_#{timestamp}_*.png")
      end

      def executable
        Thwomp.ffmpeg_path || "ffmpeg"
      end

    end

  end

end
