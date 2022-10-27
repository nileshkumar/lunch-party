class Employee < ApplicationRecord

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :employee_teams
  has_many :teams, through: :employee_teams

  has_one :blind_date

  def name
    "#{first_name } #{last_name}"
  end
end
