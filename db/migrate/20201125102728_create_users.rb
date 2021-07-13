class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, presence: true
      t.string :email, presence: true
      t.string :image
      t.text :introduction
      
      t.timestamps
      
    end
  end
end
