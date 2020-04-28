class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string :content
      t.references :post, null: false
      t.references :user, null: false
      t.timestamps
    end
  end
end
