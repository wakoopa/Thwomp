require 'spec_helper'

module Thwomp

  describe ThumbnailPicker do

    it 'raises error when no suitable frames are supplied' do
      lambda {
        ThumbnailPicker.pick([])
      }.should raise_error(Thwomp::NoSuitableFramesFoundError)
    end

    it 'should pick first suitable frame' do
      frames = %w( frame1 frame2 )

      ColorCounter.should_receive(:new).with('frame1').and_return(double('valid_png?' => false, 'present?' => false))
      ColorCounter.should_receive(:new).with('frame2').and_return(double('valid_png?' => true,  'present?' => true))

      Thumbnail.should_receive(:generate!).with('frame2')

      ThumbnailPicker.pick(frames)
    end

  end

end
