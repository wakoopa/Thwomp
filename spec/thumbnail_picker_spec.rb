require 'spec_helper'

module Thwomp

  describe ThumbnailPicker do

    it 'raises error when no suitable frames are supplied' do
      expect {
        ThumbnailPicker.pick([])
      }.to raise_error(Thwomp::NoSuitableFramesFoundError)
    end

    it 'should pick first suitable frame' do
      frames = %w( frame1 frame2 )

      expect(ColorCounter).to receive(:new).with('frame1').and_return(double('valid_png?' => false, 'present?' => false))
      expect(ColorCounter).to receive(:new).with('frame2').and_return(double('valid_png?' => true,  'present?' => true))

      expect(Thumbnail).to receive(:generate!).with('frame2')

      ThumbnailPicker.pick(frames)
    end

  end

end
