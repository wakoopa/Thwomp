module Thwomp
  # Downloads SWF files
  class Downloader
    attr_accessor :url

    def initialize(url)
      self.url = url
    end

    # tests if the given file remote
    def remote?
      !!(url =~ /^http(s)?:/)
    end

    # tests if the given file is local
    def local?
      !remote?
    end

    # returns filename of local/remote file
    def filename
      local?? url : tmp_file.path
    end

    private

    def download!
      @download ||= tmp_file.write(response)
    end

    def tmp_file
      @tmp_file ||= Tempfile.new('thwomp')
    end

    def response
      @response ||= http.get(url)
    end

  end
end
