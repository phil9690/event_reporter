class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :incident_type
      t.string :description
      t.references :employee, index: true

      t.timestamps null: false
    end
    add_foreign_key :events, :employees
  end
end
