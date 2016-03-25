class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :job_number
      t.string :job_name
      t.references :job_type, index: true
      t.float :bonus_rate

      t.timestamps null: false
    end
    add_foreign_key :jobs, :job_types
  end
end
