json.extract! employee, :id, :name, :is_admin, :created_at, :updated_at
json.url employee_url(employee, format: :json)
