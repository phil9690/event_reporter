class CreateSuspensions < ActiveRecord::Migration
  def change
    create_table :suspensions do |t|
      t.integer :employee_id

      t.timestamps null: false
    end
  end
end
