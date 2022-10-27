class CreateEmployeeTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :employee_teams do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.date :lunch_date 
      
      t.timestamps
    end
  end
end
