class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :description
      t.timestamps
    end
    add_reference :posts, :user, foreign_key: true
  end
end
