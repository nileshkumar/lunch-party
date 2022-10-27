class CreateBlindDates < ActiveRecord::Migration[7.0]
  def change
    create_table :blind_dates do |t|
      t.date :selected_date
      t.belongs_to :employee, index: { unique: true }, foreign_key: true

      t.timestamps
    end
  end
end
