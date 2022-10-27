class EmployeeTeam < ApplicationRecord

  belongs_to :employee
  belongs_to :team

  validates :lunch_date, presence: true

  validate :check_team_member

  private

  def check_team_member
    employee = EmployeeTeam.find_by(team_id: team_id, employee_id: employee_id)
    errors.add('Error:', "This employee has been already added!") unless employee.nil?
  end
end
