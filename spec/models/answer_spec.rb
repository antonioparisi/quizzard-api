require 'spec_helper'

describe Answer do
  describe 'validations' do
    [:title].each do |attr|
      it { should validate_presence_of(attr) }
    end
  end
end
