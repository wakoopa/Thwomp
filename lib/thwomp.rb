require 'thwomp/version'
require 'thwomp/renderer'
require 'thwomp/renderers/helper'
require 'thwomp/renderers/swf'
require 'thwomp/renderers/ffmpeg'
require 'thwomp/color_counter'
require 'thwomp/downloader'
require 'thwomp/thumbnail_picker'
require 'thwomp/thumbnail'
require 'thwomp/animation_preview'
require 'thwomp/command'

module Thwomp

  class << self

    attr_accessor :gnash_path, :ffmpeg_path

    def pick(url)
      renderer = Renderer.new(url)
      ThumbnailPicker.pick(renderer.frames.reverse)
    end

  end

end
