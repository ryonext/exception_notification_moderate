require 'spec_helper'

describe ExceptionNotifier do
  describe '.notify_exception' do
    before do
      ExceptionNotificationModerate.configure do |config|
        config.redis_host = 'localhost'
        config.logger = Logger.new(STDOUT)
      end
    end

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

    context 'It cannot connect to Redis when setting params' do
      before do
        allow_any_instance_of(MockRedis).to receive(:set).and_raise(Redis::CannotConnectError)
      end
      it 'does not raise error' do
        expect { subject }.not_to raise_error
      end
    end

    context 'It cannot connect to Redis when getting params' do
      before do
        allow_any_instance_of(MockRedis).to receive(:get).and_raise(Redis::CannotConnectError)
      end
      it 'does not raise error' do
        expect { subject }.not_to raise_error
      end
    end
  end
end
