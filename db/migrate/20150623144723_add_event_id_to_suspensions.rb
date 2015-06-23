class AddEventIdToSuspensions < ActiveRecord::Migration
  def change
    add_column :suspensions, :event_id, :integer
  end
end
