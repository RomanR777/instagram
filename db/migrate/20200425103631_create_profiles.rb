class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.timestamps
    end
    add_reference :profiles, :user, foreign_key: true, index: { unique: true }
  end
end
