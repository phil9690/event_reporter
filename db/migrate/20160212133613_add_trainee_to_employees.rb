class AddTraineeToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :trainee, :boolean
  end
end
