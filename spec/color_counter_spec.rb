require 'spec_helper'
require 'thwomp'

describe Thwomp::ColorCounter do

  it 'sees that the image is significant' do
    subject = Thwomp::ColorCounter.new("#{File.dirname(__FILE__)}/fixtures/significant.png")
    expect(subject.empty?).to eq(false)
    expect(subject.present?).to eq(true)
  end

  it 'sees that image is insignificant' do
    subject = Thwomp::ColorCounter.new("#{File.dirname(__FILE__)}/fixtures/insignificant.png")
    expect(subject.empty?).to eq(true)
    expect(subject.present?).to eq(false)
  end

end
