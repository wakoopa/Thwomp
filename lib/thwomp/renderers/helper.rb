module Thwomp

  module Renderers

    module Helper
      def sort(frames)
        frames.sort do |a, b|
          frame_number(File.basename(a)) <=> frame_number(File.basename(b))
        end
      end

      def frame_number(file_name)
        file_name.scan(/\d+/).last.to_i
      end

    end

  end

end
