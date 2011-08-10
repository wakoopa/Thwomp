require 'spec_helper'
require 'thwomp'

describe Thwomp::ColorCounter do

  it 'sees that the image is significant' do
    subject = Thwomp::ColorCounter.new("#{File.dirname(__FILE__)}/fixtures/significant.png")
    subject.empty?.should == false
    subject.present?.should == true
  end

  it 'sees that image is insignificant' do
    subject = Thwomp::ColorCounter.new("#{File.dirname(__FILE__)}/fixtures/insignificant.png")
    subject.empty?.should == true
    subject.present?.should == false
  end

end
