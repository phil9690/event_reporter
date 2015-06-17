class RenameLoggedBy < ActiveRecord::Migration

  def self.up
    rename_column :events, :logged_by, :user_id
  end

end
