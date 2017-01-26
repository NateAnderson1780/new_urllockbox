require 'rails_helper'

RSpec.describe User, type: :model do
  context "associations" do
    it { should have_many :links }
  end
  
  context "validations" do
    it { should have_secure_password }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
  end

end
