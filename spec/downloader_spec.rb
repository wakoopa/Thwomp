require 'spec_helper'
require 'thwomp'

module Thwomp

  describe Downloader do

    it 'should detect http url as remote' do
      Downloader.new('http://domain.com/file.swf').remote?.should == true
    end

    it 'should detect https url as remote' do
      Downloader.new('https://domain.com/file.swf').remote?.should == true
    end

    it 'should detect local path as local' do
      Downloader.new('/local/path.swf').local?.should == true
    end

  end

end
