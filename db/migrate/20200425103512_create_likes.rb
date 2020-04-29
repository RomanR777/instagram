class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.references :post, null: false
      t.references :user, null: false
      t.timestamps
    end
  end
end
