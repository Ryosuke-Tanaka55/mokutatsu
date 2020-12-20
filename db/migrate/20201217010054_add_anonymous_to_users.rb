class AddAnonymousToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :anonymous, :boolean, default: false, null: false
  end
end
