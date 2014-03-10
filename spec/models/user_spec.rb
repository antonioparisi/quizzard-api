require 'spec_helper'

describe User do
  describe 'validations' do
    [:email, :name, :lastname, :picture, :access_token].each do |attr|
      it { should validate_presence_of(attr) }
    end
  end
end
