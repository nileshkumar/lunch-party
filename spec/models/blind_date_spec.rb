require 'rails_helper'

RSpec.describe BlindDate, type: :model do
  describe 'associations' do
    it { should belong_to(:leader).class_name('Employee') }
  end
end
