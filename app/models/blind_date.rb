class BlindDate < ApplicationRecord

  belongs_to :leader, class_name: 'Employee', foreign_key: 'employee_id'
end
