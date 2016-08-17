require 'rails_helper'

describe Post do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:content) }


  describe '#filter_sensitive_word' do
    subject { described_class.new.send(:filter_sensitive_word) }

    before { allow_any_instance_of(described_class).to receive(:do_something_really_takes_time) }

    it 'returns blank string' do
      expect(subject).to be_blank
    end
  end
end
