require 'spec_helper'

describe ExceptionNotifier do
  subject { ExceptionNotifier.notify_exception(StandardError.new, {}) }
  describe 'notify_exception' do
    it 'notify exception' do
      expect(subject).to be_truthy
    end
  end
end
