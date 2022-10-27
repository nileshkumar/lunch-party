Team.destroy_all
5.times do 
  Team.create!({
    name: Faker::Team.name 
  })
end
p "Created #{Team.count} Teams"

p "----------------------------------------------"

Employee.destroy_all
5.times do 
  Employee.create!({
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name, 
    is_admin: false
  })
end
p "Created #{Employee.count} Employees"

p "--Admin Created--"
Employee.last.update(is_admin: true)

p "----------------------------------------------"

EmployeeTeam.destroy_all
1.upto(5) do |i|
  EmployeeTeam.create!({
    employee_id: i,
    team_id: i, 
    lunch_date: Faker::Date.in_date_period
  })
end
p "Created #{EmployeeTeam.count} EmployeeTeam mappings"

p "----------------------------------------------"

