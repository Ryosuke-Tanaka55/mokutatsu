class CreatePostImages < ActiveRecord::Migration[6.0]
  def change
    create_table :post_images do |t|
      t.string :post_image
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
