module Thwomp

  class Renderer

    def self.new(*args)
      url = args.first

      if url.match(/\.swf$/)
        Renderers::SWF.new(*args)
      else
        Renderers::FFMPEG.new(*args)
      end
    end

  end

end
