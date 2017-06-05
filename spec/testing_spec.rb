require 'spec_helper'

RSpec.describe TwilioMock::Testing do
  describe 'enabled (default)' do
    it 'returns enabled' do
      expect(TwilioMock::Testing.enabled?).to be_truthy
      expect(TwilioMock::Testing.disabled?).to be_falsey
    end
  end

  describe 'disable' do
    it 'returns disabled' do
      TwilioMock::Testing.disable!
      expect(TwilioMock::Testing.disabled?).to be_truthy
      expect(TwilioMock::Testing.enabled?).to be_falsey
    end

    context 'with a block' do
      it 'returns disabled only inside the block' do
        TwilioMock::Testing.disable! do
          expect(TwilioMock::Testing.disabled?).to be_truthy
          expect(TwilioMock::Testing.enabled?).to be_falsey
        end
        expect(TwilioMock::Testing.enabled?).to be_truthy
        expect(TwilioMock::Testing.disabled?).to be_falsey
      end
    end
  end
end
