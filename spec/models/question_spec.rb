require 'spec_helper'

describe Question do
  describe 'validations' do
    [:title, :correct_number].each do |attr|
      it { should validate_presence_of(attr) }
    end
  end
end
