class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.references :employee, index: true
      t.references :user, index: true
      t.references :job, index: true
      t.float :score
      t.integer :completes
      t.float :hours
      t.date :score_date

      t.timestamps null: false
    end
    add_foreign_key :scores, :employees
    add_foreign_key :scores, :users
    add_foreign_key :scores, :jobs
  end
end
