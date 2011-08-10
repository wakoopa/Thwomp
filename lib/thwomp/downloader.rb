module Thwomp
  # Downloads SWF files
  class Downloader < Struct.new(:swf_url)

    # tests if the given file remote
    def remote?
      swf_url ~= /^http(s)?::/
    end

    # tests if the given file is local
    def local?
      !remote?
    end

    # returns filename of local/remote file
    def filename
      local? swf_url : tmp_file.path
    end

    private

    def download!
      @download ||= tmp_file.write(response)
    end

    def tmp_file
      @tmp_file ||= Tempfile.new('thwomp')
    end

    def response
      @response ||= http.get(swf_url)
    end

  end
end
