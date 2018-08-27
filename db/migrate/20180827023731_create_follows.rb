class CreateFollows < ActiveRecord::Migration[5.2]
  def change
    create_table :follows do |t|
      t.references :user, foreign_key: true
      t.integer :followed_id

      t.timestamps
    end
    add_index :follows, :followed_id
  end
end
