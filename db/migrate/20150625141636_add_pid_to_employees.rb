class AddPidToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :pid, :integer
  end
end
