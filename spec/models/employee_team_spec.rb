require 'rails_helper'

RSpec.describe EmployeeTeam, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:lunch_date) }
  end

  describe 'associations' do
    it { should belong_to(:employee).class_name('Employee') }
    it { should belong_to(:team).class_name('Team') }
  end
end
