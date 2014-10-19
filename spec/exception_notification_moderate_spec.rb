require 'spec_helper'

describe ExceptionNotifier do
  describe '.notify_exception' do
    subject { ExceptionNotifier.notify_exception(StandardError.new, {}) }
    it 'notify exception' do
      expect(subject).to be_truthy
    end

    context 'Same error in 60 seconds' do
      it '1st call, return true, 2nd call, return false' do
        expect(subject).to be_truthy
        expect(ExceptionNotifier.notify_exception(StandardError.new, {})).to be_falsy
      end
    end

    context 'Same error after 60 seconds' do
      it 'returns both true' do
        ExceptionNotifier.notify_exception(StandardError.new, {})
        Timecop.travel(Time.now + 60)
        expect(subject).to be_truthy
      end
    end
  end
end
